BEGIN;

UPDATE public.internship_tasks SET instructions = $a2$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Sənədlərdən cavab verən sadə AI prototipi quracaqsan və cavabın hansı mətn hissəsinə əsaslandığını göstərəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Task 1-dəki öz AI repo-n, Python əsasları və prompt/JSON anlayışları. API açarın yoxdursa, mock model cavabı ilə interfeysi qur; real şəxsi sənəd yükləmə.

## 3. Addım-addım təlimat
1. Öz AI repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. İctimai və ya uydurma mətnlərdən 3–5 qısa sənəd hazırla.
3. Sənədləri kiçik hissələrə böl və sadə axtarışla uyğun hissəni tap.
4. Sual, tapılmış hissə və cavab üçün aydın data formatı qur.
5. Cavabda mənbə hissəsini göstər; uyğun məlumat tapılmırsa, bunu açıq de.
6. Ən azı 8 sual ilə yoxla və nəticələri qeyd et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işləyən lokal prototip və ya mock, nümunə sənədlər, 8 suallıq test cədvəli və mənbə göstərmə davranışının screenshot-u. Uydurma cavabı fakt kimi təqdim etmə.
[[EN]]
## 1. What is this task for?
Build a simple AI prototype that answers questions from documents and shows which text supports each answer.

## 2. What should you know first?
Your own AI repository from Task 1, Python basics, and prompt/JSON concepts. If you have no API key, build the interface with a mock model response; do not upload private documents.

## 3. Step-by-step instructions
1. Continue your own AI repository; do not submit the intern.az repository.
2. Prepare three to five short public or fictional documents.
3. Split documents into small chunks and find relevant chunks with simple search.
4. Define clear data formats for the question, retrieved chunk, and answer.
5. Show the supporting source in each answer; say clearly when no relevant information is found.
6. Test with at least eight questions and record the results.

## 4. What to submit
Your own GitHub repository link, working local prototype or mock, sample documents, an eight-question test table, and a screenshot showing source attribution. Do not present invented answers as facts.$a2$ WHERE id='b4000000-0000-4000-8000-000000000002'::uuid AND task_number=2 AND status='published';

UPDATE public.internship_tasks SET instructions = $a3$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
AI cavablarının nə dərəcədə düzgün və faydalı olduğunu sistemli testlərlə ölçəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz AI prototipin, Task 2-dəki sənədlər və gözlənilən cavablar. Real istifadəçi məlumatı yox, sintetik suallar istifadə et.

## 3. Addım-addım təlimat
1. Öz AI repo-nu davam etdir.
2. Müxtəlif tipli ən azı 20 sual hazırla: cavabı olan, cavabı olmayan, qeyri-müəyyən və əlaqəsiz.
3. Hər sual üçün gözlənilən cavabın əsas fikrini və mənbəni yaz.
4. Model cavabını düzgünlük, mənbəyə uyğunluq və faydalılıq üzrə qiymətləndir.
5. Səhvləri kateqoriyalara böl və ən çox təkrarlanan 3 problemi seç.
6. Bir prompt/retrieval düzəlişi et və əvvəl/sonra nəticələrini müqayisə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, 20+ testlik qiymətləndirmə cədvəli, scoring qaydası, 3 əsas səhv və bir yaxşılaşdırmanın müqayisəsi. Ölçülməyən nəticəni iddia etmə.
[[EN]]
## 1. What is this task for?
Measure AI answer quality systematically with repeatable tests.

## 2. What should you know first?
Your AI prototype, documents from Task 2, and expected answers. Use synthetic questions, not real user data.

## 3. Step-by-step instructions
1. Continue your own AI repository.
2. Prepare at least 20 questions: answerable, unanswerable, ambiguous, and unrelated.
3. Record the expected key point and source for each question.
4. Score model answers for correctness, source alignment, and usefulness.
5. Group failures and identify the three most frequent problems.
6. Make one prompt/retrieval improvement and compare before/after results.

## 4. What to submit
Your own GitHub repository link, an evaluation table with 20+ tests, scoring rules, three key failure types, and a before/after comparison. Do not claim improvements you did not measure.$a3$ WHERE id='b4000000-0000-4000-8000-000000000003'::uuid AND task_number=3 AND status='published';

UPDATE public.internship_tasks SET instructions = $a4$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
İstifadəçi sualından cavab hazırlayan AI funksiyasını təhlükəsizlik, xəta idarəetməsi və qiymətləndirmə ilə tamamlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz əvvəlki AI layihən, prompt, retrieval, API error və test anlayışları. Ödənişli model məcburi deyil; mock/local alternativ qəbul edilir.

