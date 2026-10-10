BEGIN;

UPDATE public.internship_tasks SET instructions = $w2$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Webhook gələndə sadə workflow başladan avtomatlaşdırma quracaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Task 1-dəki öz workflow xəritən, JSON, HTTP request və webhook anlayışları. Ödənişli servis yoxdursa, lokal webhook/mock endpoint istifadə et.

## 3. Addım-addım təlimat
1. Öz automation repo-nu və ya workflow faylını davam etdir; intern.az repo-sunu təqdim etmə.
2. Sintetik event JSON-u müəyyən et.
3. Webhook qəbul edən lokal endpoint və ya mock trigger qur.
4. Input-u yoxla, sonra workflow-da iki sadə addım icra et.
5. Invalid JSON və təkrar event hallarını test et.
6. Trigger → action axınını diaqram və README ilə izah et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin və ya export edilən workflow, nümunə event, test nəticələri və axın diaqramı. Secret və real şəxsi məlumat işlətmə.
[[EN]]
## 1. What is this task for?
Build an automation workflow that starts when a webhook event arrives.

## 2. What should you know first?
Your workflow map from Task 1, JSON, HTTP requests, and webhooks. Use a local webhook/mock endpoint if no paid service is available.

## 3. Step-by-step instructions
1. Continue your own automation repository or workflow file; do not submit the intern.az repository.
2. Define a synthetic event JSON.
3. Set up a local endpoint or mock trigger to receive the webhook.
4. Validate the input, then perform two simple workflow actions.
5. Test invalid JSON and duplicate events.
6. Explain the trigger-to-action flow with a diagram and README.

## 4. What to submit
Your own GitHub repository or exported workflow, sample event, test results, and flow diagram. Do not use secrets or real personal data.$w2$ WHERE id='b5000000-0000-4000-8000-000000000002'::uuid AND task_number=2 AND status='published';

UPDATE public.internship_tasks SET instructions = $w3$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Workflow-da müvəqqəti xətaları idarə edəcək, retry və monitorinq əlavə edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz webhook workflow-n, error handling, retry və log anlayışları.

## 3. Addım-addım təlimat
1. Öz automation layihəni davam etdir.
2. Uğurlu cavab, timeout və müvəqqəti server xətası üçün mock addım yarat.
3. Məhdud retry sayı və artan gözləmə müddəti təyin et.
4. Daimi validation xətasında sonsuz retry etmə.
5. Hər icra üçün run ID, status və müddət qeyd et; secret və payload-da şəxsi məlumat loglama.
6. Uğurlu, uğursuz və retry ssenarilərini test et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin/workflow export-u, retry qaydası, log nümunələri və ən azı 3 ssenarinin test nəticəsi. Workflow sonsuz təkrar etməməlidir.
[[EN]]
## 1. What is this task for?
Handle temporary workflow failures with retry logic and monitoring.

## 2. What should you know first?
Your webhook workflow, error handling, retries, and logging.

## 3. Step-by-step instructions
1. Continue your own automation project.
2. Mock success, timeout, and temporary server-error steps.
3. Set a limited retry count and increasing delay.
4. Do not retry permanent validation errors forever.
5. Record run ID, status, and duration; never log secrets or personal payload data.
6. Test success, failure, and retry scenarios.

## 4. What to submit
Your own GitHub repository/workflow export, retry rules, log examples, and results for at least three scenarios. The workflow must never retry indefinitely.$w3$ WHERE id='b5000000-0000-4000-8000-000000000003'::uuid AND task_number=3 AND status='published';

UPDATE public.internship_tasks SET instructions = $w4$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Bir biznes prosesini başlanğıcdan sona qədər avtomatlaşdırıb nəticəni ölçülə bilən case study kimi təqdim edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz Task 1–3 workflow-ların, data transformation, retry və log əsasları. Ödənişli inteqrasiya tələb olunmur; mock alternativ qəbul edilir.

