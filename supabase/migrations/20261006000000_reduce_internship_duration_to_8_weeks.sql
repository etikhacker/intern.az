-- Internship programs are now two months / eight weeks.
UPDATE public.internships
SET duration_weeks = 8, updated_at = NOW()
WHERE duration_weeks = 10;

-- Ten tasks fit into an eight-week program; final tasks share week 8.
UPDATE public.internship_tasks
SET week_number = 8, updated_at = NOW()
WHERE week_number > 8;
