BEGIN;

UPDATE public.internship_tasks SET instructions = $task5$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Motivasiya, təcrübə və portfolio məlumatlarını itirmədən təqdim etməyə imkan verən əlçatan form hazırlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz frontend layihən, controlled form input-ları, validation və async request anlayışı. Submit üçün lokal mock endpoint kifayətdir.

## 3. Addım-addım təlimat
1. Öz əvvəlki frontend repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Məcburi motivasiya sahəsi, optional portfolio URL-i və mətn limitləri əlavə et.
3. Hər input-a label və köməkçi mətn ver; xətanı aid olduğu sahə ilə əlaqələndir.
4. Submit zamanı loading/disabled, success, server error və network failure vəziyyətlərini göstər.
5. Xətadan sonra daxil edilmiş məlumatı saxla və təhlükəsiz retry təmin et.
6. Keyboard-only istifadəni yoxla və success, invalid input, server error, network failure üçün test yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, form komponenti və validation qaydaları, dörd ssenari üçün testlər, mobil screenshot və accessibility checklist. Double-click dublikat yaratmamalı, xəta təkcə rənglə göstərilməməlidir.
[[EN]]
## 1. What is this task for?
Build an accessible form for motivation, experience, and portfolio details without losing user input.

## 2. What should you know first?
Your own frontend project, controlled form inputs, validation, and asynchronous requests. A local mock endpoint is sufficient.

## 3. Step-by-step instructions
1. Continue your own frontend repository; do not submit the intern.az repository.
2. Add a required motivation field, optional portfolio URL, and text-length limits.
3. Give each input a label and helper text; associate errors with their fields.
4. Show loading/disabled, success, server-error, and network-failure states.
5. Preserve entered data after a failed response and provide a safe retry.
6. Check keyboard-only use and test success, invalid input, server error, and network failure.

## 4. What to submit
Your own GitHub repository link, form component and validation rules, tests for four scenarios, a mobile screenshot, and an accessibility checklist. Double-clicking must not create duplicates, and errors must not rely on color alone.$task5$ WHERE id = '840c7269-a035-4ec0-9ca9-7128385bdffb'::uuid AND task_number = 5 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task6$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Dashboard-da filter, axtarış və səhifələmə vəziyyətlərini idarə edəcəksən. Formun yazılmamış, göndərilən və uğurlu vəziyyətləri də aydın olmalıdır.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz frontend repo-n, React state, URL query parametrləri və TypeScript əsasları. Task 3-dəki mock müraciət məlumatlarından istifadə edə bilərsən.

## 3. Addım-addım təlimat
1. Öz layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. Status filter, search query və page state əlavə et. Hansının URL-də, hansının komponentdə qalacağını izah et.
3. Filter dəyişəndə page-i 1-ə qaytar; URL-də saxlanan filter-lər refresh-dən sonra bərpa olunsun.
4. Eyni məlumatı iki state-də saxlamamaq üçün derived state/selector istifadə et.
5. Form üçün dirty, submitting və success keçidlərini qur.
6. Filter, axtarış, səhifələmə, form keçidləri, refresh və back düyməsini test et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, state diagramı, işlək kod, testlər və refresh/back demo-su. URL filter-ləri refresh-dən sonra bərpa olunmalı, əlaqəsiz form məlumatı itməməlidir.
[[EN]]
## 1. What is this task for?
Manage filtering, searching, and pagination on the dashboard while keeping form states predictable.

## 2. What should you know first?
Your own frontend repository, React state, URL query parameters, and basic TypeScript. You may reuse the mock application data from Task 3.

## 3. Step-by-step instructions
1. Continue your own project; do not submit the intern.az repository.
2. Add status filter, search query, and page state. Explain which values belong in the URL and which remain local.
3. Reset the page to 1 when filters change and restore URL-based filters after refresh.
4. Use derived values/selectors rather than storing the same data in multiple states.
5. Model dirty, submitting, and success transitions for the form.
6. Test filters, search, pagination, form transitions, refresh, and the back button.