## 3. Addım-addım təlimat
1. Task 1–3-dəki öz repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Sual → relevant context → answer axınını birləşdir.
3. Source attribution, empty result, timeout və provider error hallarını idarə et.
4. Input ölçüsünə limit qoy və istifadəçi mətnini instruction kimi kor-koranə icra etmə.
5. Əvvəlki qiymətləndirmə dataset-indən testləri təkrar işə sal.
6. README-də setup, model/mock seçimi, məhdudiyyətlər və məlum riskləri yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işlək AI feature, test nəticələri, error-state screenshot-ları və setup guide. Cavab mənbə ilə əsaslandırılmalı, xətalar təhlükəsiz idarə olunmalıdır.
[[EN]]
## 1. What is this task for?
Complete an AI answering feature with safety checks, error handling, and evaluation.

## 2. What should you know first?
Your earlier AI project, prompting, retrieval, API errors, and testing. A paid model is not required; a mock/local alternative is acceptable.

## 3. Step-by-step instructions
1. Continue your own repository from Tasks 1–3; do not submit the intern.az repository.
2. Connect the question → relevant context → answer flow.
3. Handle source attribution, empty results, timeouts, and provider errors.
4. Limit input size and do not blindly treat user-provided text as instructions.
5. Rerun tests from your evaluation dataset.
6. Document setup, model/mock choice, limitations, and known risks in the README.

## 4. What to submit
Your own GitHub repository link, working AI feature, test results, error-state screenshots, and setup guide. Answers must be grounded in sources and failures handled safely.$a4$ WHERE id='b4000000-0000-4000-8000-000000000004'::uuid AND task_number=4 AND status='published';

UPDATE public.internship_tasks SET instructions = $a5$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
AI prompt-un hansı hallarda səhv cavab verdiyini tapıb daha etibarlı davranış quracaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz AI prototipin və əvvəlki test nəticələrin. Test üçün sintetik və zərərsiz mətnlər seç.

## 3. Addım-addım təlimat
1. Öz AI repo-nu davam etdir.
2. Ən azı 10 failure case yaz: qeyri-müəyyən sual, çatışmayan kontekst, ziddiyyətli mətn, əlaqəsiz sual və prompt injection cəhdi.
3. Hər hal üçün gözlənilən təhlükəsiz davranışı əvvəlcədən müəyyən et.
4. Testləri işə sal və cavabları expected behavior ilə müqayisə et.
5. Prompt və ya retrieval qaydasını dəyişərək ən azı 3 failure case-i düzəlt.
6. Əvvəl/sonra nəticələri və qalan məhdudiyyətləri sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, 10+ failure case, nəticə cədvəli, ən azı 3 düzəliş və regression testləri. Uğursuz sınaqları gizlətmə.
[[EN]]
## 1. What is this task for?
Find when your AI prompt fails and improve its reliability.

## 2. What should you know first?
Your AI prototype and previous test results. Use harmless synthetic text for testing.

## 3. Step-by-step instructions
1. Continue your own AI repository.
2. Write at least ten failure cases: ambiguous questions, missing context, conflicting text, unrelated questions, and prompt-injection attempts.
3. Define the expected safe behavior for each case before testing.
4. Run tests and compare responses with expected behavior.
5. Improve at least three failure cases by changing the prompt or retrieval rules.
6. Document before/after results and remaining limitations.

## 4. What to submit
Your own GitHub repository link, ten or more failure cases, a results table, at least three fixes, and regression tests. Do not hide failed experiments.$a5$ WHERE id='83579d39-5b88-47e2-a2e3-3faacbca53a9'::uuid AND task_number=5 AND status='published';

UPDATE public.internship_tasks SET instructions = $a6$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
AI prototipinə məhdud və yoxlanıla bilən tool/function calling əlavə edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz AI repo-n, JSON schema, function input/output və API mock anlayışı. Real hesab və ödəniş əməliyyatı etmə.

## 3. Addım-addım təlimat
1. Öz AI layihəni davam etdir.
2. İki təhlükəsiz funksiya müəyyən et, məsələn, task axtarışı və task detalını oxuma.
3. Hər funksiya üçün input schema və icazə verilən parametrləri yaz.
4. Modelin təklif etdiyi arqumentləri schema ilə yoxla; naməlum funksiyanı icra etmə.
5. Funksiya nəticəsini modelə qaytar və son cavabda mənbəni göstər.
6. Valid/invalid argument və tool error üçün test yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, iki tool üçün schema/implementasiya, mock nəticələr və testlər. Tool yalnız açıq şəkildə icazə verilən əməliyyatları yerinə yetirməlidir.
[[EN]]
## 1. What is this task for?
Add limited, verifiable tool/function calling to your AI prototype.

