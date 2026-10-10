BEGIN;

-- Beginner-friendly rewrite of task 1 for each internship track.
-- The same reviewed content is kept in this migration for reproducible deployments.
UPDATE public.internship_tasks SET instructions = $task_one_0$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Tələbələrin tapşırığı tapmaq, tələbi anlamaq və həllini təqdim etmək zamanı yaşadığı çətinlikləri öyrənmək üçün müsahibə planı hazırlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
İstifadəçi araşdırmasının məqsədi, açıq sualların üstünlüyü və Figma/Penpot-da sadə sənəd hazırlamaq. Razılıq olmadan qeyd aparma və lazımsız şəxsi məlumat toplama.

## 3. Addım-addım təlimat
1. GitHub-da özünə boş `student-task-research` repo-su yarat. Sıfırdan başla; intern.az repo-sunu təqdim etmə.
2. `README.md`, `interview-guide.md` və `findings.md` faylları yarat.
3. Araşdırma sualını yaz: “Tələbələr tapşırığın şərtini anlamaqda və həll linkini təqdim etməkdə hansı çətinliklərlə qarşılaşır?”
4. 8–10 açıq sual yaz. Məsələn: “Son dəfə onlayn tapşırıq təqdim edəndə hansı addım çətin oldu?” Cavabı təlqin edən suallardan qaç.
5. İştirakçıya məqsədi izah edən razılıq mətni hazırla; ad, telefon və başqa lazımsız məlumat toplama.
6. Mümkündürsə, bir nəfərlə 15–20 dəqiqəlik sınaq müsahibəsi et. İştirakçı yoxdursa, simulyasiyanı real müsahibə kimi göstərmə.
7. 3 müşahidə, 2 fərziyyə və növbəti addımı `findings.md`-də yaz, sonra repo-nu GitHub-a göndər.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, 8–10 suallı müsahibə planı, razılıq mətni, anonim qeydlər və 3 müşahidə ilə araşdırma məhdudiyyətləri.

[[EN]]
## 1. What is this task for?
Prepare an interview plan to learn what makes it difficult for students to find a task, understand its requirements, and submit a solution.

## 2. What should you know first?
The purpose of user research, why open-ended questions help, and how to create a simple document in Figma/Penpot. Do not record without consent or collect unnecessary personal data.

## 3. Step-by-step instructions
1. Create your own empty GitHub repository named `student-task-research`. Start from scratch; do not submit the intern.az repository.
2. Create `README.md`, `interview-guide.md`, and `findings.md`.
3. Write the research question: “What difficulties do students face when understanding task instructions and submitting a solution link?”
4. Write 8–10 open questions. For example: “Which step was difficult the last time you submitted an online task?” Avoid leading questions.
5. Prepare a consent statement explaining the purpose. Do not collect names, phone numbers, or other unnecessary information.
6. If possible, run a 15–20 minute pilot interview. If no participant is available, do not present a simulation as a real interview.
7. Record three observations, two assumptions, and a next step in `findings.md`, then push the repository to GitHub.

## 4. What to submit
Your own GitHub repository link, an interview guide with 8–10 questions, consent statement, anonymized notes, three observations, and research limitations.$task_one_0$ WHERE id = '2b076971-66e0-41a9-9def-dcff23a639a6'::uuid AND task_number = 1 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task_one_1$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Gələcək kibertəhlükəsizlik tapşırıqları üçün təhlükəsiz laboratoriya planı hazırlayacaqsan. Yalnız öz kompüterində və ya açıq icazə verilmiş test mühitində işləyəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Fayl/qovluq və lokal kompüter anlayışları, şəbəkə haqqında ilkin bilik. Docker quraşdırmaq alınmırsa, diaqram və sənədlə başla. İcazəsiz real saytları və ictimai IP-ləri skan etmək olmaz.

## 3. Addım-addım təlimat
1. GitHub-da özünə boş `safe-security-lab` repo-su yarat. Sıfırdan başla; intern.az repo-sunu təqdim etmə.
2. `README.md`, `lab-scope.md` və `lab-diagram.md` faylları yarat.
3. Diaqramda öz kompüterini, test tətbiqini və sintetik test məlumatlarını göstər.
4. Əhatə dairəsini yaz: yalnız localhost və ya özünün idarə etdiyi test şəbəkəsi.
5. İcazəli və qadağan olunan əməliyyatları sadala. Real parol, cookie, hesab və şəxsi məlumat istifadə etmə.
6. Laboratoriyanı başlatma/dayandırma addımlarını sənədləşdir. Docker Compose faylın yoxdursa, onun əmrlərini işlətmə.
7. Başqa tələbənin təlimatını oxuyub laboratoriyanın sərhədlərini anlaya bildiyini yoxla və repo-nu GitHub-a göndər.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, laboratoriya diaqramı, scope və təhlükəsizlik qaydaları, başlatma/dayandırma təlimatı.