## 3. Addım-addım təlimat
1. Əvvəlki automation işlərini öz repo/workflow faylında birləşdir; intern.az repo-sunu təqdim etmə.
2. Trigger, input, əsas addımlar, error path və output-u təsvir et.
3. Input validation, retry limit və duplicate event qoruması əlavə et.
4. Ən azı 5 sintetik event ilə workflow-u test et.
5. Müddət, uğur faizi və manual addımların azalması kimi ölçüləri hesabla; təxminləri ayrıca qeyd et.
6. Quraşdırma, məhdudiyyətlər və növbəti addımları yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin/workflow export-u, diaqram, test nəticələri, ölçülər və case-study hesabatı. Uğur rəqəmləri real ölçü və ya təxmin kimi açıq işarələnməlidir.
[[EN]]
## 1. What is this task for?
Automate a business process end to end and present the result as a measurable case study.

## 2. What should you know first?
Your workflows from Tasks 1–3, data transformation, retries, and logging. A paid integration is not required; a mock is acceptable.

## 3. Step-by-step instructions
1. Combine earlier automation work in your own repository/workflow; do not submit the intern.az repository.
2. Describe the trigger, input, main steps, error path, and output.
3. Add input validation, retry limits, and duplicate-event protection.
4. Test the workflow with at least five synthetic events.
5. Measure duration, success rate, and manual steps reduced; label estimates separately.
6. Document setup, limitations, and next steps.

## 4. What to submit
Your own GitHub repository/workflow export, diagram, test results, metrics, and case-study report. Clearly label results as measured or estimated.$w4$ WHERE id='b5000000-0000-4000-8000-000000000004'::uuid AND task_number=4 AND status='published';

UPDATE public.internship_tasks SET instructions = $w5$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Workflow-a daxil olan qarışıq JSON məlumatını sabit formata çevirəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz automation layihən, JSON, mapping və input validation əsasları.

## 3. Addım-addım təlimat
1. Öz workflow repo-nu davam etdir.
2. Müxtəlif formatda ən azı 10 sintetik input nümunəsi yarat.
3. Hədəf JSON schema və tələb olunan sahələri müəyyən et.
4. Mapping, default dəyərlər və invalid input davranışını yaz.
5. Orijinal input-u dəyişmədən saxla və transform edilmiş nəticəni ayrıca göstər.
6. Valid/invalid nümunələr üçün test yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, mapping qaydaları, 10+ input nümunəsi, transform edilmiş nəticələr və testlər. Məlumat itkisi və default qərarları sənədləşdirilməlidir.
[[EN]]
## 1. What is this task for?
Transform inconsistent incoming JSON into a consistent format.

## 2. What should you know first?
Your automation project, JSON, mapping, and input-validation basics.

## 3. Step-by-step instructions
1. Continue your own workflow repository.
2. Create at least ten synthetic inputs with different formats.
3. Define the target JSON schema and required fields.
4. Specify mapping, default values, and invalid-input behavior.
5. Keep original input unchanged and show transformed output separately.
6. Write tests for valid and invalid examples.

## 4. What to submit
Your own GitHub repository link, mapping rules, ten or more inputs, transformed outputs, and tests. Document data-loss risks and default-value decisions.$w5$ WHERE id='1e9069de-6929-416a-ac23-d3eeb377d539'::uuid AND task_number=5 AND status='published';

UPDATE public.internship_tasks SET instructions = $w6$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Workflow-u API ilə əlaqələndirib nəticəni növbəti addıma ötürəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz automation repo-n, HTTP request, JSON, API status code və secret idarəetməsi.

## 3. Addım-addım təlimat
1. Öz layihəni davam etdir.
2. Real xidmətə ehtiyac olmadan mock API endpoint hazırla.
3. Request body və gözlənilən response schema-nı müəyyən et.
4. Timeout, 4xx, 5xx və uğurlu cavab davranışını qur.
5. API key istifadə edilirsə, onu environment secret kimi saxla; repo-ya yazma.
6. Mock cavablarla success/error testləri işə sal.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin/workflow export-u, API contract, mock endpoint və test nəticələri. Token və API key loglarda və repo-da olmamalıdır.
[[EN]]
## 1. What is this task for?
Connect your workflow to an API and pass its response to the next step.