## 2. What should you know first?
Your own AI repository, JSON schemas, function inputs/outputs, and API mocks. Do not perform real account or payment actions.

## 3. Step-by-step instructions
1. Continue your own AI project.
2. Define two safe functions, such as searching tasks and reading task details.
3. Specify an input schema and allowed parameters for each function.
4. Validate model-proposed arguments against the schema; never execute unknown functions.
5. Return tool results to the model and show sources in the final answer.
6. Test valid/invalid arguments and tool errors.

## 4. What to submit
Your own GitHub repository link, schemas/implementation for two tools, mock results, and tests. Tools must perform only explicitly allowed actions.$a6$ WHERE id='80a53bce-001c-4fb4-bc4d-c39e729af8bb'::uuid AND task_number=6 AND status='published';

UPDATE public.internship_tasks SET instructions = $a7$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Sənədlərdən cavab tapan sistemdə retrieval keyfiyyətini yaxşılaşdıracaq və dəyişiklikləri ölçəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz document Q&A prototipin, test sualları və mənbə hissələri. Embedding/API xidmətinə çıxış yoxdursa, keyword search ilə müqayisə et.

## 3. Addım-addım təlimat
1. Öz AI repo-nu davam etdir.
2. Ən azı 20 sual üçün gözlənilən source chunk-ı qeyd et.
3. Cari retrieval nəticələrində düzgün hissənin top-k siyahısında olub-olmadığını ölç.
4. Chunk ölçüsü və top-k dəyərini bir-bir dəyişərək sına.
5. Düzgün source retrieval faizi və cavab keyfiyyətini əvvəl/sonra müqayisə et.
6. Dəyişikliklərin trade-off və məhdudiyyətlərini yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, test dataset-i, retrieval ölçüləri, parametrlər üzrə müqayisə və nəticə hesabatı. Ölçüləri təkrar istehsal etmək mümkün olmalıdır.
[[EN]]
## 1. What is this task for?
Improve document retrieval quality and measure the effect of each change.

## 2. What should you know first?
Your document Q&A prototype, test questions, and source chunks. If embeddings/API access is unavailable, compare keyword-search alternatives.

## 3. Step-by-step instructions
1. Continue your own AI repository.
2. Record the expected source chunk for at least 20 questions.
3. Measure whether the correct chunk appears in the current top-k results.
4. Experiment with chunk size and top-k one variable at a time.
5. Compare source-retrieval rate and answer quality before/after.
6. Document trade-offs and limitations.

## 4. What to submit
Your own GitHub repository link, test dataset, retrieval metrics, parameter comparison, and report. Measurements must be reproducible.$a7$ WHERE id='c1c9566b-22ef-4f1f-a62a-8e1cec48dce9'::uuid AND task_number=7 AND status='published';

UPDATE public.internship_tasks SET instructions = $a8$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
AI cavabları üçün təhlükəsizlik sərhədləri quracaq və riskli input-ların davranışını yoxlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz AI prototipin, input validation, prompt injection və privacy əsasları. Real şəxsi məlumat və zərərli əməliyyatlar işlətmə.

## 3. Addım-addım təlimat
1. Öz AI repo-nu davam etdir.
2. İcazəli mövzuları, qadağan olunan əməliyyatları və cavab verilməyən halları yaz.
3. Input uzunluğu, mənbə yoxlaması və tool icazələri üçün guardrail əlavə et.
4. Prompt injection, şəxsi məlumat istəyi və əlaqəsiz suallar üçün sintetik testlər qur.
5. Sistem uyğun olmayan input-u rədd etməli və ya təhlükəsiz cavab verməlidir.
6. Hər guardrail üçün test və qalan risk qeydi əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, guardrail qaydaları, test cədvəli və test nəticələri. Guardrail-in bütün hücumları aradan qaldırdığını iddia etmə.
[[EN]]
## 1. What is this task for?
Set safety boundaries for AI responses and test behavior on risky inputs.

## 2. What should you know first?
Your AI prototype, input validation, prompt-injection, and privacy basics. Do not use real personal data or harmful operations.

## 3. Step-by-step instructions
1. Continue your own AI repository.
2. Define allowed topics, prohibited actions, and cases where the system should not answer.
3. Add guardrails for input length, source checks, and tool permissions.
4. Create synthetic tests for prompt injection, requests for personal data, and unrelated questions.
5. The system should refuse or respond safely to disallowed inputs.
6. Add tests and a residual-risk note for each guardrail.