[[EN]]
## 1. What is this task for?
Plan a safe lab for future cybersecurity exercises. Work only on your own computer or in a test environment you are authorized to use.

## 2. What should you know first?
Basic files and folders, local computers, and introductory networking. If Docker is unavailable, start with a diagram and documentation. Never scan real sites or public IPs without permission.

## 3. Step-by-step instructions
1. Create your own empty GitHub repository named `safe-security-lab`. Start from scratch; do not submit the intern.az repository.
2. Create `README.md`, `lab-scope.md`, and `lab-diagram.md`.
3. Draw your computer, a test application, and synthetic test data.
4. Define the scope as localhost or a test network you control.
5. List allowed and prohibited actions. Do not use real passwords, cookies, accounts, or personal data.
6. Document how to start and stop the lab. Do not run Docker Compose commands unless a Compose file exists.
7. Check whether another student can understand the lab boundaries from your instructions, then push the repository.

## 4. What to submit
Your own GitHub repository link, lab diagram, scope and safety rules, and start/stop instructions.$task_one_1$ WHERE id = 'a83dc081-2599-4bdb-897d-84be2a6b9612'::uuid AND task_number = 1 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task_one_2$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Telefonda və ya emulatorda açıla bilən sadə mobil tətbiq yaradacaqsan. Layihəni sıfırdan qurub işə salma qaydasını sənədləşdirəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
JavaScript-ə ilkin bələdlik, Node.js/npm, VS Code və terminaldan istifadə. Telefonda Expo Go istifadə edə bilərsən; Android emulatoru üçün Android Studio lazım ola bilər.

## 3. Addım-addım təlimat
1. GitHub-da özünə boş `mobile-starter-app` repo-su yarat. Sıfırdan başla; intern.az repo-sunu təqdim etmə.
2. Node.js LTS və VS Code quraşdırıldığını yoxla.
3. Terminalda `npx create-expo-app@latest mobile-starter-app --template blank-typescript` əmrini işlət və layihə qovluğuna keç.
4. `npx expo start` ilə tətbiqi başlat. QR kodu Expo Go ilə oxut və ya emulator aç.
5. Başlanğıc ekranda tətbiqin adını və “Salam!” mesajını göstər.
6. `README.md`-də quraşdırma və işə salma addımlarını yaz. Gizli açar və parol əlavə etmə.
7. Layihəni öz GitHub repo-na göndər və tətbiqin açıldığını göstərən screenshot əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işləyən Expo/TypeScript tətbiqi, quraşdırma təlimatlı README və tətbiqin açıldığını göstərən screenshot.

[[EN]]
## 1. What is this task for?
Create a simple mobile app that opens on a phone or emulator. Set it up from scratch and document how to run it.

## 2. What should you know first?
Introductory JavaScript, Node.js/npm, and basic VS Code and terminal use. Expo Go works on a phone; Android Studio may be needed for an emulator.

## 3. Step-by-step instructions
1. Create your own empty GitHub repository named `mobile-starter-app`. Start from scratch; do not submit the intern.az repository.
2. Check that Node.js LTS and VS Code are installed.
3. Run `npx create-expo-app@latest mobile-starter-app --template blank-typescript` in the terminal and enter the project folder.
4. Start the app with `npx expo start`. Scan the QR code with Expo Go or open an emulator.
5. Show the app name and a “Hello!” message on the home screen.
6. Document setup and startup in `README.md`. Do not add secrets or passwords.
7. Push the project to your own GitHub repository and add a screenshot showing the app running.

## 4. What to submit
Your own GitHub repository link, working Expo/TypeScript app, setup README, and a screenshot of the running app.$task_one_2$ WHERE id = 'ac33a89f-f4ca-45cd-aacb-8abf50a9ee2d'::uuid AND task_number = 1 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task_one_3$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Təcrübə proqramını tanıdan, telefonda və kompüterdə düzgün görünən sadə landing page hazırlayacaqsan. Ziyarətçi proqramın nə olduğunu və müraciət addımını tez anlamalıdır.

## 2. Başlamazdan əvvəl nə bilməlisən?
HTML elementləri, CSS-in əsasları, brauzerdə səhifə açmaq, VS Code və GitHub-dan istifadə. React/Next.js bilmirsənsə, HTML/CSS ilə başlamaq kifayətdir.

