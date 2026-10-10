BEGIN;

UPDATE public.internship_tasks SET instructions = $c2$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
HTTP sorğusu və cavab başlıqlarını oxuyub təhlükəsizlik və davranış barədə nəticə çıxaracaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz təhlükəsiz lab planın, HTTP request/response, status code və header anlayışları. Yalnız öz lokal test tətbiqindən və ya yazılı nümunələrdən istifadə et.

## 3. Addım-addım təlimat
1. Task 1-dəki öz lab planını davam etdir; intern.az repo-sunu təqdim etmə.
2. Lokal test səhifəsi və ya nümunə HTTP response seç.
3. Status code, Content-Type, Cache-Control, Content-Security-Policy və digər görünən header-ləri qeyd et.
4. Hər header-in nə iş gördüyünü sadə dillə yaz.
5. Ən azı 3 risk və düzəliş təklifi göstər; header-in olmamasını avtomatik istismar sübutu kimi təqdim etmə.
6. Nəticəni README/report-da sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin və ya lab hesabatın, redaktə edilmiş request/response nümunələri, header izahları və 3 risk/düzəliş təklifi. Heç bir real hədəfi icazəsiz test etmə.
[[EN]]
## 1. What is this task for?
Read HTTP request/response headers and explain what they reveal about application behavior and security.

## 2. What should you know first?
Your safe lab plan, HTTP requests/responses, status codes, and headers. Use only your own local test app or written examples.

## 3. Step-by-step instructions
1. Continue your own lab plan from Task 1; do not submit the intern.az repository.
2. Choose a local test page or sample HTTP response.
3. Record status code, Content-Type, Cache-Control, Content-Security-Policy, and other visible headers.
4. Explain each header in plain language.
5. Identify at least three risks and fixes; do not treat a missing header alone as proof of exploitability.
6. Document the findings in a README/report.

## 4. What to submit
Your own GitHub repository or lab report, redacted request/response examples, header explanations, and three risk/fix suggestions. Never test a real target without authorization.$c2$ WHERE id='238aeac7-964e-4b68-8325-dbb78d9197cf'::uuid AND task_number=2 AND status='published';

UPDATE public.internship_tasks SET instructions = $c3$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Cross-site scripting (XSS) riskinin necə yarandığını təhlükəsiz nümunədə öyrənəcək və qorunma yollarını göstərəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
HTML, JavaScript və brauzerin mətn/HTML göstərməsi barədə ilkin bilik. Yalnız öz lokal nümunən və ya xüsusi təlim labı istifadə et.

## 3. Addım-addım təlimat
1. Öz lab repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. İstifadəçi mətnini göstərən sadə lokal səhifə hazırla.
3. Məlumatın təhlükəsiz mətn kimi göstərilməsi ilə HTML kimi interpretasiya edilməsinin fərqini müqayisə et.
4. Təhlükəsiz olmayan real payload-ları üçüncü tərəf saytlarda sınama; testləri lokalda zərərsiz nümunələrlə apar.
5. Output encoding və təhlükəsiz framework API-lərindən istifadəni tətbiq et.
6. Təhlükəsiz və təhlükəli davranış üçün test və screenshot əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, lokal demo, təhlükəsiz/təhlükəli davranış müqayisəsi, düzəliş və testlər. Real saytlara payload göndərmə.
[[EN]]
## 1. What is this task for?
Learn how cross-site scripting (XSS) risks arise and demonstrate defenses in a safe example.

## 2. What should you know first?
Basic HTML, JavaScript, and how browsers render text versus HTML. Use only your local example or a dedicated training lab.

## 3. Step-by-step instructions
1. Continue your own lab repository; do not submit the intern.az repository.
2. Build a simple local page that displays user-provided text.
3. Compare rendering input as safe text with interpreting it as HTML.
4. Do not test unsafe payloads on third-party sites; use harmless examples locally.
5. Apply output encoding and safe framework APIs.
6. Add tests and screenshots for safe and unsafe behavior.

## 4. What to submit
Your own GitHub repository, local demo, safe/unsafe behavior comparison, fix, and tests. Do not send payloads to real websites.$c3$ WHERE id='b09ca1de-24ad-4aa0-be2e-3268e68dfb32'::uuid AND task_number=3 AND status='published';

UPDATE public.internship_tasks SET instructions = $c4$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
SQL injection riskini izah edəcək və parametrli sorğuların niyə təhlükəsiz olduğunu nümayiş etdirəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
SQL SELECT, WHERE və parameterized query anlayışları. Lokal test bazası və sintetik data istifadə et; real sistemə sorğu göndərmə.