## 4. What to submit
Your own GitHub repository link, state diagram, implementation, tests, and a refresh/back demo. URL filters must restore after refresh, and unrelated form input must not disappear.$task6$ WHERE id = '7a077c80-61cb-4557-95e9-9b522c8f243e'::uuid AND task_number = 6 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task7$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Frontend səhifəsinin performansını ölçəcək, sonra sübutla təsdiqlənən bir problemi düzəldəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz frontend repo-n, production build anlayışı və brauzerin Developer Tools bölməsindən istifadə. Ölçmələr eyni şəraitdə aparılmalıdır.

## 3. Addım-addım təlimat
1. Öz dashboard route-unu seç və layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. Eyni build və network şəraitində başlanğıc ölçməsini götür: performance trace və bundle ölçüsü.
3. Böyük dependency, şəkil ölçüsü, bloklayan request və lazımsız renderləri araşdır.
4. Ən vacib görünən bir problemi seç və bir dəyişiklik et.
5. Eyni şəraitdə yenidən ölç və əvvəl/sonra nəticələrini cədvəldə müqayisə et.
6. Yaxşılaşma yoxdursa, bunu dürüst qeyd et və növbəti sınağı izah et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, əvvəl/sonra ölçülər, bir optimallaşdırma diff-i və nəticə hesabatı. Müqayisə eyni şəraitdə olmalı, istifadəçi davranışı pozulmamalıdır.
[[EN]]
## 1. What is this task for?
Measure frontend performance and fix one issue supported by evidence.

## 2. What should you know first?
Your own frontend repository, production-build basics, and browser Developer Tools. Keep measurement conditions consistent.

## 3. Step-by-step instructions
1. Choose your dashboard route and continue your project; do not submit the intern.az repository.
2. Capture baseline performance and bundle size under consistent build/network conditions.
3. Investigate large dependencies, image sizes, blocking requests, and unnecessary renders.
4. Choose the most impactful likely issue and make one change.
5. Measure again under the same conditions and compare before/after results in a table.
6. If performance did not improve, report that honestly and explain the next experiment.

## 4. What to submit
Your own GitHub repository link, before/after measurements, one optimization diff, and a report showing its effect. Use consistent conditions and preserve user behavior.$task7$ WHERE id = '0a557515-87db-458b-9460-ce843976e069'::uuid AND task_number = 7 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task8$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Müraciət formu və koordinator dashboard-unda əsas istifadəçi davranışlarını testlərlə qoruyacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz frontend layihən, React Testing Library və layihədə istifadə olunan test aləti (Vitest/Jest). Mövcud test setup-u varsa, onu davam etdir.

## 3. Addım-addım təlimat
1. Öz repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Əsas uğurlu axını və ən azı 4 xəta/kənar vəziyyəti seç.
3. Elementləri label, role və görünən mətnlə tap; class adlarına həddindən artıq bağlanma.
4. API sorğularını mock et və loading, retry, invalid input və server error hallarını yoxla.
5. Ən azı 8 UI testi yaz və hər testin hansı riski azaltdığını cədvəldə göstər.
6. Testləri təmiz checkout-dan işə sal; real şəbəkədən və qeyri-sabit timer-lardan asılı olma.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, ən azı 8 UI testi, işlək test əmri və risk/test cədvəli. Testlər təmiz quraşdırmada stabil işləməlidir.
[[EN]]
## 1. What is this task for?
Protect key behaviors in the application form and coordinator dashboard with tests.

## 2. What should you know first?
Your own frontend project, React Testing Library, and the test tool used by the project (Vitest/Jest). Continue an existing setup if available.

## 3. Step-by-step instructions
1. Continue your own repository; do not submit the intern.az repository.
2. Choose the main successful flow and at least four error/edge cases.
3. Find elements by label, role, and visible text rather than relying heavily on class names.
4. Mock API requests and test loading, retry, invalid input, and server-error states.
5. Write at least eight UI tests and explain the risk each test reduces.
6. Run tests from a clean checkout without real-network dependencies or flaky timers.

## 4. What to submit
Your own GitHub repository link, at least eight UI tests, a working test command, and a risk/test table. Tests must run reliably in a clean setup.$task8$ WHERE id = '40aa437d-0f6d-461d-92af-9de47747e210'::uuid AND task_number = 8 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task9$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Frontend kodunu review edib real səhvləri tapacaq, ən vacib olanlardan birini testlə birlikdə düzəldəcəksən. Şəxsi dizayn zövqünü bug kimi təqdim etmə.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz layihəndə component, test və Git diff oxumaq. Pull request-in məqsədini və qəbul meyarlarını anlamaq vacibdir.