## 2. What should you know first?
Your automation repository, HTTP requests, JSON, API status codes, and secret management.

## 3. Step-by-step instructions
1. Continue your own project.
2. Prepare a mock API endpoint that does not require a real external service.
3. Define the request body and expected response schema.
4. Handle timeout, 4xx, 5xx, and successful responses.
5. If an API key is needed, store it as an environment secret; never commit it.
6. Run success/error tests with mock responses.

## 4. What to submit
Your own GitHub repository/workflow export, API contract, mock endpoint, and test results. Tokens and API keys must not appear in logs or the repository.$w6$ WHERE id='8d162c74-bab3-46f3-96c4-8259406a9f76'::uuid AND task_number=6 AND status='published';

UPDATE public.internship_tasks SET instructions = $w7$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Workflow-u müəyyən vaxtda və ya intervalda avtomatik başladacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz automation layihən, cron/schedule anlayışı və idempotency əsasları. Ödənişli scheduler yoxdursa, lokal planı və simulyasiyanı sənədləşdir.

## 3. Addım-addım təlimat
1. Öz workflow repo-nu davam etdir.
2. İşə düşmə intervalını və timezone-u dəqiq yaz.
3. Schedule trigger əlavə et və işləmə tarixini logla.
4. Eyni interval iki dəfə işə düşərsə dublikat nəticənin qarşısını al.
5. Uğurlu run, missed run və retry ssenarilərini yoxla.
6. Manual run və dayandırma qaydasını README-də sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin/workflow export-u, schedule konfiqurasiyası, timezone qeydi, run log-ları və testlər. Dublikat icra idarə olunmalıdır.
[[EN]]
## 1. What is this task for?
Run a workflow automatically at a specified time or interval.

## 2. What should you know first?
Your automation project, scheduling/cron concepts, and idempotency. If no paid scheduler is available, document a local plan and simulation.

## 3. Step-by-step instructions
1. Continue your own workflow repository.
2. Specify the interval and timezone clearly.
3. Add a scheduled trigger and log each run time.
4. Prevent duplicate results if a schedule fires twice.
5. Check successful runs, missed runs, and retry scenarios.
6. Document manual execution and how to disable the schedule in the README.

## 4. What to submit
Your own GitHub repository/workflow export, schedule configuration, timezone note, run logs, and tests. Duplicate execution must be handled.$w7$ WHERE id='fb192a4f-3d1e-401a-9580-ab9c37077eb4'::uuid AND task_number=7 AND status='published';

UPDATE public.internship_tasks SET instructions = $w8$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Workflow tamamlananda və ya xəta verəndə uyğun bildiriş göndərəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz automation layihən, workflow statusları və bildiriş kanalı. Real email/chat hesabı yoxdursa, mock notification istifadə et.

## 3. Addım-addım təlimat
1. Öz layihəni davam etdir.
2. Success və failure üçün bildiriş qaydaları yaz.
3. Mesajda run ID, status və təhlükəsiz xəta xülasəsi göstər.
4. Şəxsi məlumat, token və tam payload göndərmə.
5. Eyni event üçün təkrar bildirişləri məhdudlaşdır.
6. Uğurlu, uğursuz və notification provider xətası üçün test yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin/workflow export-u, mesaj şablonları, mock bildirişlər və testlər. Bildirişlər həssas məlumat sızdırmamalıdır.
[[EN]]
## 1. What is this task for?
Send a suitable notification when a workflow succeeds or fails.

## 2. What should you know first?
Your automation project, workflow states, and notification channel. Use mock notifications if no real email/chat account is available.

## 3. Step-by-step instructions
1. Continue your own project.
2. Define notification rules for success and failure.
3. Include run ID, status, and a safe error summary.
4. Do not send personal data, tokens, or full payloads.
5. Limit duplicate notifications for the same event.
6. Test success, failure, and notification-provider errors.