## 3. Addım-addım təlimat
1. Öz lab repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Sadə lokal axtarış endpoint-i və test bazası qur.
3. String birləşdirmə ilə qurulan sorğunun riskini kod səviyyəsində izah et; canlı hədəfdə istismar etmə.
4. Sorğunu parametrli query/prepared statement ilə yenidən yaz.
5. Normal input, xüsusi simvollar və gözlənilməyən input üçün test yaz.
6. Kod fərqini və nəticəni hesabatda müqayisə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, lokal demo, təhlükəli və parametrli sorğu nümunələri, testlər və qısa risk izahı. Testlər yalnız öz labında işləməlidir.
[[EN]]
## 1. What is this task for?
Explain SQL injection risk and demonstrate why parameterized queries are safer.

## 2. What should you know first?
SQL SELECT/WHERE and parameterized-query basics. Use a local test database and synthetic data; do not query real systems.

## 3. Step-by-step instructions
1. Continue your own lab repository; do not submit the intern.az repository.
2. Create a simple local search endpoint and test database.
3. Explain the risk of string-built queries at code level; do not exploit a live target.
4. Rewrite the query using parameters/prepared statements.
5. Test normal input, special characters, and unexpected input.
6. Compare the code and results in a report.

## 4. What to submit
Your own GitHub repository, local demo, unsafe-versus-parameterized query examples, tests, and a short risk explanation. Tests must run only in your lab.$c4$ WHERE id='f5e0e859-a7ef-4b9e-b8e3-cede613a2ad2'::uuid AND task_number=4 AND status='published';

UPDATE public.internship_tasks SET instructions = $c5$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
API və ya lokal tətbiqdə istifadəçinin yalnız icazəsi olan məlumatlara çıxışını yoxlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz test tətbiqin, authentication və authorization fərqi, user ID və resource ownership anlayışları. Yalnız lokal/səlahiyyətli lab-da test et.

## 3. Addım-addım təlimat
1. Öz lab layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. İki sintetik test istifadəçisi və hərəsinə aid ayrıca resurs yarat.
3. Login yoxlaması ilə resurs sahiblik yoxlamasının fərqini qeyd et.
4. Öz test tətbiqində bir istifadəçinin digərinin resurs ID-sinə müraciət etməsini sına.
5. Server-side ownership check əlavə et və unauthorized/forbidden cavablarını yoxla.
6. Uğurlu və rədd edilən giriş üçün test yaz; nəticəni şəxsi məlumat olmadan sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, access-control test planı, test nəticələri və düzəliş. Təkcə login olmaq başqa istifadəçinin məlumatına giriş icazəsi verməməlidir.
[[EN]]
## 1. What is this task for?
Check that users can access only resources they are authorized to use.

## 2. What should you know first?
Your own test app, authentication versus authorization, user IDs, and resource ownership. Test only in an authorized local lab.

## 3. Step-by-step instructions
1. Continue your own lab project; do not submit the intern.az repository.
2. Create two synthetic test users and separate resources for each.
3. Explain the difference between checking login and checking resource ownership.
4. In your own test app, try to access one user's resource using the other test user's ID.
5. Add a server-side ownership check and verify unauthorized/forbidden responses.
6. Test allowed and denied access and document results without personal data.

## 4. What to submit
Your own GitHub repository, access-control test plan, test results, and fix. Being logged in must not automatically grant access to another user's data.$c5$ WHERE id='59950234-5574-4d99-a175-cbe09354e21c'::uuid AND task_number=5 AND status='published';

UPDATE public.internship_tasks SET instructions = $c6$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
JWT token-in strukturunu və yoxlanmalı təhlükəsizlik xüsusiyyətlərini araşdıracaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz test tətbiqin, JSON, token expiration və signature anlayışları. Real token, cookie və hesab məlumatını paylaşma.

## 3. Addım-addım təlimat
1. Öz lab repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Uydurma test token-i və ya redaktə edilmiş nümunə seç.
3. Header, payload və signature hissələrini izah et; payload-un şifrələnmiş olmadığını qeyd et.
4. Expiration, issuer, audience və imza yoxlamasının rolunu yaz.
5. Lokal testdə vaxtı keçmiş və dəyişdirilmiş nümunələrin rədd edilməsini yoxla.
6. Token-i log-lara yazmamaq və secret-i paylaşmamaq üçün checklist əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, redaktə edilmiş token nümunəsi, JWT yoxlama checklist-i və test nəticələri. Real session token və ya secret təqdim etmə.
[[EN]]
## 1. What is this task for?
Review JWT structure and the security checks an application should perform.

