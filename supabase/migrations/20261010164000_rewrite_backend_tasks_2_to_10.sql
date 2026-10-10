BEGIN;

UPDATE public.internship_tasks SET instructions = $b2$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Layihə, üzv və tapşırıq cədvəllərini əlaqələndirən PostgreSQL məlumat modeli quracaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Task 1-dəki öz backend repo-n, SQL cədvəl/primary key/foreign key anlayışları və PostgreSQL-in əsasları. Yalnız lokal və ya test bazası istifadə et.

## 3. Addım-addım təlimat
1. Öz backend repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Projects, users və tasks cədvəllərinin sütunlarını və UUID primary key-lərini müəyyən et.
3. Project membership üçün ayrıca əlaqə cədvəli yarat; foreign key və unique constraint-lər əlavə et.
4. Task sahibi, yaradılma vaxtı və status sahələrini müəyyən et.
5. Ən azı 10 sintetik qeyd daxil et və valid/invalid əlaqələri yoxla.
6. Schema diagramı və migration addımlarını README-də sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, schema/migration SQL, ER diaqramı, sintetik seed data və constraint-ləri yoxlayan test sorğuları. Yanlış foreign key və təkrar üzvlük rədd edilməlidir.
[[EN]]
## 1. What is this task for?
Design a PostgreSQL data model connecting projects, members, and tasks.

## 2. What should you know first?
Your own backend repository from Task 1, SQL tables/primary keys/foreign keys, and PostgreSQL basics. Use only a local or test database.

## 3. Step-by-step instructions
1. Continue your own backend repository; do not submit the intern.az repository.
2. Define columns and UUID primary keys for projects, users, and tasks.
3. Create a separate project-membership table with foreign keys and unique constraints.
4. Define task owner, creation time, and status fields.
5. Insert at least ten synthetic records and test valid/invalid relationships.
6. Document the schema diagram and migration steps in the README.

## 4. What to submit
Your own GitHub repository link, schema/migration SQL, ER diagram, synthetic seed data, and test queries for constraints. Invalid foreign keys and duplicate memberships must be rejected.$b2$ WHERE id='b2000000-0000-4000-8000-000000000002'::uuid AND task_number=2 AND status='published';

UPDATE public.internship_tasks SET instructions = $b3$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Qeydiyyat və giriş axınında məlumatı yoxlayacaq, parolu təhlükəsiz saxlayacaq və artıq hesab məlumatını açıqlamayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz backend repo-n, HTTP request/response, validation və parol hash anlayışı. Lokal test bazası və ya mock auth istifadə et; real istifadəçi məlumatı işlətmə.

## 3. Addım-addım təlimat
1. Öz repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Qeydiyyat və giriş endpoint-ləri üçün request/response formatlarını müəyyən et.
3. Email formatı, parol minimumları və məcburi sahələr üçün validation yaz.
4. Parolu plaintext saxlamadan uyğun password-hashing kitabxanasından istifadə et; öz hash alqoritmini yazma.
5. Yanlış parol və mövcud olmayan hesab üçün eyni ümumi error mesajı qaytar.
6. Uğurlu giriş, invalid input, yanlış credential və təkrar email halları üçün testlər yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, auth endpoint-ləri, validation/hash tətbiqi, testlər və təhlükəsizlik qərarlarını izah edən README. Log və cavablarda parol/token görünməməlidir.
[[EN]]
## 1. What is this task for?
Validate registration and login, store passwords safely, and avoid revealing unnecessary account information.

## 2. What should you know first?
Your own backend repository, HTTP requests/responses, validation, and password hashing. Use a local test database or mock auth and never use real user data.

## 3. Step-by-step instructions
1. Continue your own repository; do not submit the intern.az repository.
2. Define request/response formats for registration and login endpoints.
3. Validate email format, password requirements, and required fields.
4. Use a reputable password-hashing library; never store plaintext passwords or invent your own hashing algorithm.
5. Return the same general error for a wrong password and a nonexistent account.
6. Test successful login, invalid input, incorrect credentials, and duplicate email.

## 4. What to submit
Your own GitHub repository link, auth endpoints, validation/hashing implementation, tests, and a README explaining security decisions. Passwords and tokens must never appear in logs or responses.$b3$ WHERE id='b2000000-0000-4000-8000-000000000003'::uuid AND task_number=3 AND status='published';