## 3. Addım-addım təlimat
1. Öz əvvəlki tapşırığındakı component və ya diff-i seç; intern.az repo-sunu təqdim etmə.
2. Kodun məqsədini və qəbul meyarlarını oxu.
3. Hər problem üçün təkrarlama addımı, fayl/component, istifadəçiyə təsir və ciddilik səviyyəsi yaz.
4. 3–5 konkret tapıntı hazırla və təsirə görə sırala.
5. Yüksək təsirli bir problemi düzəlt və regression test əlavə et.
6. Testləri yenidən işə sal, qalan riskləri və yoxlama nəticəsini sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, 3–5 tapıntılı review hesabatı, bir düzəliş diff-i, regression test və qalan risk qeydi. Hər tapıntı konkret və təkrarlana bilən olmalıdır.
[[EN]]
## 1. What is this task for?
Review frontend code, identify real defects, and fix one high-impact issue with a test. Do not report personal design preference as a bug.

## 2. What should you know first?
How to read components, tests, and Git diffs in your own project. Understand the pull request goal and acceptance criteria.

## 3. Step-by-step instructions
1. Choose a component or diff from your earlier task; do not submit the intern.az repository.
2. Read the change goal and acceptance criteria.
3. For each issue, record reproduction steps, file/component, user impact, and severity.
4. Write three to five concrete findings and rank them by impact.
5. Fix one high-impact issue and add a regression test.
6. Rerun tests and document residual risks and retest results.

## 4. What to submit
Your own GitHub repository link, a review report with three to five findings, one fix diff, a regression test, and a residual-risk note. Each finding must be specific and reproducible.$task9$ WHERE id = 'eb4de9d8-dae6-42a0-bd53-354d84a194bf'::uuid AND task_number = 9 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task10$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Başqa developer-in layihəni qura və dəyişə bilməsi üçün aydın təhvil sənədləri hazırlayacaqsan. Dizayner də əsas ekran vəziyyətlərini və responsive ölçüləri anlamalıdır.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz frontend repo-n, README yazmaq, environment variable nümunəsi, komponent ağacı və test/build əmrləri. Production secret paylaşma.

## 3. Addım-addım təlimat
1. Əvvəlki tapşırıqlardakı öz layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. Təmiz klondan quraşdırma, development server və test/build addımlarını README-yə yaz.
3. Component tree, data flow, state keçidləri, breakpoint-lər və loading/empty/error vəziyyətlərini sənədləşdir.
4. Environment nümunəsində yalnız dummy dəyərlər saxla; real açarları GitHub-a yükləmə.
5. Mövcud test, lint və build əmrlərini işlət və nəticələri qeyd et.
6. Screenshot-lar, məlum problemlər və növbəti 3 yaxşılaşdırma təklifini əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, README/feature guide, komponent və data-flow diaqramı, screenshot-lar, test/build nəticələri və məlum məhdudiyyətlər. Başqa developer fresh clone-dan təlimatla layihəni işə sala bilməlidir.
[[EN]]
## 1. What is this task for?
Prepare clear handoff documentation so another developer can set up and modify your project. A designer should understand key states and responsive layouts.

## 2. What should you know first?
Your own frontend repository, README writing, environment-variable examples, component trees, and test/build commands. Never share production secrets.

## 3. Step-by-step instructions
1. Continue your own project from earlier tasks; do not submit the intern.az repository.
2. Document setup from a clean clone, development server, and test/build steps in the README.
3. Document the component tree, data flow, state transitions, breakpoints, and loading/empty/error states.
4. Use dummy values only in environment examples; never push real keys to GitHub.
5. Run available test, lint, and build commands and record the results.
6. Add screenshots, known issues, and your next three improvement suggestions.

## 4. What to submit
Your own GitHub repository link, README/feature guide, component and data-flow diagram, screenshots, test/build results, and known limitations. Another developer must be able to run the project from a fresh clone by following your instructions.$task10$ WHERE id = '7961eb9e-e7ff-4d49-ab7c-4e6cd41ac888'::uuid AND task_number = 10 AND status = 'published';

COMMIT;