## 2. What should you know first?
Your own test app, JSON, token expiration, and signature concepts. Never share real tokens, cookies, or account data.

## 3. Step-by-step instructions
1. Continue your own lab repository; do not submit the intern.az repository.
2. Use a fictional test token or a redacted example.
3. Explain header, payload, and signature, noting that the payload is not encrypted by default.
4. Describe expiration, issuer, audience, and signature validation.
5. In a local test, verify that expired and altered examples are rejected.
6. Add a checklist for keeping tokens out of logs and protecting secrets.

## 4. What to submit
Your own GitHub repository, a redacted token example, a JWT validation checklist, and test results. Never submit real session tokens or secrets.$c6$ WHERE id='72aa7a37-f757-4bac-8855-943065a534c0'::uuid AND task_number=6 AND status='published';

UPDATE public.internship_tasks SET instructions = $c7$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
API üçün əsas təhlükəsizlik yoxlama siyahısı hazırlayıb onu öz test endpoint-lərində tətbiq edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz lab API-n, authentication, authorization, validation, rate limiting və təhlükəsiz error cavabları haqqında əsas bilik.

## 3. Addım-addım təlimat
1. Öz lab layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. Endpoint-ləri və tələb olunan icazələri siyahıya al.
3. Input validation, ownership, rate limit, error response, CORS və secret handling üçün yoxlama maddələri yaz.
4. Hər maddəni pass/fail/not tested kimi işarələ və sübut əlavə et.
5. Ən azı 3 boşluğu riskə görə sıralayıb düzəliş planı hazırla.
6. Dəyişiklikdən sonra uyğun testləri təkrar işə sal.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, API security checklist, pass/fail sübutları və prioritetli düzəliş planı. İcazəsiz real API-ləri skan etmə.
[[EN]]
## 1. What is this task for?
Create a practical security checklist for an API and apply it to your own test endpoints.

## 2. What should you know first?
Your lab API and basics of authentication, authorization, validation, rate limiting, and safe error responses.

## 3. Step-by-step instructions
1. Continue your own lab project; do not submit the intern.az repository.
2. List endpoints and required permissions.
3. Add checks for input validation, ownership, rate limits, error responses, CORS, and secret handling.
4. Mark each item pass/fail/not tested and include evidence.
5. Rank at least three gaps by risk and prepare a remediation plan.
6. Rerun relevant tests after changes.

## 4. What to submit
Your own GitHub repository, API security checklist, pass/fail evidence, and prioritized remediation plan. Do not scan real APIs without authorization.$c7$ WHERE id='00cdcb69-5d36-47d2-9f78-ace37944b8db'::uuid AND task_number=7 AND status='published';

UPDATE public.internship_tasks SET instructions = $c8$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
OWASP ZAP-ın passive scan nəticələrini təhlükəsiz lab-da oxuyub yanlış pozitivləri ayırd edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz lab tətbiqin və ya yazılı icazə verilmiş test target-i, HTTP/headers əsasları və ZAP hesabatı oxuma bacarığı. İcazəsiz sayt skan etmə.

## 3. Addım-addım təlimat
1. Öz lab repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. ZAP-ı yalnız localhost və ya yazılı icazə verilmiş target-ə yönəlt.
3. Passive scan istifadə et; aktiv hücum/active scan başlatma.
4. Tapıntıların adını, severity-ni, evidence-ni və təsirlənən URL-i qeyd et; həssas məlumatı redaktə et.
5. Hər tapıntını əl ilə nəzərdən keçir və real problem, yanlış pozitiv, yoxlanmayıb kimi təsnif et.
6. Ən vacib 2–3 tapıntı üçün düzəliş təklifi və retest planı yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, redaktə edilmiş ZAP passive report, finding triage cədvəli və düzəliş/retest planı. Target-in icazəli olduğunu sənədləşdir.
[[EN]]
## 1. What is this task for?
Review OWASP ZAP passive-scan findings in a safe lab and distinguish likely issues from false positives.

## 2. What should you know first?
Your own lab app or a target with written authorization, HTTP/header basics, and the ability to read a ZAP report. Do not scan sites without permission.

## 3. Step-by-step instructions
1. Continue your own lab repository; do not submit the intern.az repository.
2. Point ZAP only at localhost or an explicitly authorized target.
3. Use passive scanning only; do not start active attacks/scans.
4. Record finding name, severity, evidence, and affected URL; redact sensitive data.
5. Review each finding manually and label it confirmed, false positive, or unverified.
6. Suggest fixes and retest plans for the two or three highest-priority findings.

