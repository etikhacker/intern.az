-- Compact application migration for the 10-task tracks and deadline automation.
DO $$
DECLARE
  track RECORD;
  i integer;
  titles text[];
  types text[];
  tid uuid;
BEGIN
  FOR track IN SELECT * FROM (VALUES
    ('a1000000-0000-4000-8000-000000000001'::uuid, ARRAY['Accessible Form Flow','State Management','Performance Pass','Frontend Testing','Code Review Fixes','Frontend Handoff']::text[]),
    ('a1000000-0000-4000-8000-000000000002'::uuid, ARRAY['Pagination and Filtering','Database Transactions','API Documentation','Backend Testing','Logging and Errors','Backend Deployment']::text[]),
    ('a1000000-0000-4000-8000-000000000003'::uuid, ARRAY['Data Validation','Exploratory Analysis','Cohort Analysis','Dashboard Review','Data Storytelling','Reproducible Analysis']::text[]),
    ('a1000000-0000-4000-8000-000000000004'::uuid, ARRAY['Prompt Failure Cases','Tool Calling Prototype','RAG Quality Tuning','Guardrails','Cost and Latency','AI Product Handoff']::text[]),
    ('a1000000-0000-4000-8000-000000000005'::uuid, ARRAY['Data Transformation','API Integration','Scheduled Workflow','Notification Flow','Automation Metrics','Automation Case Handoff']::text[])
  ) AS t(internship_id,titles)
  LOOP
    FOR i IN 1..6 LOOP
      INSERT INTO public.internship_tasks (id, internship_id, title, description, instructions, week_number, task_number, difficulty, submission_type, is_required, status)
      VALUES (gen_random_uuid(), track.internship_id, track.titles[i], 'Praktik istiqamət tapşırığı: ' || track.titles[i] || '.', 'Tapşırığı tamamla, nəticəni README-də izah et və tələb olunan linki və ya faylı təqdim et.', 4 + ((i-1)/2), 4+i, (CASE WHEN i < 4 THEN 'intermediate' ELSE 'advanced' END)::task_difficulty, (CASE WHEN i IN (2,4) THEN 'github' ELSE 'multiple' END)::task_submission_type, true, 'published')
      ON CONFLICT DO NOTHING;
    END LOOP;
  END LOOP;

  FOR track IN SELECT * FROM (VALUES
    ('a1000000-0000-4000-8000-000000000006'::uuid,'Mobile Development'::text,ARRAY['Expo Setup','Navigation Flow','Reusable Mobile Components','API Mobile List','Search and Filter','Local Storage','Form Validation','Offline State','Mobile UX Test','Final Mobile App']::text[]),
    ('a1000000-0000-4000-8000-000000000007'::uuid,'UI/UX Design'::text,ARRAY['User Interview Plan','User Flow','Low-Fidelity Wireframe','High-Fidelity Screens','Design System','Prototype Interaction','Accessibility Review','Responsive Adaptation','UX Usability Test','Final UX Case Study']::text[]),
    ('a1000000-0000-4000-8000-000000000008'::uuid,'Cybersecurity'::text,ARRAY['Security Lab Setup','HTTP and Headers','XSS Awareness','SQL Injection Awareness','Access Control Review','JWT Review','API Security Checklist','ZAP Passive Scan','Secure Coding Fixes','Final Security Report']::text[])
  ) AS t(internship_id,track_name,titles)
  LOOP
    FOR i IN 1..10 LOOP
      INSERT INTO public.internship_tasks (id, internship_id, title, description, instructions, week_number, task_number, difficulty, submission_type, is_required, status)
      VALUES (gen_random_uuid(), track.internship_id, track.titles[i], track.track_name || ' üzrə praktik tapşırıq.', 'Yalnız pulsuz və ya lokal alətlərdən istifadə et. Nəticəni README, PDF, screenshot və ya demo linki ilə təqdim et.', i, i, (CASE WHEN i <= 3 THEN 'beginner' WHEN i <= 7 THEN 'intermediate' ELSE 'advanced' END)::task_difficulty, (CASE WHEN i IN (1,3,7,9) THEN 'file' WHEN i IN (2,5) THEN 'github' ELSE 'multiple' END)::task_submission_type, true, 'published')
      ON CONFLICT DO NOTHING;
    END LOOP;
  END LOOP;