## 3. Addım-addım təlimat
1. GitHub-da özünə boş `internship-landing-page` repo-su yarat və VS Code-da aç. Sıfırdan başla; intern.az repo-sunu təqdim etmə.
2. `index.html`, `style.css` və `README.md` faylları yarat.
3. Başlıq, qısa tanıtım, 3 üstünlük, proqram mərhələləri və “Müraciət et” düyməsi əlavə et.
4. Oxunaqlı şrift və 2–3 uyğun rəng seç. Hazır dizaynı olduğu kimi köçürmə.
5. Səhifəni brauzerdə aç və təxminən 360px mobil, 1280px desktop enində yoxla. Mətn kənara çıxmamalı, düymə rahat görünməlidir.
6. Klaviatura ilə keçidi və şəkillərin alt mətnini yoxla. Saxta əlaqə məlumatı və işləməyən link qoyma.
7. README-də səhifəni necə açmağı yaz, screenshot-lar əlavə et və repo-nu GitHub-a göndər.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işlək HTML/CSS səhifəsi, mobil və desktop screenshot-ları və qısa README.

[[EN]]
## 1. What is this task for?
Build a simple internship landing page that works on phones and computers. Visitors should quickly understand the program and find the application action.

## 2. What should you know first?
HTML elements, basic CSS, opening a page in a browser, and using VS Code and GitHub. If you do not know React/Next.js, plain HTML/CSS is enough to begin.

## 3. Step-by-step instructions
1. Create your own empty GitHub repository named `internship-landing-page` and open it in VS Code. Start from scratch; do not submit the intern.az repository.
2. Create `index.html`, `style.css`, and `README.md`.
3. Add a heading, short introduction, three benefits, program steps, and an “Apply” button.
4. Choose a readable font and two or three matching colors. Do not copy a ready-made design unchanged.
5. Open the page in a browser and test around 360px mobile and 1280px desktop widths. Text must not overflow and the button must remain easy to find.
6. Check keyboard navigation and image alt text. Do not add fake contact details or broken links.
7. Document how to open the page, add screenshots, and push the repository to GitHub.

## 4. What to submit
Your own GitHub repository link, working HTML/CSS page, mobile and desktop screenshots, and a short README.$task_one_3$ WHERE id = 'b1000000-0000-4000-8000-000000000001'::uuid AND task_number = 1 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task_one_4$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Layihələri yaratmaq, siyahılamaq, açmaq və yeniləmək üçün REST API planı hazırlayacaqsan. Bu tapşırıqda əsas nəticə işlək server yox, aydın API müqaviləsidir.

## 2. Başlamazdan əvvəl nə bilməlisən?
API, HTTP sorğusu, GET/POST/PUT/PATCH, JSON və 404/422 kimi status kodlarının əsasları. VS Code, terminal və GitHub-dan başlanğıc səviyyədə istifadə.

## 3. Addım-addım təlimat
1. GitHub-da özünə boş `student-project-api` repo-su yarat və VS Code-da aç. Sıfırdan başla; intern.az repo-sunu təqdim etmə.
2. `README.md` və `openapi.yaml` faylları yarat.
3. Dörd əməliyyat müəyyən et: layihələri siyahıla, bir layihəyə bax, layihə yarat və mövcud layihəni yenilə.
4. Hər əməliyyat üçün HTTP metodu, URL, sorğu nümunəsi və cavab nümunəsi yaz.
5. Layihə tapılmadıqda 404, məlumat yanlışdırsa 422 qaytarılmasını təsvir et.
6. Ən azı 5 sorğu nümunəsi və gözlənilən status kodunu əlavə et.
7. README-də API-ni izah et, YAML sintaksisini yoxla, sonra commit edib GitHub-a push et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, `openapi.yaml`, ən azı 5 sorğu/cavab nümunəsi və API qərarlarını izah edən README.

[[EN]]
## 1. What is this task for?
Plan a REST API for listing, viewing, creating, and updating projects. The main deliverable is a clear API contract, not a running server.

## 2. What should you know first?
Basic API and HTTP concepts, GET/POST/PUT/PATCH, JSON, and status codes such as 404 and 422. Basic VS Code, terminal, and GitHub use.

## 3. Step-by-step instructions
1. Create your own empty GitHub repository named `student-project-api` and open it in VS Code. Start from scratch; do not submit the intern.az repository.
2. Create `README.md` and `openapi.yaml`.
3. Define four operations: list projects, view one project, create a project, and update a project.
4. For each operation, write the HTTP method, URL, example request, and example response.
5. Describe a 404 response when a project is missing and a 422 response for invalid input.
6. Add at least five request examples and their expected status codes.
7. Explain the API in README, validate the YAML syntax, then commit and push to GitHub.