## 4. What to submit
Your own GitHub repository link, guardrail rules, test table, and results. Do not claim guardrails eliminate every attack.$a8$ WHERE id='8e9d7693-e6a9-42b4-aebf-d8b2b5295bde'::uuid AND task_number=8 AND status='published';

UPDATE public.internship_tasks SET instructions = $a9$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
AI prototipinin cavab vaxtını və təxmini istifadə xərclərini ölçərək səmərəli seçim edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz AI repo-n, test dataset-i və latency/token/cost anlayışları. API xərci yaratmaq istəmirsənsə, mock cavablarla vaxt ölç və qiymət hesabını nümunə kimi işarələ.

## 3. Addım-addım təlimat
1. Öz AI layihəni davam etdir.
2. Eyni 20+ test sorğusunu bir neçə dəfə işə sal.
3. Cavab vaxtını və istifadə olunan token/xərc məlumatını mövcuddursa qeyd et.
4. Qısa context, retrieval top-k və model variantlarını təhlükəsiz testlə müqayisə et.
5. Orta və p95 latency hesabla; mock/estimated qiymətləri real ölçü kimi təqdim etmə.
6. Keyfiyyət, sürət və xərc arasında trade-off-u izah et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, ölçmə skripti/cədvəli, latency nəticələri, xərc fərziyyələri və trade-off hesabatı. Hər nəticənin real, ölçülmüş və ya təxmin olduğu aydın göstərilməlidir.
[[EN]]
## 1. What is this task for?
Measure response time and estimated usage cost to make a more efficient AI design choice.

## 2. What should you know first?
Your AI repository, test dataset, and latency/token/cost concepts. If you want to avoid API charges, measure mock responses and label price calculations as illustrative.

## 3. Step-by-step instructions
1. Continue your own AI project.
2. Run the same 20+ test prompts multiple times.
3. Record response time and token/cost data when available.
4. Compare context length, retrieval top-k, and model variants using safe tests.
5. Calculate average and p95 latency; do not present mock/estimated costs as real measurements.
6. Explain quality, speed, and cost trade-offs.

## 4. What to submit
Your own GitHub repository link, measurement script/table, latency results, cost assumptions, and trade-off report. Clearly label each result as measured, estimated, or simulated.$a9$ WHERE id='63fe872b-5ade-4a09-b39e-be4b69655b4f'::uuid AND task_number=9 AND status='published';

UPDATE public.internship_tasks SET instructions = $a10$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
AI məhsulunu başqa developer-in davam etdirə bilməsi üçün kod, test və texniki qərarlarla birlikdə təhvil verəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz Task 1–9 AI layihən, testlər, guardrails, retrieval ölçüləri və setup sənədləri.

## 3. Addım-addım təlimat
1. Öz əvvəlki AI repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Quraşdırma, environment nümunəsi və local/mock run addımlarını yaz.
3. Data flow, prompt, retrieval və tool icazələrini diaqramla izah et.
4. Test nəticələri, məlum limitlər, privacy/safety riskləri və qiymət fərziyyələrini qeyd et.
5. Mövcud test/lint/build əmrlərini işə sal və nəticələri əlavə et.
6. Qısa demo və növbəti 3 prioritet işi təqdim et; secret-ləri çıxar.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, README, arxitektura diaqramı, test/benchmark nəticələri, demo və məlum məhdudiyyətlər. Fresh clone-dan quraşdırma təkrarlana bilməlidir.
[[EN]]
## 1. What is this task for?
Hand off your AI product so another developer can continue it with the code, tests, and technical decisions documented.

## 2. What should you know first?
Your AI project from Tasks 1–9, tests, guardrails, retrieval metrics, and setup documentation.

## 3. Step-by-step instructions
1. Continue your own AI repository from earlier tasks; do not submit the intern.az repository.
2. Document setup, environment examples, and local/mock run instructions.
3. Diagram data flow, prompting, retrieval, and tool permissions.
4. Record test results, known limits, privacy/safety risks, and cost assumptions.
5. Run available test/lint/build commands and include the results.
6. Provide a short demo and three next priorities; remove all secrets.

## 4. What to submit
Your own GitHub repository link, README, architecture diagram, test/benchmark results, demo, and known limitations. Setup must be repeatable from a fresh clone.$a10$ WHERE id='cca06d4a-3f99-4f9e-a0bf-611f53151b23'::uuid AND task_number=10 AND status='published';

COMMIT;