## 4. What to submit
Your own GitHub repository, a redacted ZAP passive report, a finding-triage table, and remediation/retest plan. Document authorization for the target.$c8$ WHERE id='f494e298-b2e7-48c1-955a-2c3fa7e3d3a3'::uuid AND task_number=8 AND status='published';

UPDATE public.internship_tasks SET instructions = $c9$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Öz test tətbiqində tapılmış təhlükəsiz kod problemini düzəldəcək və testlə təkrar yaranmasının qarşısını alacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz lab layihən, code review, test yazmaq və input validation/authorization əsasları. Yalnız öz kodunda və sintetik məlumatla işlə.

## 3. Addım-addım təlimat
1. Öz lab repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Əvvəlki auditdən bir təsdiqlənmiş problem seç; real sistemdən exploit götürmə.
3. Problemin necə təkrarlanacağını və istifadəçiyə təsirini yaz.
4. Minimal düzəliş et və problemi göstərən regression test əlavə et.
5. Bütün testləri yenidən işə sal və yan təsirləri yoxla.
6. Diff-də nə dəyişdiyini və qalan riskləri izah et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, finding izahı, düzəliş diff-i, regression test və test nəticələri. Həssas kod və ya credential paylaşma.
[[EN]]
## 1. What is this task for?
Fix a confirmed security issue in your own test app and prevent regression with a test.

## 2. What should you know first?
Your own lab project, code review, testing, and input-validation/authorization basics. Work only with your own code and synthetic data.

## 3. Step-by-step instructions
1. Continue your own lab repository; do not submit the intern.az repository.
2. Choose one confirmed issue from your earlier audit; do not copy an exploit from a real system.
3. Document reproduction steps and user impact.
4. Make a minimal fix and add a regression test that demonstrates the issue.
5. Rerun all tests and check for side effects.
6. Explain the diff and any remaining risks.

## 4. What to submit
Your own GitHub repository, finding explanation, fix diff, regression test, and test results. Do not share sensitive code or credentials.$c9$ WHERE id='e1bac5e5-1de0-49d4-9807-5f2f5c124ee1'::uuid AND task_number=9 AND status='published';

UPDATE public.internship_tasks SET instructions = $c10$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Təhlükəsizlik yoxlamasının nəticələrini rəhbər və developer üçün aydın, sübutlu hesabat şəklində təqdim edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz Task 1–9 materialların, risk/severity anlayışı və remediation planı. Həqiqi test aparılmayıbsa, nəticəni uydurma.

## 3. Addım-addım təlimat
1. Öz lab repo-nun əvvəlki nəticələrini davam etdir; intern.az repo-sunu təqdim etmə.
2. Əhatə dairəsini, icazəni, istifadə olunan alətləri və məhdudiyyətləri yaz.
3. Finding-ləri təsir və ehtimala görə sıralayıb sübut əlavə et.
4. Hər finding üçün risk, düzəliş, prioritet və retest addımı yaz.
5. Şəxsi məlumat, token, cookie və həssas URL-ləri redaktə et.
6. Qısa rəhbər xülasəsi və developer üçün texniki bölmə hazırla.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, təhlükəsizlik hesabatı, prioritetli remediation planı və retest statusu. Scope və məhdudiyyətlər açıq yazılmalı, yoxlanmayan iddialar fakt kimi göstərilməməlidir.
[[EN]]
## 1. What is this task for?
Present security-review results in a clear, evidence-based report for both leadership and developers.

## 2. What should you know first?
Your artifacts from Tasks 1–9, risk/severity concepts, and remediation planning. Never invent results for tests you did not perform.

## 3. Step-by-step instructions
1. Continue the findings from your own lab; do not submit the intern.az repository.
2. Document scope, authorization, tools, and limitations.
3. Rank findings by impact and likelihood and include evidence.
4. For each finding, state risk, fix, priority, and retest steps.
5. Redact personal data, tokens, cookies, and sensitive URLs.
6. Prepare an executive summary and a technical section for developers.

## 4. What to submit
Your own GitHub repository, security report, prioritized remediation plan, and retest status. State scope and limitations clearly, and never present unverified claims as facts.$c10$ WHERE id='3c921fff-ebc5-4110-a5e4-474eb2efcfd9'::uuid AND task_number=10 AND status='published';

COMMIT;