## 4. What to submit
Your own GitHub repository link, `openapi.yaml`, at least five request/response examples, and a README explaining the API decisions.$task_one_4$ WHERE id = 'b2000000-0000-4000-8000-000000000001'::uuid AND task_number = 1 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task_one_5$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
CSV faylındakı səhv və qarışıq məlumatları təmizləyib analizə hazırlayacaqsan. Təmizləmədən əvvəl və sonra məlumat keyfiyyətini müqayisə edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
CSV, sətir və sütun anlayışları, Excel/Google Sheets-in əsasları. Python biliyi faydalıdır, amma ilkin yoxlamanı cədvəl proqramında da edə bilərsən. Yalnız uydurma məlumat istifadə et.

## 3. Addım-addım təlimat
1. GitHub-da özünə boş `dataset-cleaning` repo-su yarat; `data` və `reports` qovluqları əlavə et. Sıfırdan başla, intern.az repo-sunu təqdim etmə.
2. Ən azı 100 sətirlik uydurma CSV yarat. Boş xanalar, təkrar sətirlər, səhv tarixlər və müxtəlif yazılışlı kateqoriyalar daxil et.
3. `README.md` və `data-dictionary.md` fayllarında sütunları izah et.
4. Orijinal CSV-ni dəyişmədən saxla, təmizlənmiş versiyanı ayrı fayla yaz.
5. Boş dəyərlər, təkrarlar və səhv tarixlər üçün qaydalar seç və səbəbini qeyd et.
6. Əvvəl/sonra sətir sayını, boş dəyərləri və təkrarları müqayisə et.
7. Nəticələri `reports/summary.md`-də yaz və repo-nu GitHub-a göndər.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, orijinal və təmiz CSV, sütun izahları, təmizləmə qaydaları və əvvəl/sonra müqayisə hesabatı.

[[EN]]
## 1. What is this task for?
Clean incorrect or inconsistent values in a CSV file and prepare it for analysis. Compare data quality before and after cleaning.

## 2. What should you know first?
CSV files, rows and columns, and basic Excel/Google Sheets use. Python helps, but you can inspect the data in a spreadsheet first. Use fictional data only.

## 3. Step-by-step instructions
1. Create your own empty GitHub repository named `dataset-cleaning` and add `data` and `reports` folders. Start from scratch; do not submit the intern.az repository.
2. Create a fictional CSV with at least 100 rows. Include empty cells, duplicates, invalid dates, and inconsistent category spelling.
3. Explain the columns in `README.md` and `data-dictionary.md`.
4. Keep the original CSV unchanged and save the cleaned version separately.
5. Choose rules for missing values, duplicates, and invalid dates; explain why.
6. Compare row counts, missing values, and duplicates before and after cleaning.
7. Write findings in `reports/summary.md` and push the repository to GitHub.

## 4. What to submit
Your own GitHub repository link, original and cleaned CSV files, column explanations, cleaning rules, and a before/after report.$task_one_5$ WHERE id = 'b3000000-0000-4000-8000-000000000001'::uuid AND task_number = 1 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task_one_6$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
AI üçün təkrar istifadə edilən prompt hazırlayacaqsan. Prompt mesajları “ödəniş”, “hesaba giriş” və “digər” kateqoriyalarına ayırmalı, nəticəni JSON formatında qaytarmalıdır.

## 2. Başlamazdan əvvəl nə bilməlisən?
Prompt və JSON anlayışları, VS Code və GitHub-dan əsas istifadə. Real şəxsi məlumat yox, uydurma mesajlar işlət.

## 3. Addım-addım təlimat
1. GitHub-da özünə boş `ai-prompt-practice` repo-su yarat və VS Code-da aç. Bu tapşırıq ilk tapşırıqdır: hər şeyi sıfırdan qur, intern.az repo-sunu təqdim etmə.
2. `README.md`, `prompt.md`, `test-cases.json` və `results.md` faylları yarat.
3. Promptda modelin rolunu, 3 kateqoriyanı, tələb olunan JSON sahələrini və anlaşılmayan mesaj üçün davranışı yaz.
4. `test-cases.json` faylına 12 uydurma mesaj əlavə et; ən azı 3-ü qısa və qeyri-müəyyən olsun.
5. Hər mesaj üçün gözlənilən kateqoriyanı qeyd et, promptu sına və nəticəni yaz. Modelə çıxışın yoxdursa, simulyasiya etdiyini açıq göstər.
6. Ən azı 3 səhvi tap, promptu yaxşılaşdır və əvvəlki/yeni nəticələri müqayisə et.
7. README-də faylları izah et; commit edib öz repo-na push et. API açarı və parolu GitHub-a yükləmə.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, prompt faylı, 12 test mesajı, nəticə müqayisə cədvəli və ən azı 3 səhv/düzəliş izahı.