UPDATE public.internship_tasks SET instructions = $b4$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Task yaratmaq, siyahılamaq və statusunu dəyişmək üçün tam backend servisi hazırlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz backend repo-n, REST API, SQL migration, validation, authentication və testlərin əsasları. Yalnız sintetik istifadəçi və məlumatlardan istifadə et.

## 3. Addım-addım təlimat
1. Öz əvvəlki backend layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. Task create/list/detail/status-update endpoint-lərini qur.
3. Hər endpoint üçün input schema, status code və error formatı müəyyən et.
4. Hər istifadəçinin yalnız özünə icazə verilən task-lara baxmasını server tərəfdə yoxla.
5. Migration və seed data əlavə et; production bazasına qoşulma.
6. Uğurlu axın, invalid input, missing ID və ownership pozuntusu üçün test yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işlək API, migration/seed, endpoint nümunələri və test nəticələri. Başqa istifadəçinin task-ına icazəsiz baxış və dəyişiklik mümkün olmamalıdır.
[[EN]]
## 1. What is this task for?
Build a backend service to create tasks, list them, and update their status.

## 2. What should you know first?
Your own backend repository, REST APIs, SQL migrations, validation, authentication, and basic testing. Use synthetic users and data only.

## 3. Step-by-step instructions
1. Continue your own backend project; do not submit the intern.az repository.
2. Implement task create/list/detail/status-update endpoints.
3. Define input schemas, status codes, and error formats for each endpoint.
4. Enforce on the server that users can access only tasks they are authorized to see.
5. Add migrations and seed data; do not connect to a production database.
6. Test success, invalid input, missing IDs, and ownership violations.

## 4. What to submit
Your own GitHub repository link, working API, migrations/seed data, endpoint examples, and test results. Unauthorized access to or modification of another user's task must be prevented.$b4$ WHERE id='b2000000-0000-4000-8000-000000000004'::uuid AND task_number=4 AND status='published';

UPDATE public.internship_tasks SET instructions = $b5$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Layihə endpoint-inə axtarış, status filter-i və sabit səhifələmə əlavə edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz backend repo-n, SQL query-lər, API query parametrləri və testlər. Ən azı 100 sintetik layihə istifadə et.

## 3. Addım-addım təlimat
1. Öz backend repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Search, status filter, page və page size parametrləri əlavə et.
3. Maksimum page size təyin et və invalid parametr üçün aydın validation qaytar.
4. Nəticələri created_at və unikal ID ilə sıralayaraq səhifələr arasında sabit sıra təmin et.
5. Test data ilə bir neçə səhifəni oxu, filter/search birləşməsini yoxla.
6. Empty result, invalid page size və page sərhədləri üçün test yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, yenilənmiş endpoint, 100+ sintetik qeyd və testlər. Eyni dataset dəyişmədikdə səhifələr arasında təkrar və itmiş qeyd olmamalıdır.
[[EN]]
## 1. What is this task for?
Add search, status filtering, and stable pagination to a project endpoint.

## 2. What should you know first?
Your own backend repository, SQL queries, API query parameters, and testing. Use at least 100 synthetic projects.

## 3. Step-by-step instructions
1. Continue your own backend repository; do not submit the intern.az repository.
2. Add search, status filter, page, and page-size parameters.
3. Set a maximum page size and return clear validation for invalid parameters.
4. Sort by creation time and a unique ID to keep ordering stable across pages.
5. Read multiple pages from test data and verify combined filter/search behavior.
6. Test empty results, invalid page size, and page boundaries.

## 4. What to submit
Your own GitHub repository link, updated endpoint, 100+ synthetic records, and tests. With an unchanged dataset, records must not be duplicated or skipped across pages.$b5$ WHERE id='07dd8c57-2660-4fc0-9547-5251cbc0b8b7'::uuid AND task_number=5 AND status='published';

UPDATE public.internship_tasks SET instructions = $b6$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Layihə və onun ilkin üzvlərini bir əməliyyat kimi yaratmağı təmin edəcəksən. Addımlardan biri uğursuz olsa, natamam məlumat qalmamalıdır.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz backend repo-n, database transaction, foreign key və rollback anlayışları. Test bazasında işləyib sintetik məlumatlardan istifadə et.