## 4. What to submit
Your own GitHub repository/workflow export, message templates, mock notifications, and tests. Notifications must not leak sensitive data.$w8$ WHERE id='2370b498-e00d-424b-bbaa-d24eda48c62b'::uuid AND task_number=8 AND status='published';

UPDATE public.internship_tasks SET instructions = $w9$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Avtomatlaşdırmanın effektivliyini ölçən göstəricilər hazırlayıb nəticəni əvvəlcədən müəyyən edilmiş meyarlarla qiymətləndirəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz workflow run log-ları, duration, success/failure və manual effort anlayışları. Real ölçü yoxdursa, simulyasiyanı ayrıca işarələ.

## 3. Addım-addım təlimat
1. Öz automation repo-nu davam etdir.
2. 10+ sintetik run nəticəsi hazırla və ya mövcud run-ları export et.
3. Uğur faizi, orta müddət, retry sayı və manual addımların sayını hesabla.
4. Əvvəlcədən uğur meyarı təyin et və nəticə ilə müqayisə et.
5. Zəif nəticənin səbəbini və növbəti yaxşılaşdırmanı izah et.
6. Ölçmə formulalarını README-də sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, metrics cədvəli/diaqramı, formulalar və nəticə hesabatı. Simulyasiya olunan rəqəmlər real production göstəricisi kimi təqdim edilməməlidir.
[[EN]]
## 1. What is this task for?
Measure automation effectiveness and evaluate it against predefined criteria.

## 2. What should you know first?
Your workflow run logs, duration, success/failure, and manual-effort concepts. Clearly label simulated data.

## 3. Step-by-step instructions
1. Continue your own automation repository.
2. Prepare ten or more synthetic run results or export existing runs.
3. Calculate success rate, average duration, retry count, and manual steps.
4. Define success criteria in advance and compare the results.
5. Explain poor results and the next improvement.
6. Document metric formulas in the README.

## 4. What to submit
Your own GitHub repository link, metrics table/chart, formulas, and report. Simulated values must not be presented as real production metrics.$w9$ WHERE id='26cbc5fa-2687-4126-b113-7311bfa0267a'::uuid AND task_number=9 AND status='published';

UPDATE public.internship_tasks SET instructions = $w10$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Workflow-u başqa şəxsin qura, yoxlaya və davam etdirə bilməsi üçün texniki təhvil paketi hazırlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz Task 1–9 workflow-ların, konfiqurasiya, error handling, monitoring və testlər.

## 3. Addım-addım təlimat
1. Əvvəlki automation layihəni öz repo/workflow faylında davam etdir.
2. Setup, trigger, environment dəyişənləri və manual run qaydasını yaz.
3. Workflow diaqramı, data mapping, retry və notification qaydalarını sənədləşdir.
4. Test nəticələri, metriklər, məlum məhdudiyyətlər və failure recovery-ni əlavə et.
5. Secret-ləri çıxar və təmiz mühitdə quraşdırma təlimatını yoxla.
6. Növbəti 3 yaxşılaşdırmanı prioritetləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin/workflow export-u, README, diaqram, test/metrics hesabatı və növbəti addımlar. Başqa şəxs təlimatla workflow-u yenidən qura bilməlidir.
[[EN]]
## 1. What is this task for?
Prepare a handoff package so another person can set up, verify, and maintain your workflow.

## 2. What should you know first?
Your workflow artifacts from Tasks 1–9, configuration, error handling, monitoring, and tests.

## 3. Step-by-step instructions
1. Continue your earlier automation project in your own repository/workflow file.
2. Document setup, triggers, environment variables, and manual execution.
3. Document the workflow diagram, data mapping, retries, and notifications.
4. Include test results, metrics, limitations, and failure recovery.
5. Remove secrets and verify the setup instructions in a clean environment.
6. Prioritize the next three improvements.

## 4. What to submit
Your own GitHub repository/workflow export, README, diagram, test/metrics report, and next steps. Another person must be able to recreate the workflow from the instructions.$w10$ WHERE id='a8a0281c-11d6-45d3-94c0-41cf994d284d'::uuid AND task_number=10 AND status='published';

COMMIT;