[[EN]]
## 1. What is this task for?
Create a reusable AI prompt that classifies messages as “billing,” “account access,” or “other” and returns JSON.

## 2. What should you know first?
Basic prompt and JSON concepts, plus basic VS Code and GitHub use. Use fictional messages, never real personal data.

## 3. Step-by-step instructions
1. Create your own empty GitHub repository named `ai-prompt-practice` and open it in VS Code. This is the first task, so start from scratch; do not submit the intern.az repository.
2. Create `README.md`, `prompt.md`, `test-cases.json`, and `results.md`.
3. In the prompt, define the role, three categories, required JSON fields, and behavior for unclear messages.
4. Add 12 fictional messages to `test-cases.json`; at least three must be short or ambiguous.
5. Record the expected category, test the prompt, and write down the result. If you cannot access a model, clearly label the test as a simulation.
6. Find at least three errors, improve the prompt, and compare the old and new results.
7. Explain the files in README, then commit and push to your own repository. Never upload API keys or passwords.

## 4. What to submit
Your own GitHub repository link, prompt file, 12 test messages, a results comparison table, and explanations of at least three errors and fixes.$task_one_6$ WHERE id = 'b4000000-0000-4000-8000-000000000001'::uuid AND task_number = 1 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task_one_7$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Təcrübə müraciətinin əl ilə yoxlanma prosesini diaqramda göstərəcək və hansı addımların avtomatlaşdırıla biləcəyini müəyyən edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Flowchart/proses diaqramının əsasları və diagrams.net və ya Mermaid kimi alətdən istifadə. Uydurma müraciət nümunələri işlət.

## 3. Addım-addım təlimat
1. GitHub-da özünə boş `internship-process-map` repo-su yarat. İlk tapşırıqdır: sıfırdan başla və intern.az repo-sunu təqdim etmə.
2. `README.md`, `process.md` və diaqram faylı yarat.
3. Bu axını göstər: tələbə formu göndərir → koordinator yoxlayır → natamam forma geri qaytarılır → uyğun müraciət rəhbərə ötürülür.
4. Hər mərhələdə məsul şəxsi, qərarı və növbəti addımı göstər.
5. Ən azı 5 istisna əlavə et: boş sahə, səhv e-poçt, təkrar müraciət, uyğun olmayan namizəd və sistem xətası.
6. Hər addımı “avtomatlaşdırıla bilər”, “insan təsdiqi lazımdır” və ya “əl ilə qalmalıdır” kimi işarələ və səbəbini yaz.
7. README-də diaqramın necə açıldığını izah et və faylları GitHub-a göndər.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, proses diaqramı, ən azı 5 istisna ssenarisi və avtomatlaşdırma qərarlarının izahı.

[[EN]]
## 1. What is this task for?
Map the manual internship-application review process and identify which steps could be automated.

## 2. What should you know first?
Basic flowchart concepts and a tool such as diagrams.net or Mermaid. Use fictional application examples.

## 3. Step-by-step instructions
1. Create your own empty GitHub repository named `internship-process-map`. This is the first task: start from scratch and do not submit the intern.az repository.
2. Create `README.md`, `process.md`, and a diagram file.
3. Map this flow: student submits a form → coordinator checks it → incomplete forms are returned → eligible applications go to a reviewer.
4. Show the owner, decision, and next step at each stage.
5. Add at least five exceptions: missing field, invalid email, duplicate application, ineligible candidate, and system error.
6. Label each step “can be automated,” “human approval needed,” or “keep manual,” and explain why.
7. Explain how to view the diagram in README and push the files to GitHub.

## 4. What to submit
Your own GitHub repository link, process diagram, at least five exception scenarios, and explanations of automation decisions.$task_one_7$ WHERE id = 'b5000000-0000-4000-8000-000000000001'::uuid AND task_number = 1 AND status = 'published';

DO $$ BEGIN IF (SELECT COUNT(*) FROM public.internship_tasks WHERE task_number = 1 AND status = 'published' AND instructions LIKE '%## 1. Bu tapşırıq nə üçündür?%' AND instructions LIKE '%## 4. Təhvil veriləcək nəticə%') <> 8 THEN RAISE EXCEPTION 'Expected eight rewritten task-one instructions'; END IF; END $$;

COMMIT;