## 3. Addım-addım təlimat
1. Öz backend layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. Project və project_members cədvəllərini müəyyən et.
3. Layihə və üzvlərin əlavə olunmasını bir transaction daxilində icra et.
4. Duplicate member, olmayan user və constraint xətası yaradan test input-lar hazırla.
5. Hər uğursuz ssenaridən sonra bazada natamam project/member qalmadığını yoxla.
6. Uğurlu və rollback ssenarilərini avtomatlaşdırılmış testlərlə təsdiqlə.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, transaction implementasiyası, testlər və rollback sübutu. Hər hansı addım uğursuz olduqda bütün əməliyyat geri qaytarılmalıdır.
[[EN]]
## 1. What is this task for?
Create a project and its initial members as one atomic operation. If a step fails, no partial data should remain.

## 2. What should you know first?
Your own backend repository, database transactions, foreign keys, and rollback. Work against a test database with synthetic data.

## 3. Step-by-step instructions
1. Continue your own backend project; do not submit the intern.az repository.
2. Define the projects and project_members tables.
3. Insert the project and members within one transaction.
4. Prepare test inputs for duplicate members, nonexistent users, and constraint failures.
5. After each failure, verify that no partial project/member rows remain.
6. Automate success and rollback checks.

## 4. What to submit
Your own GitHub repository link, transaction implementation, tests, and rollback evidence. Any failed step must roll back the entire operation.$b6$ WHERE id='38c90373-02fb-42a6-9d34-b96322307215'::uuid AND task_number=6 AND status='published';

UPDATE public.internship_tasks SET instructions = $b7$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Backend API-nin istifadə qaydalarını OpenAPI sənədində dəqiq və yoxlanıla bilən göstərəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz backend repo-n, HTTP metodları, JSON schema və status code-lar. Mövcud endpoint-lərdən istifadə et.

## 3. Addım-addım təlimat
1. Öz backend repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Create/list/detail/update endpoint-lərini sənədləşdir.
3. Hər endpoint üçün method, path, parametrlər, request/response nümunəsi və status code yaz.
4. Auth tələb olunan əməliyyatları, validation error və not-found cavablarını göstər.
5. OpenAPI faylını validator və ya Swagger UI ilə yoxla.
6. README-yə sənədi necə açmağı və API-ni necə sınaqdan keçirməyi əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, OpenAPI faylı, ən azı 5 request/response nümunəsi və validation nəticəsi. Sənəd faktiki API davranışı ilə uyğun olmalıdır.
[[EN]]
## 1. What is this task for?
Document your backend API in OpenAPI so its behavior is clear and testable.

## 2. What should you know first?
Your own backend repository, HTTP methods, JSON schemas, and status codes. Document the endpoints that actually exist.

## 3. Step-by-step instructions
1. Continue your own backend repository; do not submit the intern.az repository.
2. Document create/list/detail/update endpoints.
3. For each endpoint, specify method, path, parameters, request/response examples, and status codes.
4. Document protected operations, validation errors, and not-found responses.
5. Validate the OpenAPI file with a validator or Swagger UI.
6. Add instructions for viewing the docs and testing the API to the README.

## 4. What to submit
Your own GitHub repository link, OpenAPI file, at least five request/response examples, and validation results. The documentation must match actual API behavior.$b7$ WHERE id='a5df5782-f577-4a39-8578-4632942e0365'::uuid AND task_number=7 AND status='published';

UPDATE public.internship_tasks SET instructions = $b8$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Task service üçün vacib iş qaydalarını avtomatlaşdırılmış testlərlə yoxlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz backend layihən, istifadə etdiyin test framework və test bazası/in-memory adapter. Testlər production məlumatına toxunmamalıdır.

## 3. Addım-addım təlimat
1. Öz repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Unit testlər üçün service qaydalarını, integration test üçün isə database davranışını seç.
3. Task yaratma, ownership, status dəyişikliyi və olmayan ID ssenarilərini əhatə et.
4. Hər test üçün ilkin data və gözlənilən nəticəni müəyyən et.
5. Testlər arasında data təmizlə və testləri təkrarən işə salaraq sabitliyini yoxla.
6. Uğursuz test mesajlarının problemi anlamağa kömək etdiyini yoxla.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, unit və ən azı bir database integration test, testləri işə salma təlimatı və nəticə. Testlər bir-birindən asılı olmadan işləməlidir.
[[EN]]
## 1. What is this task for?
Use automated tests to verify important business rules in the task service.

## 2. What should you know first?
Your own backend project, its test framework, and a test database or in-memory adapter. Tests must not touch production data.

## 3. Step-by-step instructions
1. Continue your own repository; do not submit the intern.az repository.
2. Separate service-rule unit tests from database integration tests.
3. Cover task creation, ownership, status changes, and nonexistent IDs.
4. Define setup data and expected results for every test.
5. Clean up between tests and rerun them to check stability.
6. Make sure failure messages help identify the problem.