END $$;

CREATE TABLE IF NOT EXISTS public.deadline_notifications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(), student_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE, enrollment_id uuid NOT NULL REFERENCES public.enrollments(id) ON DELETE CASCADE, task_id uuid NOT NULL REFERENCES public.internship_tasks(id) ON DELETE CASCADE, kind text NOT NULL CHECK (kind IN ('deadline_warning','deadline_expired')), message text NOT NULL, read_at timestamptz, created_at timestamptz NOT NULL DEFAULT now(), UNIQUE(student_id, task_id, kind)
);
ALTER TABLE public.deadline_notifications ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Students can view own deadline notifications" ON public.deadline_notifications;
CREATE POLICY "Students can view own deadline notifications" ON public.deadline_notifications FOR SELECT USING (student_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));
DROP POLICY IF EXISTS "Students can mark own deadline notifications read" ON public.deadline_notifications;
CREATE POLICY "Students can mark own deadline notifications read" ON public.deadline_notifications FOR UPDATE USING (student_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid())) WITH CHECK (student_id IN (SELECT id FROM public.profiles WHERE user_id = auth.uid()));

CREATE OR REPLACE FUNCTION public.process_internship_deadlines()
RETURNS jsonb LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$fn$
DECLARE warnings integer := 0; cancelled integer := 0;
BEGIN
  INSERT INTO public.deadline_notifications(student_id,enrollment_id,task_id,kind,message)
  SELECT e.student_id,e.id,t.id,'deadline_warning','Tapşırığın son təhvil tarixinə 3 gün və ya daha az qalıb: '||t.title FROM public.enrollments e JOIN public.internship_tasks t ON t.internship_id=e.internship_id AND t.status='published' AND t.deadline IS NOT NULL LEFT JOIN public.task_submissions s ON s.task_id=t.id AND s.student_id=e.student_id AND s.status='approved' WHERE e.status='active' AND s.id IS NULL AND t.deadline>now() AND t.deadline<=now()+interval '3 days' ON CONFLICT DO NOTHING;
  GET DIAGNOSTICS warnings = ROW_COUNT;
  INSERT INTO public.deadline_notifications(student_id,enrollment_id,task_id,kind,message)
  SELECT e.student_id,e.id,t.id,'deadline_expired','Deadline keçdiyi üçün internship proqramından çıxarıldınız: '||t.title FROM public.enrollments e JOIN public.internship_tasks t ON t.internship_id=e.internship_id AND t.status='published' AND t.deadline IS NOT NULL LEFT JOIN public.task_submissions s ON s.task_id=t.id AND s.student_id=e.student_id AND s.status='approved' WHERE e.status='active' AND s.id IS NULL AND t.deadline<now() ON CONFLICT DO NOTHING;
  UPDATE public.enrollments e SET status='cancelled',updated_at=now() WHERE e.status='active' AND EXISTS (SELECT 1 FROM public.internship_tasks t LEFT JOIN public.task_submissions s ON s.task_id=t.id AND s.student_id=e.student_id AND s.status='approved' WHERE t.internship_id=e.internship_id AND t.status='published' AND t.is_required AND t.deadline IS NOT NULL AND t.deadline<now() AND s.id IS NULL);
  GET DIAGNOSTICS cancelled = ROW_COUNT;
  RETURN jsonb_build_object('warnings_created',warnings,'enrollments_cancelled',cancelled);
END;
$fn$;
REVOKE ALL ON FUNCTION public.process_internship_deadlines() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.process_internship_deadlines() TO service_role;