## 4. What to submit
Your own GitHub repository link, unit tests and at least one database integration test, test instructions, and results. Tests must run independently.$b8$ WHERE id='07996918-e38c-4b96-bf96-58887db1c1ba'::uuid AND task_number=8 AND status='published';

UPDATE public.internship_tasks SET instructions = $b9$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
API sorğularını izləmək üçün request ID və strukturlaşdırılmış log əlavə edəcək, istifadəçiyə vahid error formatı qaytaracaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz backend repo-n, HTTP middleware, logging və exception handling əsasları. Log-lara email, token, parol və request body yazma.

## 3. Addım-addım təlimat
1. Öz backend layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. Hər request-ə request ID əlavə et və cavabda da qaytar.
3. Success, validation error və gözlənilməz server xətası ssenarilərini qur.
4. İstifadəçiyə təhlükəsiz, ardıcıl error schema qaytar; daxili stack trace-i ictimai cavaba çıxarma.
5. Log-ların secret və şəxsi məlumat saxlamadığını test et.
6. Request ID və error formatını README-də sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, middleware/logging implementasiyası, error response nümunələri və testlər. Log-lar sorğunu izləməyə imkan verməli, lakin secret və şəxsi məlumat açıqlamamalıdır.
[[EN]]
## 1. What is this task for?
Add request IDs and structured logs to trace API requests while returning a consistent error format.

## 2. What should you know first?
Your own backend repository, HTTP middleware, logging, and exception handling. Never log email, tokens, passwords, or request bodies.

## 3. Step-by-step instructions
1. Continue your own backend project; do not submit the intern.az repository.
2. Assign a request ID to each request and include it in the response.
3. Create success, validation-error, and unexpected-server-error scenarios.
4. Return a safe, consistent error schema; do not expose internal stack traces publicly.
5. Test that logs contain no secrets or personal data.
6. Document request IDs and the error format in the README.

## 4. What to submit
Your own GitHub repository link, middleware/logging implementation, error-response examples, and tests. Logs must help trace requests without exposing secrets or personal information.$b9$ WHERE id='cf908a76-2215-41b8-93b0-4dd90ec7b6ed'::uuid AND task_number=9 AND status='published';

UPDATE public.internship_tasks SET instructions = $b10$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Backend servisini yeni mühitdə işə düşən və CI-da yoxlanan deployment paketinə çevirəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz backend repo-n, environment variables, health endpoint, testlər və deployment əsasları. Docker və ya hosted platforma məcburi deyil; lokal işləyən alternativ qəbul edilir.

## 3. Addım-addım təlimat
1. Öz backend layihəni davam etdir; intern.az repo-sunu təqdim etmə.
2. Start command və tələb olunan environment dəyişənlərini müəyyən et.
3. Health endpoint əlavə et; database readiness yoxlaması varsa, onun davranışını sənədləşdir.
4. Mövcud layihəyə uyğun Dockerfile və ya platforma start təlimatı hazırla. Docker yoxdursa, lokal alternativi təqdim et.
5. CI workflow-da testləri və build/check addımını işə sal.
6. Migration addımını, uğursuz start davranışını və secret-lərin necə veriləcəyini sənədləşdir. Heç bir secret-i repo-ya yazma.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, deployment/start konfiqurasiyası, CI workflow, health check nəticəsi və README. Yeni mühitdə quraşdırma addımları təkrarlana bilməlidir.
[[EN]]
## 1. What is this task for?
Package your backend so it can start in a fresh environment and be checked in CI.

## 2. What should you know first?
Your own backend repository, environment variables, health endpoints, tests, and deployment basics. Docker or a hosted platform is optional; a working local alternative is acceptable.

## 3. Step-by-step instructions
1. Continue your own backend project; do not submit the intern.az repository.
2. Define the start command and required environment variables.
3. Add a health endpoint and document any database-readiness behavior.
4. Provide a Dockerfile or platform start instructions appropriate to your project. If Docker is unavailable, provide a local alternative.
5. Configure CI to run tests and a build/check step.
6. Document migrations, failed-start behavior, and secret configuration. Never commit secrets.

## 4. What to submit
Your own GitHub repository link, deployment/start configuration, CI workflow, health-check result, and README. Setup must be repeatable in a fresh environment.$b10$ WHERE id='01fa5a45-752d-4649-93ea-bb3d8c3a886b'::uuid AND task_number=10 AND status='published';

COMMIT;
