-- Data-only curriculum refresh for intern.az.
-- Updates only description, instructions, and week_number on 80 existing published tasks.
-- Every block checks its exact source row count and checks target collisions against the production UNIQUE key.
BEGIN;

DO $curriculum_applied_ai_engineering_1$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_applied_ai_engineering_1 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_applied_ai_engineering_1 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('applied-ai-engineering', 1, 1, 1, $applied_ai_engineering_1_desc_1$[[AZ]]
Təkrarlana bilən prompt şablonu qur və onun qeyri-müəyyən girişlərdə necə davranacağını yoxla.

[[EN]]
Build a reusable prompt template and test how it behaves with ambiguous inputs.$applied_ai_engineering_1_desc_1$, $applied_ai_engineering_1_inst_1$[[AZ]]
## Məqsəd
Dəstək müraciətlərini “ödəniş”, “giriş” və “digər” kateqoriyalarına ayıran, sabit JSON qaytaran prompt hazırla.

## Ssenari və başlanğıc
12 sintetik müştəri mesajı qur; ən azı 3-ü qısa və qeyri-müəyyən olsun. Modeldən kateqoriya, qısa səbəb və etibarlılıq balı istə.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. Giriş və çıxış formatını dəqiqləşdir.
2. Promptda rol, qaydalar, nümunələr və naməlum hal üçün davranışı yaz.
3. 12 mesajın hamısını eyni şablonla sına.
4. Səhv kateqoriyaları qeyd edib promptu bir dəfə təkmilləşdir.

## Təhvil veriləcək
- Prompt şablonu və 12 sınaq girişi.
- Gözlənilən və alınan nəticələri göstərən cədvəl.
- Ən azı 3 səhv hal və edilmiş düzəliş.

## Qəbul meyarları
- Hər cavab tələb olunan JSON sahələrini saxlayır.
- Naməlum mesaja uydurma cavab vermək əvəzinə aşağı etibarlılıq verir.
- Eyni giriş təkrar sınaqda eyni qərara yaxındır.

## Qiymətləndirmə
Format 25, kateqoriya keyfiyyəti 30, kənar hallar 25, izah 20 bal.

## Təqdim etmə
GitHub repo linki, README və nəticə cədvəlini əlavə et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Create a prompt that classifies support messages as billing, access, or other and returns stable JSON.

## Scenario and starting point
Write 12 synthetic customer messages; at least three should be short or ambiguous. Request a category, a brief reason, and a confidence score.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Define the input and output contract.
2. Specify role, rules, examples, and behavior for unknown cases.
3. Run all 12 messages through the same template.
4. Record misclassifications and make one measured prompt revision.

## Deliverables
- Reusable prompt template and 12 test inputs.
- A table comparing expected and actual results.
- At least three failure cases with the change made for each.

## Acceptance criteria
- Every response keeps the required JSON fields.
- An unknown message gets low confidence instead of an invented answer.
- Repeated runs on the same input produce a consistent decision.

## Evaluation
Format 25, classification quality 30, edge cases 25, explanation 20 points.

## Submission
Submit a GitHub repository link with a README and the results table.

## Estimated time
4-6 hours.$applied_ai_engineering_1_inst_1$),
  ('applied-ai-engineering', 3, 2, 2, $applied_ai_engineering_1_desc_2$[[AZ]]
Sintetik daxili qaydalar toplusu üzrə mənbə göstərən sual-cavab prototipi qur.

[[EN]]
Build a source-citing Q&A prototype over a synthetic set of internal policy documents.$applied_ai_engineering_1_desc_2$, $applied_ai_engineering_1_inst_2$[[AZ]]
## Məqsəd
Sənəd suallarına yalnız təqdim olunan mətndən cavab verən və uyğun parçanı göstərən prototip yarat.

## Ssenari və başlanğıc
İş saatları, məzuniyyət və avadanlıq sifarişi barədə 5 qısa sintetik qayda sənədi hazırla. Cavabı sənəddə olmayan 5 sual da əlavə et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. Sənədləri kiçik, axtarıla bilən hissələrə böl.
2. Sadə açar söz axtarışı və ya lokal embedding seç; seçimi README-də əsaslandır.
3. Hər sual üçün ən uyğun parçanı tapıb cavaba mənbə etiketi əlavə et.
4. Cavabı olmayan sualda “mənbədə yoxdur” qaytar və 10 sualı yoxla.

## Təhvil veriləcək
- Kod və sintetik mənbə sənədləri.
- 10 suallıq nəticə cədvəli, hər cavab üçün mənbə ID-si.
- Quraşdırma və məhdudiyyətləri izah edən README.

## Qəbul meyarları
- Cavab yalnız tapılan mənbə ilə dəstəklənir.
- Mənbəsiz sual üçün uydurma siyasət yaratmır.
- Hər cavabın sənəd və hissə göstəricisi var.

## Qiymətləndirmə
Mənbə uyğunluğu 35, cavab düzgünlüyü 30, abstention 20, quraşdırma 15 bal.

## Təqdim etmə
GitHub repo linki, README və sınaq cədvəlini təqdim et.

## Təxmini vaxt
6-8 saat.

[[EN]]
## Objective
Build a prototype that answers document questions only from supplied text and cites the supporting passage.

## Scenario and starting point
Create five short synthetic policies about working hours, leave, and equipment requests. Add five questions whose answers are not present.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Split the documents into small searchable passages.
2. Choose keyword search or local embeddings and explain the choice in the README.
3. Retrieve a passage for each question and attach its source label to the answer.
4. Return “not found in sources” when unsupported, then test all ten questions.

## Deliverables
- Code and synthetic source documents.
- Results for ten questions with a source ID for each answer.
- README with setup steps and known limits.

## Acceptance criteria
- Every factual answer is supported by a retrieved passage.
- Unsupported questions do not produce invented policy.
- Each answer identifies its document and passage.

## Evaluation
Source relevance 35, answer accuracy 30, abstention 20, setup quality 15 points.

## Submission
Submit a GitHub repository link, README, and test table.

## Estimated time
6-8 hours.$applied_ai_engineering_1_inst_2$),
  ('applied-ai-engineering', 4, 5, 3, $applied_ai_engineering_1_desc_3$[[AZ]]
Prompt-un hansı hallarda sıradan çıxdığını ölç və düzəlişləri riskə görə prioritetləşdir.

[[EN]]
Measure where a prompt fails and prioritize fixes by risk.$applied_ai_engineering_1_desc_3$, $applied_ai_engineering_1_inst_3$[[AZ]]
## Məqsəd
Mövcud kateqoriyalaşdırma promptu üçün sistemli uğursuzluq sınaqları hazırlayıb ən zərərli səhvləri azalt.

## Ssenari və başlanğıc
Ödəniş, hesab girişi və ümumi sual mövzularında 15 sintetik mesaj yaz. Qarışıq niyyət, yazı səhvi, boş giriş və təlimatı dəyişməyə çalışan mesaj daxil et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. Hər giriş üçün gözlənilən qərarı və risk səviyyəsini əvvəlcədən müəyyən et.
2. İlkin prompt-u işə sal və alınan nəticəni qeyd et.
3. Səhvləri format, təsnifat və təhlükəsizlik üzrə qruplaşdır.
4. Ən yüksək riskli üç səhv üçün qayda əlavə et və testləri yenilə.

## Təhvil veriləcək
- 15 hal üçün etalon qərar və risk cədvəli.
- İlkin və yenilənmiş prompt-lar, hər ikisinin nəticələri.
- Həll olunmamış məhdudiyyətlər barədə qısa hesabat.

## Qəbul meyarları
- Ən azı dörd fərqli xəta növü yoxlanılıb.
- Həssas məlumat və qaydanı dəyişmə cəhdləri ayrıca müəyyən edilir.
- Yeni prompt-un ümumi düzgün təsnifat göstəricisi pisləşmir.

## Qiymətləndirmə
Əhatə 25, risk prioriteti 25, yaxşılaşma sübutu 35, hesabat 15 bal.

## Təqdim etmə
GitHub repo və ya hesabat faylı təqdim et; hər iki prompt-u və nəticə cədvəlini əlavə et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Create systematic failure tests for a classification prompt and reduce the most harmful errors.

## Scenario and starting point
Write 15 synthetic messages about billing, account access, and general questions. Include mixed intent, a typo, empty input, and an attempt to override the instructions.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Set the expected decision and risk level for every input before running the prompt.
2. Run the baseline prompt and record each result.
3. Label failures as format, classification, or safety issues.
4. Add rules for the three highest-risk failures and rerun the suite.

## Deliverables
- Fifteen cases with expected decisions and a risk table.
- Baseline and revised prompts with results for both.
- A short report of unresolved limitations.

## Acceptance criteria
- The suite covers at least four distinct failure types.
- Sensitive or instruction-override attempts are identified separately.
- The revised prompt does not reduce total correct classifications.

## Evaluation
Coverage 25, risk ranking 25, evidence of improvement 35, report 15 points.

## Submission
Submit a repository or report file containing both prompts and the test table.

## Estimated time
4-6 hours.$applied_ai_engineering_1_inst_3$),
  ('applied-ai-engineering', 4, 6, 4, $applied_ai_engineering_1_desc_4$[[AZ]]
Alət çağırışını sxemlə məhdudlaşdır, girişləri yoxla və alət xətalarını idarə et.

[[EN]]
Constrain a tool call with a schema, validate inputs, and handle tool failures.$applied_ai_engineering_1_desc_4$, $applied_ai_engineering_1_inst_4$[[AZ]]
## Məqsəd
Təqvim tədbiri yaratmaq üçün modelin sərbəst mətn yox, yoxlanıla bilən strukturlaşdırılmış alət çağırışı verməsini təmin et.

## Ssenari və başlanğıc
Təqvim servisini real qoşmadan saxta funksiya qur. Giriş: tədbir adı, tarix, başlanğıc və bitiş vaxtı; tarix keçmişdə və bitiş başlanğıcdan əvvəl ola bilər.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. Alət sxemində tələb olunan sahələr və formatları təyin et.
2. Çağırışdan əvvəl tarix və vaxt ardıcıllığını yoxla.
3. Uğurlu nəticə, sxem xətası və service timeout üçün üç cavab yaz.
4. 8 sintetik sorogla normal və səhv halları sına.

## Təhvil veriləcək
- Sxem, validator və saxta alət implementasiyası.
- 8 test sorğusu və gözlənilən nəticə.
- Xətaya davamlı cavab davranışını izah edən README.

## Qəbul meyarları
- Sxemə uyğun olmayan çağırış alətə ötürülmür.
- Səhv tarix və timeout istifadəçiyə təhlükəsiz, aydın xəta verir.
- Tool success idempotent və strukturlaşdırılmış nəticə qaytarır.

## Qiymətləndirmə
Sxem 30, validator 25, xəta halları 25, test/README 20 bal.

## Təqdim etmə
GitHub repoya kod və README yerləşdir.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Make a model use a validated structured tool call, rather than free text, to create a calendar event.

## Scenario and starting point
Use a mocked calendar function, not a live service. Inputs are event name, date, start time, and end time; dates may be in the past or the end may precede the start.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Define required fields and formats in the tool schema.
2. Validate the date and time order before invoking the tool.
3. Define responses for success, schema rejection, and a service timeout.
4. Test normal and invalid behavior with eight synthetic requests.

## Deliverables
- Schema, validator, and mocked tool implementation.
- Eight test requests with expected outcomes.
- README explaining safe error handling.

## Acceptance criteria
- A schema-invalid call never reaches the tool.
- Invalid dates and timeouts produce clear, safe errors.
- Successful calls return an idempotent structured result.

## Evaluation
Schema 30, validation 25, error handling 25, tests and README 20 points.

## Submission
Add the code and README to a GitHub repository.

## Estimated time
5-7 hours.$applied_ai_engineering_1_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_applied_ai_engineering_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'applied-ai-engineering batch 1: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_applied_ai_engineering_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'applied-ai-engineering batch 1: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_applied_ai_engineering_1 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'applied-ai-engineering batch 1: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_applied_ai_engineering_1;
END
$curriculum_applied_ai_engineering_1$;

DO $curriculum_applied_ai_engineering_2$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_applied_ai_engineering_2 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_applied_ai_engineering_2 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('applied-ai-engineering', 5, 3, 5, $applied_ai_engineering_2_desc_1$[[AZ]]
Kiçik etalon dəstində AI cavab keyfiyyətini ölç və qərarını rəqəmlə əsaslandır.

[[EN]]
Measure AI answer quality on a small benchmark and justify decisions with evidence.$applied_ai_engineering_2_desc_1$, $applied_ai_engineering_2_inst_1$[[AZ]]
## Məqsəd
Sintetik FAQ sualları üçün cavabların düzgünlüyünü, mənbə dəstəyini və format uyğunluğunu qiymətləndirən mini hesabat hazırla.

## Ssenari və başlanğıc
10 sual və etalon cavab qur; onlardan 2-si cavab verilməməli, 2-si mənbə tələb etməlidir. Eyni model çıxışını meyarlarla skorla.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. Hər meyar üçün nümunələrlə 0/1 və ya 0–2 şkalası müəyyən et.
2. Cavabları əl ilə yoxla və ya kiçik deterministik qiymətləndirici yaz.
3. Ümumi balı və səhv növlərinə görə nəticəni hesabla.
4. Ölçülməyən keyfiyyətləri hesabatda qeyd et.

## Təhvil veriləcək
- Etalon cavabları olan 10 suallıq sınaq dəsti.
- Qiymətləndirmə cədvəli, iki səhv nümunəsi və düzəliş təklifi.
- Bir-iki səhifəlik qısa hesabat.

## Qəbul meyarları
- Etalon cavablar və qiymətləndirmə qaydaları bir-birinə uyğundur.
- Sistem xətası subyektiv qiymətləndirmədən ayrılır.
- Nəticələrdən çıxan ən azı bir konkret dəyişiklik təklifi var.

## Qiymətləndirmə
Etalon dəstinin keyfiyyəti 25, ölçülər 30, təhlil 30, məhdudiyyətlər 15 bal.

## Təqdim etmə
Cədvəl və hesabatı PDF/Markdown faylı və ya GitHub repo ilə təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Prepare a mini report that scores synthetic FAQ answers for correctness, source support, and format compliance.

## Scenario and starting point
Create ten questions with reference answers. Two must be unanswerable and two must require a citation. Score the same model output against explicit criteria.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Define a 0/1 or 0-2 scale for each criterion with examples.
2. Review the outputs manually or write a small deterministic evaluator.
3. Calculate overall scores and scores by error type.
4. Note scoring limits and anything the benchmark does not measure.

## Deliverables
- Ten questions with reference answers.
- Score table, two error examples, and proposed fixes.
- A concise one- to two-page report.

## Acceptance criteria
- Reference answers and scoring rules agree.
- System failures are distinguished from subjective judgments.
- At least one concrete change follows from the evidence.

## Evaluation
Benchmark quality 25, metrics 30, analysis 30, limitations 15 points.

## Submission
Attach the table and report as PDF/Markdown or in a repository.

## Estimated time
4-6 hours.$applied_ai_engineering_2_inst_1$),
  ('applied-ai-engineering', 5, 7, 5, $applied_ai_engineering_2_desc_2$[[AZ]]
Axtarış keyfiyyətini ölçərək RAG prototipində uyğun mənbələrin tapılmasını yaxşılaşdır.

[[EN]]
Improve source retrieval in a RAG prototype by measuring search quality.$applied_ai_engineering_2_desc_2$, $applied_ai_engineering_2_inst_2$[[AZ]]
## Məqsəd
RAG prototipinin düzgün parçanı tapmasını təkmilləşdir; yalnız prompt dəyişməklə retrieval problemini gizlətmə.

## Ssenari və başlanğıc
8 sintetik texniki FAQ və 12 sual hazırla, hər sual üçün uyğun mənbə ID-sini öncədən qeyd et. 3 sual yaxın mənalı yanlış parçalarla çətin olsun.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. İlkin nəticələr üçün recall@3 və doğru mənbə faizini hesabla.
2. Chunk ölçüsü, overlap və ya top-k parametrindən yalnız birini dəyiş.
3. Eyni 12 sualla sistemi yenidən işə sal.
4. Axtarış keyfiyyəti və cavab gecikməsindəki fərqi müqayisə et.

## Təhvil veriləcək
- Səkkiz FAQ və 12 sual üçün etalon mənbə siyahısı.
- Parametr dəyişikliyindən əvvəl/sonra nəticə cədvəli.
- Seçilən parametr və onun üstünlük/çatışmazlıqlarını izah edən README.

## Qəbul meyarları
- Axtarış göstəricisi yaxşılaşıb və ya dəyişməməsinin səbəbi sübutla izah olunub.
- Mənbə ID-si olmayan cavabların yoxlanıla bilmədiyi ayrıca qeyd edilir.
- Gecikmə artımı varsa, keyfiyyət qazancı ilə birlikdə göstərilir.

## Qiymətləndirmə
Etalon və ölçü 30, axtarış sınağı 35, mənbə sübutu 20, izah 15 bal.

## Təqdim etmə
Repo və ya hesabat faylını etalon mənbə cədvəli ilə birlikdə təqdim et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Improve source retrieval in a RAG prototype; do not hide a retrieval problem by changing only the prompt.

## Scenario and starting point
Create eight synthetic technical FAQs and twelve questions, each with a gold source ID. Make three questions difficult by adding near-match distractor passages.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Measure baseline recall@3 and the proportion of correct source IDs.
2. Change only one setting: chunk size, overlap, or top-k.
3. Rerun the exact same twelve questions.
4. Explain changes in retrieval quality and latency.

## Deliverables
- FAQ corpus and gold source list for twelve questions.
- Before/after retrieval results table.
- README with the chosen setting and trade-offs.

## Acceptance criteria
- A retrieval metric improves, or evidence explains why it did not.
- The report notes that answers without source IDs cannot be verified.
- Any major latency increase is stated as a trade-off.

## Evaluation
Gold set and metrics 30, retrieval experiment 35, source evidence 20, explanation 15 points.

## Submission
Submit a repository or report file with the source-results table.

## Estimated time
5-7 hours.$applied_ai_engineering_2_inst_2$),
  ('applied-ai-engineering', 5, 8, 5, $applied_ai_engineering_2_desc_3$[[AZ]]
Prompt injection və həssas məlumat sızması risklərinə qarşı yoxlanıla bilən AI qoruyucuları qur.

[[EN]]
Build testable AI safeguards against prompt injection and sensitive-data disclosure.$applied_ai_engineering_2_desc_3$, $applied_ai_engineering_2_inst_3$[[AZ]]
## Məqsəd
Sənəd sual-cavab prototipinə aydın təhlükəsizlik qaydaları və riskli girişlər üçün təhlükəsiz davranış əlavə et.

## Ssenari və başlanğıc
Sintetik, ictimai qaydalarla işləyən asistent qur. 10 test mesajı yaz: normal sual, “təlimatı unut” cəhdi, gizli prompt istəyi, şəxsi məlumat tələbi və saxta administrator göstərişi.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. Qorunacaq resursları müəyyən et: system prompt, sintetik sənədlər və alətlər.
2. Təhdid modelini və hər risk üçün icazəli cavabı yaz.
3. Giriş/çıxış yoxlaması, imtina və zərərsiz alternativ cavab əlavə et.
4. Adi sualların işlədiyini təsdiqləyən regression testləri qur.

## Təhvil veriləcək
- Qısa təhdid modeli və qoruyucu qaydalar.
- Hücum və normal ssenarilərdən ibarət 10 testin nəticələri.
- Təkrar icra olunan testlər və təhlükəsiz alternativ cavab nümunəsi.

## Qəbul meyarları
- Zərərli giriş sistem qaydalarını dəyişə bilmir.
- İmtina cavabı gizli prompt və qorunan məlumatı açıqlamır.
- Normal suallar əsassız şəkildə bloklanmır.

## Qiymətləndirmə
Təhdid modeli 25, qoruyucular 35, regression testlər 25, istifadəçi izahı 15 bal.

## Təqdim etmə
GitHub repo, README və test nəticələrini təqdim et; real sirr və şəxsi məlumat istifadə etmə.

## Təxmini vaxt
6-8 saat.

[[EN]]
## Objective
Add explicit safety rules and safe behavior for risky inputs to a document Q&A prototype.

## Scenario and starting point
Build an assistant over synthetic public policies. Write ten tests covering normal questions, “ignore instructions” attempts, requests for hidden prompts, personal data, and fake administrator messages.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Identify protected assets: system instructions, synthetic documents, and tools.
2. Write a short threat model and allowed responses.
3. Add input/output checks and define refusal plus harmless fallback behavior.
4. Add regression tests and confirm normal use still works.

## Deliverables
- Brief threat model and guardrail rules.
- Results for ten benign and adversarial cases.
- Repeatable tests with an example safe fallback.

## Acceptance criteria
- Malicious text cannot override system rules.
- Refusals do not reveal protected instructions.
- Benign questions are not blocked without a reason.

## Evaluation
Threat model 25, safeguard implementation 35, regression tests 25, user-facing explanation 15 points.

## Submission
Submit a GitHub repository, README, and test results; never use real secrets.

## Estimated time
6-8 hours.$applied_ai_engineering_2_inst_3$),
  ('applied-ai-engineering', 6, 9, 6, $applied_ai_engineering_2_desc_4$[[AZ]]
Süni sorğu izində token xərci və cavab gecikməsini ölç, sonra optimallaşdırmanı sın.

[[EN]]
Measure token cost and response latency on a synthetic trace, then test an optimization.$applied_ai_engineering_2_desc_4$, $applied_ai_engineering_2_inst_4$[[AZ]]
## Məqsəd
AI funksiyasının sorğu başına xərcini və cavab vaxtını ölçərək hansı optimallaşdırmanın keyfiyyəti qoruduğunu göstər.

## Ssenari və başlanğıc
20 sintetik sorğu üçün giriş/çıxış token uzunluqlarını və nümunə vahid qiymətlərini müəyyən et. Real API açarı lazım deyil; nümunə ölçmə faylı istifadə et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. İlkin versiya üçün token, təxmini xərc və p50/p95 gecikməni hesabla.
2. Promptu qısaltmaq, keş əlavə etmək və ya modeli dəyişməkdən birini seç.
3. Eyni 20 sorğunu dəyişiklikdən əvvəl və sonra ölç.
4. Keyfiyyət göstəricisini və xərc-keyfiyyət güzəştini müqayisə et.

## Təhvil veriləcək
- Ölçmə məlumatı və təkrar işləyən hesablama skripti.
- İlkin və optimallaşdırılmış versiyaların müqayisəsi.
- Seçilən dəyişiklik barədə bir səhifəlik qərar qeydi.

## Qəbul meyarları
- Bütün düsturlar açıqdır; valyuta və token vahidi göstərilib.
- p50/p95 nəticələri orta göstəricidən fərqləndirilib.
- Xərc azalarkən keyfiyyət itkisi varsa, bu gizlədilmir.

## Qiymətləndirmə
Ölçmənin düzgünlüyü 35, ədalətli müqayisə 25, keyfiyyət yoxlaması 25, tövsiyə 15 bal.

## Təqdim etmə
Cədvəl və skripti hesabatla birlikdə repo və ya fayl kimi təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Measure per-request cost and latency for an AI feature, then show which optimization preserves quality.

## Scenario and starting point
Define token lengths and example unit pricing for twenty synthetic requests. A sample measurement file is enough; no live API key is required.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Calculate tokens, cost, and p50/p95 latency for the baseline.
2. Choose one change: shorten the prompt, add caching, or change the model.
3. Measure the same twenty inputs before and after.
4. Record the quality check and cost-quality trade-off.

## Deliverables
- Measurement data and a reproducible calculation script.
- Comparison of baseline and optimized versions.
- One-page recommendation for the product owner.

## Acceptance criteria
- Formulas are transparent and currency/token units are stated.
- p50/p95 are not confused with the average.
- Any quality loss is visible alongside the cost reduction.

## Evaluation
Measurement accuracy 35, fair comparison 25, quality control 25, recommendation 15 points.

## Submission
Provide the table/script and report in a repository or file.

## Estimated time
4-6 hours.$applied_ai_engineering_2_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_applied_ai_engineering_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'applied-ai-engineering batch 2: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_applied_ai_engineering_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'applied-ai-engineering batch 2: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_applied_ai_engineering_2 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'applied-ai-engineering batch 2: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_applied_ai_engineering_2;
END
$curriculum_applied_ai_engineering_2$;

DO $curriculum_applied_ai_engineering_3$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_applied_ai_engineering_3 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_applied_ai_engineering_3 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('applied-ai-engineering', 6, 10, 7, $applied_ai_engineering_3_desc_1$[[AZ]]
AI prototipini başqa mühəndisin işə sala biləcəyi təhlükəsiz və ölçülə bilən handoff paketinə çevir.

[[EN]]
Turn an AI prototype into a safe, measurable handoff another engineer can run.$applied_ai_engineering_3_desc_1$, $applied_ai_engineering_3_inst_1$[[AZ]]
## Məqsəd
RAG və tool-calling prototipini prod-a hazır olduğunu iddia etmədən, növbəti mühəndisə təhvil verilə bilən vəziyyətə gətir.

## Ssenari və başlanğıc
Əvvəlki tapşırıqlardan bir prototip seç və synthetic FAQ, evaluation set, mock tool, guardrail və cost qeydlərini bir repoda birləşdir.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. Arxitektura və məlumat axınının sadə diaqramını çək.
2. Quraşdırma, test və nümunə sorğunu işə salma addımlarını yaz.
3. Mühit dəyişənlərini real açar olmadan nümunələrlə izah et.
4. Məhdudiyyətləri, izləmə siqnallarını və geri qaytarma meyarını qeyd et.

## Təhvil veriləcək
- İşə düşən kod, sintetik məlumat və regression testləri.
- Quraşdırma, arxitektura, qiymətləndirmə və təhlükəsizlik bölmələri olan README.
- Açıq risklər və prioritetləşdirilmiş növbəti üç iş.

## Qəbul meyarları
- Təmiz mühitdə README addımları ilə testlər işləyir.
- Repo-da gizli açar və şəxsi məlumat yoxdur.
- Ölçülər, alternativ cavab və timeout davranışı izah edilib.

## Qiymətləndirmə
Təkrar işə salınma 30, təhlükəsizlik 25, qiymətləndirmə 25, handoff aydınlığı 20 bal.

## Təqdim etmə
GitHub repo linki və qısa handoff videosu və ya hesabat əlavə et.

## Təxmini vaxt
6-8 saat.

[[EN]]
## Objective
Prepare a RAG or tool-calling prototype for handoff without claiming it is production-ready.

## Scenario and starting point
Choose a prototype from earlier tasks and bring its synthetic FAQ, evaluation set, mocked tool, guardrails, and cost notes into one repository.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Draw a small architecture and data-flow diagram.
2. Add setup instructions, test commands, and a sample query.
3. Document environment-variable examples without real secrets.
4. State limitations, monitoring signals, and rollback criteria.

## Deliverables
- Runnable code, synthetic data, and regression tests.
- README covering setup, architecture, evaluation, and safety.
- Open risks and a prioritized list of the next three tasks.

## Acceptance criteria
- A fresh environment can run the tests by following the README.
- No secret keys or personal data are committed.
- Metrics, fallback behavior, and timeout handling are documented.

## Evaluation
Reproducibility 30, safety 25, evaluation 25, handoff clarity 20 points.

## Submission
Submit the GitHub repository and a short handoff video or report.

## Estimated time
6-8 hours.$applied_ai_engineering_3_inst_1$),
  ('applied-ai-engineering', 8, 4, 8, $applied_ai_engineering_3_desc_2$[[AZ]]
Kiçik, istifadəçiyə yönəlmiş AI funksiyasını tələbdən ölçülən nəticəyə qədər tamamla.

[[EN]]
Complete a small user-facing AI feature from requirements through measurable evaluation.$applied_ai_engineering_3_desc_2$, $applied_ai_engineering_3_inst_2$[[AZ]]
## Məqsəd
Tələbə üçün FAQ köməkçisi hazırla: cavablarını synthetic proqram qaydalarından götürsün, mənbə göstərsin və qeyri-müəyyən halda sual versin.

## Ssenari və başlanğıc
8 qayda sənədi və 12 real görünən, lakin synthetic tələbə sualı qur. Login, ödəniş və şəxsi məlumat toplama daxil etmə.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç və daxili Terminal → New Terminal seç. İlk olaraq README və requirements.txt faylını oxu.
- Mövcud Python mühitini istifadə et. Yenisini qurursansa, PowerShell-də: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv və source .venv/bin/activate.
- Asılılıqlar requirements.txt faylındadırsa: python -m pip install -r requirements.txt. Fayl yoxdursa, ilkin test alətləri üçün: python -m pip install pytest pydantic httpx. Yalnız tapşırığın tələb etdiyi model provayderinin SDK-sını ayrıca quraşdır.
- Yoxlama: python -m pytest -q. API varsa, README-dəki modul yoluna uyğun uvicorn <modul>:app --reload əmrindən istifadə et.
- Açarları .env faylında saxla, .env.example-a yalnız boş adları yaz və .env faylını Git-ə əlavə etmə. Model cavablarını qiymətləndirərkən sintetik nümunələr istifadə et.

## Addım-addım icra
1. İstifadəçi axınını və cavab verilməsi icazəli sualları müəyyən et.
2. Sənəd axtarışını, mənbə göstəricisini və cavabdan imtina qaydasını qur.
3. 12 suallıq qiymətləndirmə cədvəli və prompt-injection sınaqları əlavə et.
4. Demo göstər, gecikməni və məlum məhdudiyyətləri hesabatda yaz.

## Təhvil veriləcək
- İşlək demo və ya mock UI, kod və sintetik sənədlər.
- 12 testin nəticələri, mənbə ID-ləri və təhlükəsizlik yoxlamaları.
- Arxitektura, quraşdırma, ölçülər və məhdudiyyətlər olan README.

## Qəbul meyarları
- Ən azı 10 sualda düzgün mənbə göstərilib.
- Mənbəsiz suallara cavab uydurulmur.
- Injection testləri sistem qaydalarını poza bilmir.

## Qiymətləndirmə
İstifadəçi faydası 20, mənbəyə bağlılıq 30, təhlükəsizlik 25, test/handoff 25 bal.

## Təqdim etmə
Repo və demo linkini və ya ekran görüntüləri olan hesabatı təqdim et.

## Təxmini vaxt
8-12 saat.

[[EN]]
## Objective
Build a student FAQ assistant that answers from synthetic program policies, cites sources, and asks when a request is ambiguous.

## Scenario and starting point
Create eight policy documents and twelve realistic but synthetic student questions. Do not add login, payments, or personal-data collection.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and choose Terminal → New Terminal. Read the README and requirements.txt first.
- Reuse the project's Python environment. For a new one, run in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, install with python -m pip install -r requirements.txt. Otherwise, install the base test tools with python -m pip install pytest pydantic httpx. Add only the model provider SDK required by the task.
- Verify with python -m pytest -q. For an API, use uvicorn <module>:app --reload with the module path documented by the project.
- Keep keys in .env, put only empty variable names in .env.example, and never commit .env. Use synthetic examples to evaluate model outputs.

## Step-by-step
1. Map the user flow and define allowed answers.
2. Implement document retrieval, source labels, and abstention behavior.
3. Add a twelve-question evaluation table and prompt-injection tests.
4. Demo the feature and report latency plus known limitations.

## Deliverables
- Working demo or mock UI, code, and synthetic documents.
- Results for twelve tests, source IDs, and safety checks.
- README with architecture, setup, metrics, and limitations.

## Acceptance criteria
- At least ten questions cite the correct supporting source.
- Unsupported questions are not guessed.
- Injection tests do not override system rules.

## Evaluation
User value 20, grounding 30, safety 25, tests and handoff 25 points.

## Submission
Submit the repository and demo link, or a report with screenshots.

## Estimated time
8-12 hours.$applied_ai_engineering_3_inst_2$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_applied_ai_engineering_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 2 THEN RAISE EXCEPTION 'applied-ai-engineering batch 3: expected 2 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_applied_ai_engineering_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'applied-ai-engineering batch 3: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_applied_ai_engineering_3 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 2 THEN RAISE EXCEPTION 'applied-ai-engineering batch 3: expected 2 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_applied_ai_engineering_3;
END
$curriculum_applied_ai_engineering_3$;

DO $curriculum_automation_engineering_1$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_automation_engineering_1 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_automation_engineering_1 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('automation-engineering', 1, 1, 1, $automation_engineering_1_desc_1$[[AZ]]
Əl ilə görülən təcrübə müraciəti prosesini xəritələ və avtomatlaşdırma sərhədlərini müəyyən et.

[[EN]]
Map a manual internship-application process and define what should be automated.$automation_engineering_1_desc_1$, $automation_engineering_1_inst_1$[[AZ]]
## Məqsəd
Müraciətin qəbulu və ilkin yoxlanması prosesini addım, rol, qərar və istisnalarla təsvir et.

## Ssenari və başlanğıc
Tələbə formu göndərir, koordinator məlumatı yoxlayır, natamam müraciət geri qaytarılır, uyğun müraciət rəhbərə ötürülür. Prosesi synthetic nümunə ilə modelləşdir.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. İştirakçıları, trigger-i, input və çıxışları qeyd et.
2. Normal axını və ən azı 5 istisnanı BPMN və ya flowchart-da göstər.
3. Gözləmə nöqtələri və təkrarlanan əl işlərini işarələ.
4. Hansı qərarın insanda qalmalı olduğunu və uğur ölçüsünü yaz.

## Təhvil veriləcək
- Mövcud proses diaqramı və addım cədvəli.
- Avtomatlaşdırıla bilən/insan təsdiqi tələb edən addımların siyahısı.
- Vaxt qənaəti üçün fərziyyəli, hesabı göstərilən ilkin qiymət.

## Qəbul meyarları
- Hər addımın sahibi və növbəti addımı aydındır.
- Exception axını və data sahibinin məsuliyyəti var.
- Avtomatlaşdırma təklifi riskləri və insan nəzarətini nəzərə alır.

## Qiymətləndirmə
Proses əhatəsi 30, istisnalar 25, düzgün avtomatlaşdırma sərhədi 25, təqdimat 20 bal.

## Təqdim etmə
Diaqramı PDF/PNG və ya repo-da Mermaid/BPMN faylı kimi təqdim et.

## Təxmini vaxt
3-5 saat.

[[EN]]
## Objective
Describe an application intake and initial review process with steps, roles, decisions, and exceptions.

## Scenario and starting point
A student submits a form, a coordinator checks it, incomplete applications are returned, and eligible applications go to a reviewer. Model it with synthetic examples.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. List actors, triggers, inputs, and outputs.
2. Diagram the happy path and at least five exceptions in BPMN or a flowchart.
3. Mark wait states and repeated manual work.
4. State which decisions must remain human-approved and how success is measured.

## Deliverables
- Current-state process diagram and step table.
- List of automatable steps versus human approval points.
- Initial, assumption-based estimate of time saved with the calculation shown.

## Acceptance criteria
- Every step has a clear owner and next action.
- Exception paths and data ownership are represented.
- The proposal addresses risk and human oversight.

## Evaluation
Process coverage 30, exceptions 25, automation boundaries 25, presentation 20 points.

## Submission
Submit the diagram as PDF/PNG or Mermaid/BPMN source in a repository.

## Estimated time
3-5 hours.$automation_engineering_1_inst_1$),
  ('automation-engineering', 2, 2, 2, $automation_engineering_1_desc_2$[[AZ]]
Webhook qəbul edib yoxlanılan məlumatı idarə olunan workflow-a ötür.

[[EN]]
Receive a webhook and pass validated data into a controlled workflow.$automation_engineering_1_desc_2$, $automation_engineering_1_inst_2$[[AZ]]
## Məqsəd
Yeni müraciət webhook-unu təhlükəsiz qəbul edən, məlumatı yoxlayan və təkrar event-ləri ayıran workflow prototipi qur.

## Ssenari və başlanğıc
Mock form service-dən JSON event al. Event ID, timestamp, student email və internship slug daxil et; real tələbə məlumatı və production URL istifadə etmə.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Payload sxemini və məcburi sahələri müəyyən et.
2. HMAC signature yoxlamasını və test secret istifadəsini modelləşdir.
3. Event ID ilə idempotency yoxla; invalid input-a 4xx qaytar.
4. Workflow uğuru və downstream timeout üçün cavabları sına.

## Təhvil veriləcək
- Webhook workflow export-u və ya işlək mock service.
- 6 test payload: etibarlı, yanlış imza, təkrar event və malformed body daxil.
- Quraşdırma və secret rotasiyası qeydi.

## Qəbul meyarları
- İmzalanmamış request data əməliyyatı başlatmır.
- Təkrar event ikinci müraciət yaratmır.
- Xəta response-u daxili detal və secret açıqlamır.

## Qiymətləndirmə
Payload validasiyası 25, imza/idempotency 35, error handling 25, təhvil sənədi 15 bal.

## Təqdim etmə
GitHub repo linki və workflow export-u və ya ekran görüntüləri olan hesabatı təqdim et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Build a webhook prototype that safely receives a new application event, validates it, and deduplicates retries.

## Scenario and starting point
Accept JSON from a mocked form service. Include event ID, timestamp, student email, and internship slug; use no real student data or production URL.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Define the payload schema and required fields.
2. Model HMAC signature verification with a test secret.
3. Deduplicate by event ID and return 4xx for invalid input.
4. Test successful workflow execution and a downstream timeout.

## Deliverables
- Webhook workflow export or runnable mock service.
- Six payload tests including valid, bad signature, duplicate, and malformed body.
- Setup and secret-rotation notes.

## Acceptance criteria
- Unsigned requests cannot start data-changing actions.
- A duplicate event does not create a second application.
- Error responses reveal neither internal details nor secrets.

## Evaluation
Payload validation 25, signature/idempotency 35, error handling 25, handoff notes 15 points.

## Submission
Submit a GitHub repository and workflow export, or a report with screenshots.

## Estimated time
5-7 hours.$automation_engineering_1_inst_2$),
  ('automation-engineering', 4, 3, 4, $automation_engineering_1_desc_3$[[AZ]]
Uğursuz addımları idempotent retry, gecikmə və monitorinq ilə bərpa et.

[[EN]]
Recover failed workflow steps with idempotent retries, backoff, and monitoring.$automation_engineering_1_desc_3$, $automation_engineering_1_inst_3$[[AZ]]
## Məqsəd
Müvəqqəti API xətasında workflow-un nəzarətli təkrar cəhd etməsini, amma side effect-i təkrarlamamasını təmin et.

## Ssenari və başlanğıc
Mock servis əvvəlcə 429 və 503, sonra uğur qaytarsın. Hər event üçün sabit idempotency key və maksimum cəhd sayı istifadə et.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Exponential backoff və jitter qaydasını seç.
2. Retry edilə bilən və dərhal dayandırılmalı xətaları ayır.
3. Limit bitəndə dead-letter queue və ya manual review çıxışı yaz.
4. Cəhd sayı, son nəticə və müddət üçün ölçü/log əlavə et.

## Təhvil veriləcək
- Workflow kodu və fault-injection mock-u.
- 5 ssenarinin timeline/result cədvəli.
- Retry və DLQ-dan bərpa addımlarını göstərən runbook.

## Qəbul meyarları
- Eyni event ikinci dəfə biznes əməliyyatını təkrarlamır.
- Retry sayı və gecikməsi konfiqurasiya ilə məhdudlaşır.
- Son uğursuzluq görünür və itkisiz araşdırıla bilir.

## Qiymətləndirmə
Retry siyasəti 30, idempotency 30, observability 25, runbook 15 bal.

## Təqdim etmə
Repo, test nəticəsi və runbook-u təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Retry transient API failures in a controlled way without repeating side effects.

## Scenario and starting point
A mock service returns 429 and 503 before succeeding. Use a stable idempotency key per event and a bounded retry count.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Choose an exponential-backoff and jitter policy.
2. Separate retryable errors from errors that should stop immediately.
3. Route exhausted events to a dead-letter queue or manual review.
4. Record attempts, final outcome, and elapsed time.

## Deliverables
- Workflow code and a fault-injection mock.
- Timeline/result table for five scenarios.
- Runbook for retries and DLQ recovery.

## Acceptance criteria
- Replaying an event does not repeat the business action.
- Retry count and delay are bounded by configuration.
- Final failures are visible and can be investigated without data loss.

## Evaluation
Retry policy 30, idempotency 30, observability 25, runbook 15 points.

## Submission
Submit the repository, test results, and runbook.

## Estimated time
4-6 hours.$automation_engineering_1_inst_3$),
  ('automation-engineering', 4, 5, 3, $automation_engineering_1_desc_4$[[AZ]]
Müxtəlif form girişlərini daxili vahid JSON modelinə çevir və keyfiyyət səhvlərini üzə çıxar.

[[EN]]
Transform varied form inputs into a consistent JSON model and surface data-quality issues.$automation_engineering_1_desc_4$, $automation_engineering_1_inst_4$[[AZ]]
## Məqsəd
Tarix, telefon, universitet və boş dəyər formatlarını təmizləyən, nəticəni sabit schema ilə verən transform addımı qur.

## Ssenari və başlanğıc
10 synthetic form sətri yarat: fərqli tarix formatı, artıq boşluq, böyük/kiçik hərf, optional sahə və yanlış e-poçt daxil et.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Source-to-target mapping cədvəli və canonical formatları yaz.
2. Trim, case normalization və timezone qaydalarını tətbiq et.
3. Yanlış dəyərləri silently dəyişmək əvəzinə validation result-a yaz.
4. Giriş/çıxış nümunələri ilə transform nəticəsini təkrarlana bilən testlərlə yoxla.

## Təhvil veriləcək
- Transform workflow/function və field mapping.
- 10 giriş/çıxış nümunəsi və rədd edilən sətirlər üçün izah.
- Məlumat məxfiliyi və audit qeydlərinin saxlanması barədə qeyd.

## Qəbul meyarları
- Eyni dəyər bütün form-lardan eyni canonical nəticəyə çevrilir.
- Uğursuz sətrə səbəb kodu əlavə olunur, başqa sətirlər itmir.
- Şəxsi məlumat log və sample fayllarda maskalanır.

## Qiymətləndirmə
Mapping 25, normalization 30, invalid-row handling 25, test/audit 20 bal.

## Təqdim etmə
Workflow export-u və ya repo, üstəlik nəticə cədvəlini təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Build a transformation step that normalizes dates, phone numbers, universities, and empty values into one stable JSON schema.

## Scenario and starting point
Create ten synthetic form rows with varied date formats, whitespace, letter case, optional fields, and an invalid email.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Define a source-to-target mapping and canonical formats.
2. Apply trimming, case normalization, and timezone rules.
3. Put invalid values in a validation result instead of silently altering them.
4. Test the transform reproducibly with input/output fixtures.

## Deliverables
- Transformation workflow/function and field mapping.
- Ten input/output examples with rejected-row explanations.
- Notes on privacy and audit retention.

## Acceptance criteria
- Equivalent values from different forms produce the same canonical result.
- Rejected rows carry a reason code and valid rows are not lost.
- Personal data is masked in logs and sample files.

## Evaluation
Mapping 25, normalization 30, invalid-row handling 25, tests/audit 20 points.

## Submission
Submit a workflow export or repository plus the results table.

## Estimated time
4-6 hours.$automation_engineering_1_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_automation_engineering_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'automation-engineering batch 1: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_automation_engineering_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'automation-engineering batch 1: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_automation_engineering_1 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'automation-engineering batch 1: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_automation_engineering_1;
END
$curriculum_automation_engineering_1$;

DO $curriculum_automation_engineering_2$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_automation_engineering_2 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_automation_engineering_2 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('automation-engineering', 4, 6, 4, $automation_engineering_2_desc_1$[[AZ]]
Xarici API ilə limit, timeout və auth davranışı nəzərə alınmış inteqrasiya workflow-u qur.

[[EN]]
Integrate an external API while accounting for rate limits, timeouts, and authentication.$automation_engineering_2_desc_1$, $automation_engineering_2_inst_1$[[AZ]]
## Məqsəd
Mock internship catalog API-dən məlumat alıb workflow-un növbəti addımına ötür; credentials-ı payload-dan ayrı saxla.

## Ssenari və başlanğıc
API 200, 401, 429 və timeout qaytara bilər. Səhifələnmiş nəticə və updated_at dəyəri ilə dəyişiklikləri ayır.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Credential storage və least-privilege scope təsvir et.
2. Request timeout, pagination və rate-limit başlıqlarını idarə et.
3. 401-də retry etmə; 429 üçün Retry-After-ı nəzərə al.
4. Məlumatı validate et və duplicate update-i idempotent et.

## Təhvil veriləcək
- Workflow export-u və ya service adapter-i.
- 4 response code üzrə test və pagination nümunəsi.
- Credential rotasiyası və incident zamanı söndürmə addımları.

## Qəbul meyarları
- API key log, URL və git diff-də görünmür.
- 401 dərhal aydın xətaya çevrilir, 429 nəzakətlə gecikdirilir.
- Pagination zamanı heç bir record buraxılmır və duplicate yaranmır.

## Qiymətləndirmə
Auth təhlükəsizliyi 30, rate-limit/timeout 30, data integrity 25, sənədləşmə 15 bal.

## Təqdim etmə
GitHub repo və integration test cədvəlini təqdim et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Fetch data from a mocked internship-catalog API and pass it downstream while keeping credentials separate from payloads.

## Scenario and starting point
The API may return 200, 401, 429, or a timeout. Results are paginated and include an updated_at value for change detection.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Describe credential storage and least-privilege scope.
2. Handle request timeouts, pagination, and rate-limit headers.
3. Do not retry 401; respect Retry-After for 429.
4. Validate data and make duplicate updates idempotent.

## Deliverables
- Workflow export or service adapter.
- Tests for four response conditions and a pagination example.
- Credential-rotation and incident-disable steps.

## Acceptance criteria
- API keys do not appear in logs, URLs, or Git diffs.
- 401 fails clearly; 429 is delayed according to the server guidance.
- Pagination loses no records and creates no duplicates.

## Evaluation
Auth safety 30, rate limits/timeouts 30, data integrity 25, documentation 15 points.

## Submission
Submit a GitHub repository and integration-test table.

## Estimated time
5-7 hours.$automation_engineering_2_inst_1$),
  ('automation-engineering', 5, 7, 5, $automation_engineering_2_desc_2$[[AZ]]
Vaxt zonası, duplicate run və missed execution halları olan etibarlı schedule workflow qur.

[[EN]]
Build a reliable scheduled workflow that handles time zones, duplicate runs, and missed executions.$automation_engineering_2_desc_2$, $automation_engineering_2_inst_2$[[AZ]]
## Məqsəd
Hər həftə aktiv təcrübəçilərə tapşırıq xatırlatması hazırlayan, təkrar e-poçt göndərməyən schedule qur.

## Ssenari və başlanğıc
Mock recipient list-də aktiv və tamamlamış internlər olsun. Deadline Baku vaxtı ilə saxlanır; schedule UTC-də işləyir.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Schedule vaxtı və timezone conversion qaydasını yaz.
2. Idempotency key-ni user+task+deadline ilə qur.
3. Gecikmiş icranı sonradan bərpa etməyin lazım olub-olmadığını müəyyən et.
4. Dry-run və sınaq göndərişi rejimi əlavə et; aktiv olmayan şəxsləri siyahıdan çıxar.

## Təhvil veriləcək
- Schedule workflow və mock recipient dataset.
- Timezone keçidi, duplicate run və delayed job testləri.
- Runbook: manual run, pause, reschedule və audit.

## Qəbul meyarları
- Eyni deadline üçün user-ə bir xatırlatma göndərilir.
- Gün dəyişməsində Baku vaxtı qorunur.
- Tamamlamış və ya opt-out etmiş internlər alınan siyahıya düşmür.

## Qiymətləndirmə
Schedule və timezone 30, idempotency 25, audience filter 25, əməliyyat runbook-u 20 bal.

## Təqdim etmə
Workflow export-u/repo və test cədvəlini göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Schedule weekly task reminders for active interns without sending duplicate emails.

## Scenario and starting point
The mocked recipient list includes active and completed interns. Deadlines use Baku time while the scheduler runs in UTC.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Define the schedule and timezone-conversion rule.
2. Build an idempotency key from user, task, and deadline.
3. Decide how to recover a missed execution.
4. Add dry-run and mock-send modes; exclude inactive users.

## Deliverables
- Scheduled workflow and mock recipient dataset.
- Tests for timezone transitions, duplicate runs, and delayed jobs.
- Runbook for manual runs, pause, rescheduling, and audit.

## Acceptance criteria
- A user receives at most one reminder per deadline.
- Baku-local time is preserved across date changes.
- Completed or opted-out interns are excluded.

## Evaluation
Schedule/time zones 30, idempotency 25, audience filtering 25, operations runbook 20 points.

## Submission
Submit a workflow export/repository and test table.

## Estimated time
4-6 hours.$automation_engineering_2_inst_2$),
  ('automation-engineering', 5, 8, 5, $automation_engineering_2_desc_3$[[AZ]]
Bildiriş seçimlərini, template-ləri və uğursuz göndərişləri idarə edən notification flow qur.

[[EN]]
Build a notification flow with preference checks, templates, and delivery-failure handling.$automation_engineering_2_desc_3$, $automation_engineering_2_inst_3$[[AZ]]
## Məqsəd
Yeni tapşırıq və status yeniliyi üçün e-poçt hazırlayan, istifadəçinin seçimlərinə hörmət edən workflow modelləşdir.

## Ssenari və başlanğıc
Synthetic user preference: task announcements, status updates, unsubscribe. E-poçtu real göndərmə; mock provider nəticəsindən istifadə et.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Preference gate-i template-dən əvvəl yoxla.
2. AZ/EN template-lərdə ad, task adı və təhlükəsiz link yerini göstər.
3. Invalid email, provider 4xx/5xx və duplicate event ssenarilərini idarə et.
4. Göndərilmə nəticəsini PII-siz audit event-də qeyd et.

## Təhvil veriləcək
- Preference-aware flow və iki dilli template.
- Opt-out, success, retry edilə bilən və permanent error testləri.
- Göndəriş logunda hansı sahələrin saxlanmadığına dair qeyd.

## Qəbul meyarları
- Opt-out kateqoriyasına məktub heç vaxt provider-ə çatmır.
- Retry yalnız müvəqqəti xətada, məhdud sayda olur.
- Link və locale user record ilə uyğundur.

## Qiymətləndirmə
Preference gate 30, template/i18n 25, delivery error 25, audit/privacy 20 bal.

## Təqdim etmə
GitHub repo, template preview və test nəticələrini təqdim et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Model an email workflow for new tasks and status changes that respects user preferences.

## Scenario and starting point
Use synthetic preferences for task announcements, status updates, and unsubscribe. Do not send real email; use a mock provider.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Check the preference gate before rendering a template.
2. Create AZ/EN templates with placeholders for name, task, and safe link.
3. Handle invalid email, provider 4xx/5xx, and duplicate events.
4. Record delivery outcome as a PII-minimized audit event.

## Deliverables
- Preference-aware workflow and bilingual templates.
- Tests for opt-out, success, retryable, and permanent errors.
- Note describing which fields are excluded from delivery logs.

## Acceptance criteria
- An opted-out category never reaches the provider.
- Only transient failures are retried, with a bounded count.
- Link and locale match the user record.

## Evaluation
Preference gate 30, templates/i18n 25, delivery errors 25, audit/privacy 20 points.

## Submission
Submit a GitHub repository, template preview, and test results.

## Estimated time
5-7 hours.$automation_engineering_2_inst_3$),
  ('automation-engineering', 6, 4, 6, $automation_engineering_2_desc_4$[[AZ]]
Avtomatlaşdırma üçün biznes axınını başdan sona qur, risk və human-in-the-loop nöqtələrini göstər.

[[EN]]
Build an end-to-end business workflow and identify risk and human-approval points.$automation_engineering_2_desc_4$, $automation_engineering_2_inst_4$[[AZ]]
## Məqsəd
Təcrübə proqramına yeni müraciəti alıb yoxlayan, koordinatora qərar üçün yönləndirən və nəticəni tələbəyə bildirən case study hazırla.

## Ssenari və başlanğıc
Əvvəlki webhook, validation və notification nümunələrindən istifadə et. Qəbul/rədd qərarını workflow özü verməsin; bunu admin təsdiqləsin.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Trigger-ləri, data müqavilələrini, workflow vəziyyətlərini və məsul şəxsləri göstər.
2. Natamam məlumat, təkrar event və provider timeout üçün ayrıca budaqlar əlavə et.
3. Admin təsdiqi, audit izi və razılıq yoxlamasını tətbiq et.
4. Beş end-to-end test ssenarisi icra et və gözləmə müddətini ölç.

## Təhvil veriləcək
- Arxitektura diaqramı və state transition cədvəli.
- Mock workflow, 5 end-to-end nəticə və audit nümunəsi.
- Risk, retry, manual override və rollback runbook-u.

## Qəbul meyarları
- Admin təsdiqi olmadan status dəyişmir.
- Event təkrarı duplicate qərar və ya e-poçt yaratmır.
- Hər müraciət vəziyyətinin sahibi və növbəti addımı görünür.

## Qiymətləndirmə
Axın bütövlüyü 25, təhlükəsiz təsdiq 30, exception recovery 25, case study 20 bal.

## Təqdim etmə
Repo/export, diaqram və qısa nümayiş və ya hesabat təqdim et.

## Təxmini vaxt
8-10 saat.

[[EN]]
## Objective
Create a case study that receives and validates an internship application, routes it to a coordinator, and notifies the student of the decision.

## Scenario and starting point
Reuse the webhook, validation, and notification patterns. A workflow must not decide acceptance/rejection automatically; an admin must approve.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Diagram triggers, data contracts, workflow states, and owners.
2. Add branches for incomplete data, duplicate events, and provider timeouts.
3. Enforce admin approval, audit trail, and consent checks.
4. Run five end-to-end test cases and measure waiting time.

## Deliverables
- Architecture diagram and state-transition table.
- Mock workflow, five end-to-end results, and audit example.
- Runbook for risks, retries, manual override, and rollback.

## Acceptance criteria
- Status cannot change without admin approval.
- Replayed events create no duplicate decision or email.
- Every application state has a visible owner and next action.

## Evaluation
Flow integrity 25, safe approval 30, exception recovery 25, case study 20 points.

## Submission
Submit a repository/export, diagram, and short demo or report.

## Estimated time
8-10 hours.$automation_engineering_2_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_automation_engineering_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'automation-engineering batch 2: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_automation_engineering_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'automation-engineering batch 2: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_automation_engineering_2 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'automation-engineering batch 2: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_automation_engineering_2;
END
$curriculum_automation_engineering_2$;

DO $curriculum_automation_engineering_3$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_automation_engineering_3 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_automation_engineering_3 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('automation-engineering', 6, 9, 6, $automation_engineering_3_desc_1$[[AZ]]
Workflow-lar üçün əməliyyat KPI-ları müəyyən et və alert hədlərini əsaslandır.

[[EN]]
Define operational KPIs for workflows and justify alert thresholds.$automation_engineering_3_desc_1$, $automation_engineering_3_inst_1$[[AZ]]
## Məqsəd
Workflow-un işləkliyini və biznes təsirini ayıran, qərar verməyə yararlı dashboard metric-ləri müəyyən et.

## Ssenari və başlanğıc
7 günlük synthetic execution log-u hazırla: success/failure, retry count, queue wait, duration və notification result daxil olsun.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Throughput, success rate, p95 latency, retry və DLQ ölçülərini hesabla.
2. Alert həddini baseline və biznes SLA-sına əsaslandır.
3. Yanlış alert yarada biləcək siqnalları qiymətləndir.
4. Təkmilləşdirmə təklif et və dashboard-da nümunə göstər.

## Təhvil veriləcək
- Məlumat dəsti, metric düsturları və dashboard şəkli/kodu.
- Alert qaydaları və üç nümunə siqnal.
- Hər KPI-nın əhəmiyyətini izah edən bir səhifəlik qeyd.

## Qəbul meyarları
- Metric üçün denominator və vaxt aralığı açıq göstərilib.
- Retry cəhdləri success rate-i süni artırmır.
- Hər alert üçün görüləcək addım və məsul şəxs müəyyən edilib.

## Qiymətləndirmə
KPI seçimi 30, hesablamanın düzgünlüyü 25, alert dizaynı 25, izah 20 bal.

## Təqdim etmə
Dashboard demo və metric izahını repo və ya hesabatla göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Define actionable dashboard metrics that distinguish workflow reliability from business impact.

## Scenario and starting point
Create a seven-day synthetic execution log with success/failure, retry count, queue wait, duration, and notification outcome.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Calculate throughput, success rate, p95 latency, retries, and DLQ volume.
2. Justify alert thresholds from a baseline and business SLA.
3. Estimate which signals could create false alerts.
4. Recommend one change and show it on a dashboard.

## Deliverables
- Dataset, metric formulas, and dashboard screenshot/code.
- Alert rules with three example signals.
- One-page explanation of why each KPI matters.

## Acceptance criteria
- Metric denominator and time window are explicit.
- Retries do not artificially inflate the success rate.
- Each alert has an action and an owner.

## Evaluation
KPI selection 30, calculation accuracy 25, alert design 25, explanation 20 points.

## Submission
Submit a dashboard demo and metric explanation in a repository or report.

## Estimated time
4-6 hours.$automation_engineering_3_inst_1$),
  ('automation-engineering', 6, 10, 6, $automation_engineering_3_desc_2$[[AZ]]
Workflow-u komanda üçün təhvil ver: quraşdırma, credential, monitorinq və bərpa addımlarını yaz.

[[EN]]
Hand off a workflow with setup, credential, monitoring, and recovery instructions.$automation_engineering_3_desc_2$, $automation_engineering_3_inst_2$[[AZ]]
## Məqsəd
Başqa mühəndisin workflow-u təhlükəsiz quraşdırıb işlədə, xətanı araşdıra və lazım olduqda dayandıra bilməsini təmin et.

## Ssenari və başlanğıc
Əvvəlki tapşırıqlardan birini seç. Dev/test mühiti, mock credential və synthetic payload istifadə et; production account-a dəyişiklik etmə.

## Alətlər və VS Code/terminal
- Workflow tapşırıqları üçün n8n editorundan, kod və JSON faylları üçün VS Code-dan istifadə et. Əvvəl repo-da README, package.json, requirements.txt və docker-compose.yml olub-olmadığını yoxla.
- Repo-da docker-compose.yml varsa, lokal mühiti başladmaq üçün docker compose up -d; vəziyyət üçün docker compose ps; dayandırmaq üçün docker compose down işlət. Compose faylı yoxdursa, bu əmrləri çalışdırma; tapşırıqda seçilən hosted n8n və ya mock mühitdən istifadə et.
- Python helper lazımdırsa: py -m venv .venv; PowerShell-də .\.venv\Scripts\Activate.ps1; sonra requirements.txt varsa python -m pip install -r requirements.txt.
- Webhook-u yalnız lokal test URL-i və dummy payload ilə yoxla. Credential-ları workflow export-a yazma; n8n credential store və ya .env.example-da boş dəyişən adlarından istifadə et.

## Addım-addım icra
1. Trigger, node/service dependencies və data flow diaqramı əlavə et.
2. Credential yaratma/rotasiya addımını secret göstərmədən yaz.
3. Retry, DLQ, alert və replay prosedurunu runbook-da təsvir et.
4. Yeni mühitdə install, dry-run, test və rollback-i yoxla.

## Təhvil veriləcək
- Versioned workflow export-u və dependency siyahısı.
- Setup README, operator runbook və sample test payload.
- Known limits, ownership və növbəti 3 yaxşılaşdırma.

## Qəbul meyarları
- Başqa mühəndis README ilə dry-run-u müstəqil işlədə bilir.
- Heç bir secret export, log və ya repository-də yoxdur.
- Uğursuz icra audit olunur və məlumat itkisi olmadan araşdırılır.

## Qiymətləndirmə
Təkrarlana bilən setup 25, secret təhlükəsizliyi 25, əməliyyat runbook-u 30, risk siyahısı 20 bal.

## Təqdim etmə
GitHub repo/export və qısa handoff hesabatını təqdim et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Enable another engineer to install, operate, investigate, and safely stop a workflow.

## Scenario and starting point
Choose a workflow from an earlier task. Use a dev/test environment, mock credentials, and synthetic payloads; do not change a production account.

## Tools, VS Code, and terminal
- Use the n8n editor for workflow tasks and VS Code for code/JSON files. First check the README, package.json, requirements.txt, and whether docker-compose.yml exists.
- If the repository has docker-compose.yml, start the local environment with docker compose up -d, inspect it with docker compose ps, and stop it with docker compose down. Do not run these commands without a Compose file; use the hosted n8n or mock environment selected for the task.
- If a Python helper is required: py -m venv .venv; in PowerShell run .\.venv\Scripts\Activate.ps1; then, if requirements.txt exists, run python -m pip install -r requirements.txt.
- Test webhooks only with a local test URL and dummy payload. Do not put credentials in workflow exports; use the n8n credential store or empty variable names in .env.example.

## Step-by-step
1. Add a trigger, dependency, and data-flow diagram.
2. Document credential creation/rotation without exposing a secret.
3. Describe retries, DLQ, alerts, and replay in an operator runbook.
4. Verify install, dry-run, tests, and rollback in a fresh environment.

## Deliverables
- Versioned workflow export and dependency list.
- Setup README, operator runbook, and sample test payload.
- Known limits, ownership, and the next three improvements.

## Acceptance criteria
- Another engineer can run a dry-run independently from the README.
- No secret appears in exports, logs, or the repository.
- Failed executions are auditable and recoverable without data loss.

## Evaluation
Reproducible setup 25, secret safety 25, operations runbook 30, risk list 20 points.

## Submission
Submit a GitHub repository/export and a short handoff report.

## Estimated time
5-7 hours.$automation_engineering_3_inst_2$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_automation_engineering_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 2 THEN RAISE EXCEPTION 'automation-engineering batch 3: expected 2 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_automation_engineering_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'automation-engineering batch 3: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_automation_engineering_3 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 2 THEN RAISE EXCEPTION 'automation-engineering batch 3: expected 2 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_automation_engineering_3;
END
$curriculum_automation_engineering_3$;

DO $curriculum_backend_engineering_1$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_backend_engineering_1 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_backend_engineering_1 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('backend-engineering', 1, 1, 1, $backend_engineering_1_desc_1$[[AZ]]
Tələbə layihələri üçün resurs yönümlü REST API dizayn et və müqaviləsini nümunələrlə sənədləşdir.

[[EN]]
Design a resource-oriented REST API for student projects and document its contract with examples.$backend_engineering_1_desc_1$, $backend_engineering_1_inst_1$[[AZ]]
## Məqsəd
Layihə və tapşırıq resursları üçün aydın, genişlənə bilən REST API müqaviləsi hazırla.

## Ssenari və başlanğıc
Layihə yaratmaq, siyahılamaq, detalı göstərmək və yeniləmək üçün endpoint-lər müəyyən et. 404, 409 və 422 kimi real xəta halları daxil et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. Resursları, HTTP metodlarını və URL-ləri seç.
2. Request/response JSON nümunələrini və sahə validasiyasını yaz.
3. Status kodları, pagination və versiyalama qaydasını müəyyən et.
4. OpenAPI sənədini yaz və 5 nümunə sorğunu yoxla.

## Təhvil veriləcək
- OpenAPI 3.x spesifikasiyası və işlək nümunələr.
- Endpoint, auth ehtiyacı və xəta kodlarını göstərən cədvəl.
- Seçimləri izah edən qısa README.

## Qəbul meyarları
- Eyni əməliyyat həmişə eyni response shape qaytarır.
- Validasiya və not-found halları fərqləndirilir.
- Endpoint adları resurs əsaslıdır; biznes əməliyyatları ayrıca izah olunur.

## Qiymətləndirmə
Resurs modeli 30, müqavilə və xətalar 30, OpenAPI düzgünlüyü 25, README 15 bal.

## Təqdim etmə
GitHub repo linki və OpenAPI faylını əlavə et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Define a clear, extensible REST API contract for project and task resources.

## Scenario and starting point
Specify endpoints to create, list, retrieve, and update projects. Include realistic errors such as 404, 409, and 422.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Choose resources, HTTP methods, and URL patterns.
2. Write request/response JSON examples and field validation rules.
3. Define status codes, pagination, and versioning.
4. Produce an OpenAPI document and verify five example requests.

## Deliverables
- OpenAPI 3.x specification with usable examples.
- Table of endpoints, auth needs, and error codes.
- Short README explaining key choices.

## Acceptance criteria
- Each operation returns a consistent response shape.
- Validation failures are distinct from not-found responses.
- URLs are resource-oriented; business actions are documented separately.

## Evaluation
Resource model 30, contract and errors 30, OpenAPI accuracy 25, README 15 points.

## Submission
Submit a GitHub repository link and the OpenAPI file.

## Estimated time
4-6 hours.$backend_engineering_1_inst_1$),
  ('backend-engineering', 2, 2, 2, $backend_engineering_1_desc_2$[[AZ]]
Layihə, üzv və tapşırıq məlumatları üçün normallaşdırılmış PostgreSQL modeli qur.

[[EN]]
Create a normalized PostgreSQL model for projects, members, and tasks.$backend_engineering_1_desc_2$, $backend_engineering_1_inst_2$[[AZ]]
## Məqsəd
Layihə, üzv və tapşırıq cədvəllərini əlaqələndirən, referensial bütövlüyü qoruyan məlumat modeli hazırla.

## Ssenari və başlanğıc
Bir layihədə çox tapşırıq, istifadəçi ilə layihə arasında çoxdan-çoxa üzvlük və tapşırıq sahibi ola bilər. UUID və zaman sahələrini nəzərə al.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. ER diaqramı və sütun tiplərini müəyyən et.
2. Primary/foreign key, unique və check constraint-lər əlavə et.
3. İstifadə ediləcək list/detail sorğuları üçün indeks seç.
4. Migration və kiçik seed məlumatı ilə modeli yoxla.

## Təhvil veriləcək
- ER diaqramı, SQL migration və sintetik seed.
- Constraint və indeks seçimlərini izah edən qeyd.
- 3 yoxlama sorğusunun nümunəsi.

## Qəbul meyarları
- Eyni istifadəçi eyni layihəyə iki dəfə üzv ola bilmir.
- Layihə silinməsi əlaqəli tapşırıqlar üçün seçilmiş davranışı izləyir.
- Sorğular lazımsız təkrarlanan məlumat saxlamır.

## Qiymətləndirmə
Normallaşdırma 30, referensial bütövlük 30, indeks əsaslandırması 20, migration/seed 20 bal.

## Təqdim etmə
GitHub repo linki, migration və diaqramı əlavə et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Model projects, members, and tasks while preserving referential integrity.

## Scenario and starting point
A project can have many tasks, users can join many projects, and tasks may have an owner. Account for UUIDs and timestamps.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Define the ER diagram and column types.
2. Add primary/foreign keys, unique constraints, and checks.
3. Choose indexes for the expected list/detail queries.
4. Verify the model with a migration and small seed dataset.

## Deliverables
- ER diagram, SQL migration, and synthetic seed data.
- Notes explaining constraint and index choices.
- Examples of three verification queries.

## Acceptance criteria
- A user cannot join the same project twice.
- Project deletion follows an explicit policy for dependent tasks.
- The model avoids storing unnecessary duplicate data.

## Evaluation
Normalization 30, referential integrity 30, index rationale 20, migration/seed 20 points.

## Submission
Submit a GitHub repository link with the migration and diagram.

## Estimated time
5-7 hours.$backend_engineering_1_inst_2$),
  ('backend-engineering', 4, 3, 3, $backend_engineering_1_desc_3$[[AZ]]
Giriş və qeydiyyat endpoint-lərini input validasiyası və təhlükəsiz xəta cavabları ilə qur.

[[EN]]
Build sign-up and sign-in endpoints with input validation and safe error responses.$backend_engineering_1_desc_3$, $backend_engineering_1_inst_3$[[AZ]]
## Məqsəd
Qeydiyyat və giriş axınında məlumatı yoxla, parolun saxlanmasını təhlükəsiz et və artıq hesab məlumatı açıqlama.

## Ssenari və başlanğıc
Mock auth servisi və ya lokal test bazası işlət. E-poçt, parol və ad sahələri üçün tələb olunan qaydaları təyin et; real istifadəçi məlumatı istifadə etmə.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. Request schema yaz və boş/yanlış sahələri rədd et.
2. Parolu yalnız güclü hash ilə saxla; plaintext loglama.
3. Login xətalarında hesabın olub-olmadığını açıqlamayan cavab qaytar.
4. Uğur, duplicate email, zəif parol və malformed JSON üçün test yaz.

## Təhvil veriləcək
- Endpoint kodu və validasiya sxemi.
- Ən azı 6 test, o cümlədən mənfi ssenarilər.
- Auth təhlükəsizliyi və lokal işə salma README-si.

## Qəbul meyarları
- Yanlış input database-ə çatmır.
- Response parol/hash və daxili stack trace açıqlamır.
- Eyni e-poçt üçün yarış halı duplicate hesab yaratmır.

## Qiymətləndirmə
Validasiya 25, parol və xəta təhlükəsizliyi 35, test əhatəsi 25, sənədləşmə 15 bal.

## Təqdim etmə
GitHub repo və test nəticələrini təqdim et; real sirr və parol commit etmə.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Validate registration and sign-in input, store passwords safely, and avoid leaking account details.

## Scenario and starting point
Use a mocked auth service or local test database. Define rules for email, password, and name; do not use real user data.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Add a request schema and reject missing or invalid fields.
2. Store passwords only with a strong hash; never log plaintext.
3. Avoid revealing whether an account exists in login errors.
4. Test success, duplicate email, weak password, and malformed JSON.

## Deliverables
- Endpoint code and validation schema.
- At least six tests, including negative cases.
- README covering auth safety and local setup.

## Acceptance criteria
- Invalid input never reaches the database.
- Responses expose no password/hash or internal stack trace.
- Concurrent registration cannot create duplicate accounts.

## Evaluation
Validation 25, password/error safety 35, test coverage 25, documentation 15 points.

## Submission
Submit a GitHub repository and test results; never commit real secrets or passwords.

## Estimated time
5-7 hours.$backend_engineering_1_inst_3$),
  ('backend-engineering', 4, 5, 4, $backend_engineering_1_desc_4$[[AZ]]
Böyük layihə siyahısını sabit pagination və yoxlanıla bilən filter-lərlə təqdim et.

[[EN]]
Serve a large project list with stable pagination and validated filters.$backend_engineering_1_desc_4$, $backend_engineering_1_inst_4$[[AZ]]
## Məqsəd
Layihə endpoint-inə axtarış, status filter-i və səhifələmə əlavə et; nəticə sırası səhifələr arasında dəyişməsin.

## Ssenari və başlanğıc
Ən azı 100 sintetik layihə seed et. Sıralama üçün yaradılma vaxtı ilə unikal ID-ni tie-breaker kimi istifadə et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. Limit/offset və ya cursor pagination-dan birini seç, səbəbini yaz.
2. Status və text filter parametrlərini validate et.
3. Total count və next cursor/has_more davranışını müəyyən et.
4. Duplicate, buraxılmış sətir, limit sərhədi və boş nəticə testləri yaz.

## Təhvil veriləcək
- Endpoint kodu, query nümunələri və pagination response modeli.
- 100+ row test seed-i və edge-case testləri.
- Query plan və indeks seçimi barədə qısa qeyd.

## Qəbul meyarları
- Sıralama deterministikdir və səhifələr sətir təkrarlamır.
- Həddən böyük limit serverdə təhlükəsiz həddə endirilir və ya rədd olunur.
- Yanlış filter qiyməti aydın 4xx cavabı verir.

## Qiymətləndirmə
Pagination sabitliyi 30, filter validasiyası 25, testlər 25, query səmərəliliyi 20 bal.

## Təqdim etmə
GitHub repo, API nümunələri və test nəticələrini göndər.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Add search, status filtering, and pagination to a project endpoint without unstable ordering between pages.

## Scenario and starting point
Seed at least 100 synthetic projects. Use creation time and a unique ID as a deterministic tie-breaker.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Choose limit/offset or cursor pagination and explain why.
2. Validate status and text-search parameters.
3. Define total count and next-cursor/has-more behavior.
4. Test duplicates, skipped rows, limit boundaries, and empty results.

## Deliverables
- Endpoint code, query examples, and pagination response model.
- 100+ row test seed and edge-case tests.
- Short note on query plan and index choice.

## Acceptance criteria
- Ordering is deterministic and pages do not repeat rows.
- Excessive limits are capped or rejected safely.
- Invalid filters return a clear 4xx response.

## Evaluation
Pagination stability 30, filter validation 25, tests 25, query efficiency 20 points.

## Submission
Submit a GitHub repository, API examples, and test results.

## Estimated time
5-7 hours.$backend_engineering_1_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_backend_engineering_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'backend-engineering batch 1: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_backend_engineering_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'backend-engineering batch 1: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_backend_engineering_1 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'backend-engineering batch 1: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_backend_engineering_1;
END
$curriculum_backend_engineering_1$;

DO $curriculum_backend_engineering_2$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_backend_engineering_2 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_backend_engineering_2 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('backend-engineering', 4, 6, 4, $backend_engineering_2_desc_1$[[AZ]]
Bir neçə database yazısını vahid tranzaksiyada icra et və qismən uğursuzluğu önlə.

[[EN]]
Run related database writes in one transaction and prevent partial success.$backend_engineering_2_desc_1$, $backend_engineering_2_inst_1$[[AZ]]
## Məqsəd
Layihə yaratma və ilkin üzvləri əlavə etmə əməliyyatını atomik et: istənilən addım uğursuz olsa, heç bir natamam məlumat qalmasın.

## Ssenari və başlanğıc
Projects və project_members cədvəllərini istifadə et. Duplicate üzv, çatışmayan user və constraint xətası yarada bilən sintetik input hazırla.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. Tranzaksiya sərhədində hansı əməliyyatların olması lazım olduğunu yaz.
2. API transaction və ya database function ilə tətbiq et.
3. Uğursuz addımdan sonra rollback olduğunu yoxla.
4. Eyni sorğunun təkrar gəlməsi üçün idempotency strategiyası əlavə et.

## Təhvil veriləcək
- Migration və atomik create-service kodu.
- Success, rollback və retry üçün testlər.
- Tranzaksiya və idempotency qərarını izah edən qeyd.

## Qəbul meyarları
- Uğursuz üzv əlavə etmə layihəni yarımçıq saxlamır.
- Təkrar sorğu duplicate əlaqə yaratmır.
- Xəta log-da izlənə bilir, lakin həssas məlumat açılmır.

## Qiymətləndirmə
Atomiklik 35, rollback testləri 25, idempotency 25, xəta müşahidəolunması 15 bal.

## Təqdim etmə
GitHub repo və test loglarını əlavə et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Make project creation and initial member assignment atomic so a failure cannot leave partial records.

## Scenario and starting point
Use projects and project_members tables. Prepare synthetic inputs that can trigger duplicate membership, missing users, or constraint errors.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Define which writes belong inside one transaction boundary.
2. Implement it with an API transaction or database function.
3. Verify rollback after a failed step.
4. Add an idempotency strategy for repeated requests.

## Deliverables
- Migration and atomic create-service code.
- Tests for success, rollback, and retry.
- Note explaining transaction and idempotency decisions.

## Acceptance criteria
- A failed member insert does not leave a partial project.
- Retried requests do not create duplicate membership.
- Errors are traceable without exposing sensitive data.

## Evaluation
Atomicity 35, rollback tests 25, idempotency 25, error observability 15 points.

## Submission
Submit a GitHub repository and test logs.

## Estimated time
5-7 hours.$backend_engineering_2_inst_1$),
  ('backend-engineering', 5, 7, 5, $backend_engineering_2_desc_2$[[AZ]]
API davranışını OpenAPI-də sənədləşdir və nümunələrdən schema-nın işlədiyini yoxla.

[[EN]]
Document API behavior in OpenAPI and verify the schema with examples.$backend_engineering_2_desc_2$, $backend_engineering_2_inst_2$[[AZ]]
## Məqsəd
Layihə API-sinin istifadəçi üçün lazım olan contract-ını OpenAPI sənədində tam və sınaq edilə bilən göstər.

## Ssenari və başlanğıc
Create/list/detail/update endpoint-lərini götür. Uğurlu cavab, auth tələb olunan əməliyyat, validation və not-found hallarını daxil et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. Path, query və body parametrlərini schema kimi təsvir et.
2. Response obyektlərini və status code qaydalarını müəyyən et.
3. Etibarsız və ya ziddiyyətli nümunələri OpenAPI lint aləti ilə tap.
4. README-də local server-i işə salmağı və API sənədlərini açmağı yaz.

## Təhvil veriləcək
- OpenAPI YAML/JSON və endpoint nümunələri.
- Schema lint nəticəsi və ən azı 4 example request.
- Dəyişikliklərin geriyə uyğunluq qeydi.

## Qəbul meyarları
- Body və response schema-ları kodun contract-ı ilə uyğundur.
- Xəta cavablarının nümunəsi və status code-u var.
- Sənəd üçün lint xətası yoxdur.

## Qiymətləndirmə
Əhatə 30, schema dəqiqliyi 30, nümunələr 25, dəyişiklik qeydi 15 bal.

## Təqdim etmə
Repo linki ilə yanaşı OpenAPI faylını da göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Make the user-facing contract of a project API complete and testable in OpenAPI.

## Scenario and starting point
Document create/list/detail/update endpoints, including success, auth-required, validation, and not-found behavior.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Describe path, query, and body parameters as schemas.
2. Define response objects and status-code rules.
3. Find invalid or inconsistent examples with an OpenAPI lint tool.
4. Explain in the README how to start the local server and view the docs.

## Deliverables
- OpenAPI YAML/JSON and endpoint examples.
- Schema lint output and at least four example requests.
- Note on backward compatibility of changes.

## Acceptance criteria
- Request and response schemas match the implementation contract.
- Error responses have examples and status codes.
- The specification has no lint errors.

## Evaluation
Coverage 30, schema accuracy 30, examples 25, change notes 15 points.

## Submission
Submit the repository link and the OpenAPI file.

## Estimated time
4-6 hours.$backend_engineering_2_inst_2$),
  ('backend-engineering', 5, 8, 5, $backend_engineering_2_desc_3$[[AZ]]
Service qatında unit və integration testləri ilə əsas backend davranışını qoruma altına al.

[[EN]]
Protect core backend behavior with service-level unit and integration tests.$backend_engineering_2_desc_3$, $backend_engineering_2_inst_3$[[AZ]]
## Məqsəd
Task service üçün iş qaydalarını test et: task yaratma, ownership yoxlaması, status dəyişməsi və mövcud olmayan ID.

## Ssenari və başlanğıc
Test database və ya izolyasiya olunmuş in-memory adapter istifadə et. Unit testləri və ən azı bir database integration testini ayır.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. Uğurlu və rədd edilən davranışların siyahısını yaz.
2. Service logic-i HTTP qatından ayrı test et.
3. Foreign key/unique constraint nəticəsini integration testdə yoxla.
4. Edge-case nəticələrini coverage ilə deyil, konkret assertion-la təsdiqlə.

## Təhvil veriləcək
- Service unit testləri və integration test.
- Test data factory və işə salma əmri.
- Əhatə olunmayan risklərin qısa siyahısı.

## Qəbul meyarları
- İcazəsiz istifadəçi başqa istifadəçinin task-ını dəyişə bilmir.
- Constraint xətası düzgün app error-a çevrilir.
- Testlər local təmiz bazada təkrar işləyir.

## Qiymətləndirmə
Behavior coverage 35, test izolyasiyası 25, real DB yoxlaması 25, sənədləşmə 15 bal.

## Təqdim etmə
GitHub repo və test komandasını təqdim et.

## Təxmini vaxt
6-8 saat.

[[EN]]
## Objective
Test task-service rules for creation, ownership checks, status changes, and missing IDs.

## Scenario and starting point
Use a test database or isolated in-memory adapter. Separate unit tests from at least one database integration test.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. List successful and rejected behavior before writing tests.
2. Test service logic separately from the HTTP layer.
3. Verify foreign-key/unique constraint behavior in an integration test.
4. Assert edge-case outcomes directly rather than relying only on coverage numbers.

## Deliverables
- Service unit tests and an integration test.
- Test-data factory and run command.
- Short list of remaining risks.

## Acceptance criteria
- An unauthorized user cannot change another user's task.
- Constraint failures map to the correct application error.
- Tests rerun against a clean local database.

## Evaluation
Behavior coverage 35, test isolation 25, real DB verification 25, documentation 15 points.

## Submission
Submit a GitHub repository and test command.

## Estimated time
6-8 hours.$backend_engineering_2_inst_3$),
  ('backend-engineering', 6, 9, 6, $backend_engineering_2_desc_4$[[AZ]]
Log və vahid xəta cavabları əlavə et ki, production problemi izlənə bilsin.

[[EN]]
Add structured logs and consistent error responses so production failures can be traced.$backend_engineering_2_desc_4$, $backend_engineering_2_inst_4$[[AZ]]
## Məqsəd
Backend endpoint-lərində izlənə bilən request ID, strukturlaşdırılmış log və vahid error response yarat.

## Ssenari və başlanğıc
Layihə detail endpoint-inə success, validation failure və unexpected database error hallarını qur. Log-lara email, token və request body əlavə etmə.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. Error formatı və request correlation ID müəyyən et.
2. Known error və unknown exception-ı ayrı map et.
3. Log səviyyəsi, route və elapsed time əlavə et.
4. Üç ssenaridə həm client response-u, həm log sahələrini test et.

## Təhvil veriləcək
- Error middleware və strukturlaşdırılmış log nümunələri.
- 3+ test və redaktə olunmuş test logları.
- Həssas məlumatın logdan çıxarıldığını göstərən yoxlama.

## Qəbul meyarları
- Eyni xəta sinfi eyni status və response formatı verir.
- İstifadəçiyə stack trace və DB detalları getmir.
- Eyni request ID log və response-da izlənə bilir.

## Qiymətləndirmə
Error model 30, log faydalılığı 30, data minimization 25, testlər 15 bal.

## Təqdim etmə
GitHub repo və nümunə redaktə olunmuş logları göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Add traceable request IDs, structured logs, and a consistent error response to backend endpoints.

## Scenario and starting point
Exercise success, validation failure, and unexpected database error on a project-detail endpoint. Do not log email, token, or request bodies.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Define an error format and request correlation ID.
2. Map known errors separately from unexpected exceptions.
3. Add log level, route, and elapsed time.
4. Test both client responses and log fields for all three scenarios.

## Deliverables
- Error middleware and structured-log examples.
- Three or more tests and redacted sample logs.
- Check showing sensitive data is excluded from logs.

## Acceptance criteria
- The same error class returns the same status and response format.
- Stack traces and database details never reach the client.
- A request ID can be traced from response to log.

## Evaluation
Error model 30, log usefulness 30, data minimization 25, tests 15 points.

## Submission
Submit a GitHub repository and redacted sample logs.

## Estimated time
4-6 hours.$backend_engineering_2_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_backend_engineering_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'backend-engineering batch 2: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_backend_engineering_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'backend-engineering batch 2: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_backend_engineering_2 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'backend-engineering batch 2: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_backend_engineering_2;
END
$curriculum_backend_engineering_2$;

DO $curriculum_backend_engineering_3$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_backend_engineering_3 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_backend_engineering_3 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('backend-engineering', 6, 10, 7, $backend_engineering_3_desc_1$[[AZ]]
Backend servisini CI, health check və konfiqurasiya yoxlamaları ilə deploy-a hazırla.

[[EN]]
Prepare a backend service for deployment with CI, health checks, and configuration validation.$backend_engineering_3_desc_1$, $backend_engineering_3_inst_1$[[AZ]]
## Məqsəd
Sadə backend servisini yeni mühitdə etibarlı başladılan, testləri CI-da işləyən deployment paketinə çevir.

## Ssenari və başlanğıc
Docker və ya platformaya uyğun start command seç. Health/readiness endpoint, DB migration addımı və məcburi environment dəyişənləri müəyyən et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. Missing config zamanı təhlükəsiz, aydın startup xətası yarat.
2. CI-da lint, test və build ardıcıllığını qur.
3. Health check-in DB hazırlığını necə göstərdiyini izah et.
4. Deploy/rollback üçün checklist yaz; real production secret əlavə etmə.

## Təhvil veriləcək
- Dockerfile və ya deploy config, CI workflow və health endpoint.
- Təmiz mühit üçün quraşdırma/deploy təlimatı.
- Rollback və migration risklərini əhatə edən checklist.

## Qəbul meyarları
- CI uğursuz testdə deploy mərhələsinə keçmir.
- Secret-lər kod və image layer-lərində yoxdur.
- Health check startup ilə readiness-i fərqləndirir.

## Qiymətləndirmə
Təkrarlana bilən build 25, CI gate 25, config/health 25, rollback sənədi 25 bal.

## Təqdim etmə
GitHub repo və CI nəticəsi ilə təqdim et.

## Təxmini vaxt
6-8 saat.

[[EN]]
## Objective
Package a small backend service so it starts reliably in a fresh environment and runs tests in CI.

## Scenario and starting point
Choose Docker or a platform-specific start command. Define health/readiness checks, database migration steps, and required environment variables.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Fail startup clearly and safely when required configuration is missing.
2. Add CI stages for lint, tests, and build.
3. Explain how the health check represents database readiness.
4. Write deploy/rollback steps; do not add real production secrets.

## Deliverables
- Dockerfile or deployment config, CI workflow, and health endpoint.
- Setup/deployment instructions for a clean environment.
- Checklist covering rollback and migration risks.

## Acceptance criteria
- CI does not deploy when tests fail.
- Secrets are absent from source and image layers.
- Health checks distinguish startup from readiness.

## Evaluation
Reproducible build 25, CI gate 25, config/health 25, rollback documentation 25 points.

## Submission
Submit a GitHub repository with CI results.

## Estimated time
6-8 hours.$backend_engineering_3_inst_1$),
  ('backend-engineering', 8, 4, 8, $backend_engineering_3_desc_2$[[AZ]]
Tələblər, API və təhlükəsizlik testləri ilə tamamlanmış backend service nümunəsi təqdim et.

[[EN]]
Deliver a backend service feature supported by requirements, API, and security tests.$backend_engineering_3_desc_2$, $backend_engineering_3_inst_2$[[AZ]]
## Məqsəd
Layihə task-larını idarə edən kiçik backend servisini tələbdən migration, endpoint və testə qədər tamamla.

## Ssenari və başlanğıc
Task yarat, siyahıla, statusu dəyiş və ownership-i yoxla. Lokal synthetic istifadəçilər və məlumatlarla işlət; production database-ə qoşulma.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; README, pyproject.toml və requirements.txt fayllarını yoxla. Mövcud interpreter və asılılıqları dəyişməzdən əvvəl mentorla razılaşdır.
- Yeni Python mühiti üçün PowerShell: py -m venv .venv, sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, sonra source .venv/bin/activate.
- requirements.txt varsa: python -m pip install -r requirements.txt. Yeni FastAPI laboratoriyası üçün yalnız lazım olduqda: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Test: python -m pytest -q. API: uvicorn app.main:app --reload (modul yolu layihənin README-sinə uyğun olmalıdır). Lokal migration üçün: alembic upgrade head.
- Real database parolu və production data işlətmə; .env.example-da boş dəyişən adları saxla, .env faylını Git-ə əlavə etmə.

## Addım-addım icra
1. API müqaviləsi və DB modelini diaqramlaşdır.
2. Validasiya, authz, pagination və vahid xəta modelini qur.
3. Unit/integration testlərlə uğurlu, rədd edilən və yarış halını yoxla.
4. README, OpenAPI və deploy/rollback qeydi hazırla.

## Təhvil veriləcək
- Migration, backend kodu və testlər.
- OpenAPI nümunələri, seed data və quraşdırma README-si.
- Təhlükəsizlik və performans üzrə açıq risk siyahısı.

## Qəbul meyarları
- İstifadəçi yalnız icazəsi olan task-ları dəyişə bilir.
- Pagination sabitdir, xətalar vahid formadadır.
- Təmiz mühitdə bütün testlər sənədlə işə düşür.

## Qiymətləndirmə
Tələblər və model 20, implementasiya 30, authz/test 30, handoff 20 bal.

## Təqdim etmə
GitHub repo və API demo-sunu və ya ekran görüntülü qısa hesabatı təqdim et.

## Təxmini vaxt
8-12 saat.

[[EN]]
## Objective
Complete a small task-management backend feature from requirements through migration, endpoints, and tests.

## Scenario and starting point
Create tasks, list them, change status, and enforce ownership. Use synthetic local users/data; do not connect to production.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and check the README, pyproject.toml, and requirements.txt. Do not replace the existing interpreter or dependencies without a reason.
- For a new Python environment in PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. On macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- If requirements.txt exists, run python -m pip install -r requirements.txt. For a new FastAPI lab, only if needed: python -m pip install fastapi uvicorn sqlalchemy psycopg[binary] alembic pytest.
- Tests: python -m pytest -q. API: uvicorn app.main:app --reload (adjust the module path to the project README). Local migration: alembic upgrade head.
- Do not use production credentials or data. Keep empty variable names in .env.example and never commit .env.

## Step-by-step
1. Diagram the API contract and database model.
2. Implement validation, authorization, pagination, and consistent errors.
3. Test success, denial, and concurrency with unit/integration tests.
4. Prepare README, OpenAPI documentation, and deploy/rollback notes.

## Deliverables
- Migration, backend implementation, and tests.
- OpenAPI examples, seed data, and setup README.
- List of open security and performance risks.

## Acceptance criteria
- Users can modify only tasks they are authorized to access.
- Pagination is stable and errors use one consistent format.
- All tests run in a fresh environment by following the documentation.

## Evaluation
Requirements and model 20, implementation 30, authorization/tests 30, handoff 20 points.

## Submission
Submit a GitHub repository and API demo, or a short report with screenshots.

## Estimated time
8-12 hours.$backend_engineering_3_inst_2$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_backend_engineering_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 2 THEN RAISE EXCEPTION 'backend-engineering batch 3: expected 2 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_backend_engineering_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'backend-engineering batch 3: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_backend_engineering_3 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 2 THEN RAISE EXCEPTION 'backend-engineering batch 3: expected 2 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_backend_engineering_3;
END
$curriculum_backend_engineering_3$;

DO $curriculum_cybersecurity_1$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_cybersecurity_1 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_cybersecurity_1 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('cybersecurity', 1, 1, 1, $cybersecurity_1_desc_1$[[AZ]]
İzolyasiya olunmuş təhlükəsizlik laboratoriyası qur və onun əhatə dairəsi ilə təhlükəsiz istifadə qaydasını yaz.

[[EN]]
Set up an isolated security lab and document its scope and safe-use rules.$cybersecurity_1_desc_1$, $cybersecurity_1_inst_1$[[AZ]]
## Məqsəd
Təhlükəsizlik tapşırıqlarını yalnız özünün idarə etdiyi lokal laboratoriyada təhlükəsiz təkrarlamaq üçün mühit qur.

## Ssenari və başlanğıc
Docker Compose və ya lokal VM istifadə et. Zəiflik nümayişi üçün təlim tətbiqi, test bazası və dummy hesablar yarat; ictimai internet hədəflərini skan etmə.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. Şəbəkə komponentlərinin sxemini və izolyasiya sərhədlərini çək.
2. Lab-da istifadə ediləcək hədəf ünvanlarını, verilənləri və qadağan olunan əməliyyatları müəyyən et.
3. Mühiti seed və ya snapshot vasitəsilə sıfırdan bərpa edilə bilən et.
4. Lab-ı dayandırmaq, portları bağlamaq və test sirlərini silmək qaydasını yaz.

## Təhvil veriləcək
- Docker Compose/VM konfiqurasiyası, lab sxemi və quraşdırma README-si.
- Scope statement və təhlükəsiz istifadə qaydaları.
- Təmiz quraşdırmadan uğurlu başlama yoxlaması.

## Qəbul meyarları
- Hədəf yalnız lokal və ya xüsusi test şəbəkəsindədir.
- Real credentials və real şəxsi məlumat istifadə olunmur.
- Başqa tələbə mühiti reset edib yenidən qura bilir.

## Qiymətləndirmə
Təcrid 35, təkrarlana bilən quraşdırma 25, scope/safety 25, sənədləşmə 15 bal.

## Təqdim etmə
Repo/config faylları və lab-ın təhlükəsiz başladığını göstərən screenshot-u əlavə et.

## Təxmini vaxt
3-5 saat.

[[EN]]
## Objective
Create an environment for safely reproducing security exercises only in a lab you control.

## Scenario and starting point
Use Docker Compose or a local VM. Create a toy app, test database, and dummy accounts; do not scan public targets.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Draw the component network and isolation boundaries.
2. Define allowed target addresses, data, and prohibited actions.
3. Make the lab resettable from a snapshot or seed.
4. Document stopping the lab, closing ports, and removing test secrets.

## Deliverables
- Compose/VM configuration, lab diagram, and setup README.
- Scope statement and safe-use rules.
- Successful startup check from a clean setup.

## Acceptance criteria
- Targets are limited to localhost or a dedicated test network.
- No real credentials or personal data are used.
- Another student can reset and reproduce the environment.

## Evaluation
Isolation 35, reproducible setup 25, scope/safety 25, documentation 15 points.

## Submission
Submit repository/config files and a screenshot showing the lab starts safely.

## Estimated time
3-5 hours.$cybersecurity_1_inst_1$),
  ('cybersecurity', 2, 2, 2, $cybersecurity_1_desc_2$[[AZ]]
Toy web tətbiqində HTTP başlıqlarını yoxla və təhlükəsiz konfiqurasiya təklif et.

[[EN]]
Inspect HTTP headers on a toy web app and propose a safer configuration.$cybersecurity_1_desc_2$, $cybersecurity_1_inst_2$[[AZ]]
## Məqsəd
Cavab başlıqlarının brauzer təhlükəsizliyinə təsirini laboratoriya tətbiqində müşahidə və sənədləşdir.

## Ssenari və başlanğıc
Task 1-dəki lokal toy app-dən istifadə et. Bir baseline response və təhlükəsiz konfiqurasiya response-u saxla; internetdəki başqa sayta request göndərmə.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. DevTools və ya curl ilə response header-ləri topla.
2. Content-Security-Policy, X-Content-Type-Options, Referrer-Policy və frame davranışını yoxla.
3. Hər dəyişiklik üçün riskin nə olduğunu və tətbiqə təsirini izah et.
4. Header qaydalarının gözlənilən kimi işlədiyini integration testlə yoxla.

## Təhvil veriləcək
- Baseline və yenilənmiş header nümunələri.
- Server config diff-i və ən azı 4 test assertion-u.
- Tətbiq risklərini izah edən qısa qeyd.

## Qəbul meyarları
- Policy tətbiqin işləməsini səhvən pozmur.
- Header dəyərləri lab response-dan sübutla göstərilir.
- Tətbiq edilməyən başlıq uydurulmur; məhdudiyyət yazılır.

## Qiymətləndirmə
Müşahidə 25, konfiqurasiya 30, test 25, risk izahı 20 bal.

## Təqdim etmə
GitHub repo, header sübutu və test nəticələrini təqdim et.

## Təxmini vaxt
4-5 saat.

[[EN]]
## Objective
Observe and document how response headers affect browser security on a lab application.

## Scenario and starting point
Use the local toy app from Task 1. Capture a baseline response and a hardened response; do not send requests to unrelated internet sites.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Collect response headers with DevTools or curl.
2. Inspect Content-Security-Policy, X-Content-Type-Options, Referrer-Policy, and framing behavior.
3. Explain the risk addressed by each change and its effect on the app.
4. Verify the header rules with integration tests.

## Deliverables
- Baseline and updated header examples.
- Server-config diff and at least four test assertions.
- Short note explaining application risks.

## Acceptance criteria
- Policies do not unintentionally break the app.
- Header values are evidenced from the lab response.
- Do not invent unsupported headers; document any limitation.

## Evaluation
Observation 25, configuration 30, tests 25, risk explanation 20 points.

## Submission
Submit a GitHub repository, header evidence, and test results.

## Estimated time
4-5 hours.$cybersecurity_1_inst_2$),
  ('cybersecurity', 3, 3, 3, $cybersecurity_1_desc_3$[[AZ]]
Lokal nümunədə reflected/stored XSS riskini tanı və təhlükəsiz output encoding tətbiq et.

[[EN]]
Identify reflected/stored XSS risk in a local sample and apply safe output encoding.$cybersecurity_1_desc_3$, $cybersecurity_1_inst_3$[[AZ]]
## Məqsəd
XSS-in səbəbini öz lab tətbiqində göstər, təhlükəsiz düzəliş et və zərərsiz testlə yoxla.

## Ssenari və başlanğıc
Toy guestbook və ya profil adı input-undan istifadə et. Payload yalnız localhost lab-da işləməlidir; cookie oğurlama, məlumat çıxarma və real user-ə göndərmə yoxdur.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. Untrusted input-un saxlanma və render axınını izlə.
2. Harada context-ə uyğun encoding və ya framework escaping əskikdir, tap.
3. Düzəliş et; rich text tələb olunursa allowlist sanitizer seçimini izah et.
4. XSS-safe regression test əlavə et və səhifə funksiyası qaldığını yoxla.

## Təhvil veriləcək
- Zəiflik səbəbi və minimal harmless reproduction.
- Təhlükəsiz düzəlişin diff-i və regression test.
- Risk, təsir və məhdudiyyətləri izah edən qısa qeyd.

## Qəbul meyarları
- Test yalnız özünün idarə etdiyi toy app-ə yönəlir.
- HTML text kimi göstərilir, script kimi icra olunmur.
- Düzəliş yalnız bir xüsusi payload-u bloklamır; encoding qaydası əsaslandırılır.

## Qiymətləndirmə
Root cause 25, context-aware fix 35, regression test 25, izah 15 bal.

## Təqdim etmə
Repo, test nəticəsi və koddan zərərsiz screenshot əlavə et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Demonstrate the cause of XSS in your lab app, apply a safe fix, and verify it with harmless tests.

## Scenario and starting point
Use a toy guestbook or profile-name input. Payloads must stay on localhost; do not steal cookies, extract data, or send content to real users.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Trace how untrusted input is stored and rendered.
2. Find where context-aware encoding or framework escaping is missing.
3. Fix it; if rich text is required, justify an allowlist sanitizer.
4. Add an XSS-safe regression test and verify normal page behavior remains.

## Deliverables
- Root-cause note and minimal harmless reproduction.
- Secure-fix diff and regression test.
- Short explanation of risk, impact, and limitations.

## Acceptance criteria
- Tests target only a toy app you control.
- HTML is rendered as text, not executed as script.
- The fix is based on an encoding rule, not only one blocked payload.

## Evaluation
Root cause 25, context-aware fix 35, regression test 25, explanation 15 points.

## Submission
Submit the repository, test output, and a harmless code screenshot.

## Estimated time
4-6 hours.$cybersecurity_1_inst_3$),
  ('cybersecurity', 4, 4, 4, $cybersecurity_1_desc_4$[[AZ]]
Təlim verilənlər bazasında SQL injection səbəbini parameterized query ilə aradan qaldır.

[[EN]]
Fix the cause of SQL injection in a training database using parameterized queries.$cybersecurity_1_desc_4$, $cybersecurity_1_inst_4$[[AZ]]
## Məqsəd
Lab endpoint-də string concatenation riskini parameterized query ilə düzəlt və regression test yaz.

## Ssenari və başlanğıc
Yalnız lokal toy database və dummy cədvəldən istifadə et. Məqsəd zərərsiz test input-unun sorğu məntiqini dəyişmədiyini sübut etməkdir; real sistemləri yoxlama.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. SQL qurulan kod yolunu tap və user input-un necə birləşdiyini göstər.
2. Parameter binding ilə sorğunu yenidən yaz.
3. Normal axtarış, quote simvolu və sintaksisə bənzər benign input-u test et.
4. DB sorğusunun audit jurnalında parametr dəyərlərinin SQL mətnindən ayrıca ötürüldüyünü təsdiqlə.

## Təhvil veriləcək
- Zəif və düzəldilmiş query nümunəsi.
- Regression/integration test və synthetic data.
- Risk izahı və istifadə edilən driver/database qeydi.

## Qəbul meyarları
- User input SQL mətninə birləşdirilmir.
- Test yalnız lab bazasında və dummy data ilə icra olunur.
- Sorğu planı eyni qalır, input literal dəyər kimi qəbul edilir.

## Qiymətləndirmə
Root cause 25, parameterized fix 35, testlər 25, təhlükəsiz scope 15 bal.

## Təqdim etmə
Repo, test logu və qısa düzəliş hesabatını göndər.

## Təxmini vaxt
4-5 saat.

[[EN]]
## Objective
Fix string-concatenation risk in a lab endpoint with a parameterized query and a regression test.

## Scenario and starting point
Use only a local toy database and dummy table. Prove harmless test input cannot alter query logic; do not test real systems.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Find the query-construction path and show how user input was concatenated.
2. Rewrite it using parameter binding.
3. Test normal search, a quote character, and benign syntax-like input.
4. Use a database query audit to show parameters remain separate from SQL code.

## Deliverables
- Vulnerable and corrected query examples.
- Regression/integration test and synthetic data.
- Risk explanation and note of the driver/database used.

## Acceptance criteria
- User input is never concatenated into SQL text.
- Tests run only against a lab database with dummy data.
- The query structure remains fixed and input is treated as a value.

## Evaluation
Root cause 25, parameterized fix 35, tests 25, safe scope 15 points.

## Submission
Submit the repository, test log, and short remediation report.

## Estimated time
4-5 hours.$cybersecurity_1_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_cybersecurity_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'cybersecurity batch 1: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_cybersecurity_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'cybersecurity batch 1: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_cybersecurity_1 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'cybersecurity batch 1: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_cybersecurity_1;
END
$curriculum_cybersecurity_1$;

DO $curriculum_cybersecurity_2$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_cybersecurity_2 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_cybersecurity_2 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('cybersecurity', 5, 5, 5, $cybersecurity_2_desc_1$[[AZ]]
Test tətbiqdə obyekt səviyyəli authorization qaydalarını yoxla və IDOR riskini bağla.

[[EN]]
Review object-level authorization in a test app and close an IDOR risk.$cybersecurity_2_desc_1$, $cybersecurity_2_inst_1$[[AZ]]
## Məqsəd
Resurs ID-si təxmin edilə bildikdə də istifadəçinin yalnız öz obyektinə daxil olmasını sübut edən authorization testləri yaz.

## Ssenari və başlanğıc
İki dummy istifadəçi və iki task yarat. IDOR ssenarisini yalnız lokal test API-də qur; real hesab və ya production data istifadə etmə.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. İstifadəçi, tapşırıq sahibi və hər endpoint üçün icazə matrisini hazırla.
2. Öz tapşırığına, başqa istifadəçinin tapşırığına və mövcud olmayan ID-yə sorğu göndər.
3. Qorumanı client tərəfdə deyil, service/query qatında tətbiq et.
4. 403 və ya 404 cavabını seç və məlumatların açıqlanması riskinə görə əsaslandır.

## Təhvil veriləcək
- Authorization matrix və test API kodu.
- Ən azı 6 test: owner, non-owner, admin və missing object.
- Düzəliş diff-i və test nəticəsi.

## Qəbul meyarları
- ID-ni dəyişməklə başqa istifadəçinin tapşırıq məlumatını əldə etmək mümkün olmamalıdır.
- Permission yoxlaması hər object request-də server tərəfindədir.
- Owner və admin davranışı ayrı testlərlə sübut olunur.

## Qiymətləndirmə
Threat model 25, server-side fix 35, test əhatəsi 25, qərar izahı 15 bal.

## Təqdim etmə
Repo və pass/fail test hesabatını göndər.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Write authorization tests proving users can access only their own objects even when resource IDs are guessed or changed.

## Scenario and starting point
Create two dummy users and two tasks. Reproduce IDOR only in a local test API; use no real accounts or production data.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Draw a permission matrix for users, task ownership, and each endpoint.
2. Test requests for an owned task, another user's task, and a missing task.
3. Enforce access at the service/query layer, not only in the client.
4. Explain the 403-versus-404 choice in relation to data disclosure risk.

## Deliverables
- Authorization matrix and test API code.
- At least six tests for owner, non-owner, admin, and missing object.
- Fix diff and test output.

## Acceptance criteria
- Changing an ID cannot reveal another user's task data.
- Every object request checks permissions server-side.
- Owner and admin behavior are proven in separate tests.

## Evaluation
Threat model 25, server-side fix 35, test coverage 25, rationale 15 points.

## Submission
Submit a repository and pass/fail test report.

## Estimated time
5-7 hours.$cybersecurity_2_inst_1$),
  ('cybersecurity', 6, 6, 6, $cybersecurity_2_desc_2$[[AZ]]
JWT qəbulunu yoxla: imza, issuer, audience, expiry və alg seçimi üzrə testlər əlavə et.

[[EN]]
Validate JWT handling with tests for signature, issuer, audience, expiry, and algorithm choice.$cybersecurity_2_desc_2$, $cybersecurity_2_inst_2$[[AZ]]
## Məqsəd
API token yoxlamasının imzadan əlavə issuer, audience və etibarlılıq müddətini də təsdiqlədiyini göstər.

## Ssenari və başlanğıc
Lokal test secret/key pair və synthetic token-lardan istifadə et. Real key, production token və ya istifadəçi session-u işlətmə.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. Expected issuer, audience və algorithm allowlist-i müəyyən et.
2. Etibarlı token, yanlış imza, vaxtı keçmiş və yanlış audience token test et.
3. `none` və gözlənilməyən algorithm token-larının rədd edildiyini yoxla.
4. Xəta response-u və log-un token-in özünü saxlamadığını sübut et.

## Təhvil veriləcək
- JWT validation config/kodu və testlər.
- Token ssenariləri üzrə nəticə cədvəli.
- Test key-lərin ayrıca və dəyişdirilə bilən saxlanma qaydası.

## Qəbul meyarları
- Algorithm token header-i əsasında sərbəst seçilmir.
- Expiry, issuer və audience yoxlamaları məcburidir.
- Token və signing key output/log-da görünmür.

## Qiymətləndirmə
Validation qaydaları 35, mənfi testlər 30, secret qorunması 20, sənədləşmə 15 bal.

## Təqdim etmə
GitHub repo və test nəticəsini təqdim et; heç bir token və key commit etmə.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Prove that API token validation checks the intended signature, audience, issuer, and lifetime.

## Scenario and starting point
Use a local test secret/key pair and synthetic tokens. Do not use real keys, production tokens, or user sessions.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Define expected issuer, audience, and an algorithm allowlist.
2. Test a valid token, bad signature, expired token, and wrong audience.
3. Verify tokens using none or an unexpected algorithm are rejected.
4. Prove error responses/logs do not contain the token itself.

## Deliverables
- JWT validation configuration/code and tests.
- Result table for token scenarios.
- Rule for keeping test keys separate and replaceable.

## Acceptance criteria
- The algorithm is not freely selected from the token header.
- Expiry, issuer, and audience are required checks.
- Tokens and signing keys do not appear in output or logs.

## Evaluation
Validation rules 35, negative tests 30, secret protection 20, documentation 15 points.

## Submission
Submit a GitHub repository and test results; never commit tokens or keys.

## Estimated time
4-6 hours.$cybersecurity_2_inst_2$),
  ('cybersecurity', 7, 7, 7, $cybersecurity_2_desc_3$[[AZ]]
Kiçik REST API üçün endpoint, authz, data exposure və resource limit yoxlama checklist-i qur.

[[EN]]
Create an endpoint, authorization, data-exposure, and resource-limit checklist for a small REST API.$cybersecurity_2_desc_3$, $cybersecurity_2_inst_3$[[AZ]]
## Məqsəd
API təhlükəsizlik yoxlamasını təkrarlana bilən checklist-ə çevir və hər risk üçün konkret sübut tələbi göstər.

## Ssenari və başlanğıc
Yalnız Task 1 toy API və synthetic account-larını scope-a daxil et. Endpoint inventory hazırlayıb read/write və user role üzrə qrupla.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. Authn/authz, object ownership və mass assignment risklərini yoxla.
2. Response data exposure, rate limits və input validation-ı yoxla.
3. Hər yenidən yoxlamanın sübutuna sorğunu, gözlənilən nəticəni və faktiki nəticəni qeyd et.
4. Təhlili dayandırma meyarlarını və production testinin qadağan olduğunu sənədləşdir.

## Təhvil veriləcək
- API endpoint inventory və checklist.
- Hər bölmə üçün pass/fail və evidence sütunu olan nəticə.
- Tapıntıların severity və düzəliş prioriteti.

## Qəbul meyarları
- Checklist yalnız test scope daxilində işlədilir.
- Hər failed item təkrarlana bilən test və ya config sübutu göstərir.
- Severity təsir və ehtimal ilə əsaslandırılır.

## Qiymətləndirmə
Əhatə 30, evidence keyfiyyəti 30, scope nəzarəti 20, prioritetləndirmə 20 bal.

## Təqdim etmə
Checklist, test evidence və prioritetli finding report-u təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Turn an API security review into a repeatable checklist with concrete evidence requirements for each risk.

## Scenario and starting point
Scope only the toy API from Task 1 and synthetic accounts. Inventory endpoints and group them by read/write access and role.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Check authentication, authorization, object ownership, and mass-assignment risks.
2. Check response data exposure, rate limits, and input validation.
3. Record reproducible evidence: request, expected result, and actual result.
4. Define stop conditions and a rule prohibiting production testing.

## Deliverables
- API endpoint inventory and checklist.
- Results with pass/fail and evidence fields for each section.
- Severity and remediation priority for findings.

## Acceptance criteria
- The checklist is used only inside the stated test scope.
- Every failed item has a reproducible test or configuration evidence.
- Severity is justified by impact and likelihood.

## Evaluation
Coverage 30, evidence quality 30, scope control 20, prioritization 20 points.

## Submission
Submit the checklist, test evidence, and prioritized findings report.

## Estimated time
4-6 hours.$cybersecurity_2_inst_3$),
  ('cybersecurity', 8, 8, 8, $cybersecurity_2_desc_4$[[AZ]]
OWASP ZAP-ın passive scan rejimi ilə yalnız lokal toy tətbiqin response-larını yoxla.

[[EN]]
Use OWASP ZAP passive scanning to review responses from a local toy application only.$cybersecurity_2_desc_4$, $cybersecurity_2_inst_4$[[AZ]]
## Məqsəd
Passive scan nəticələrini tətbiqin kontekstində triage et; heç bir aktiv attack və ya public host scan etmə.

## Ssenari və başlanğıc
Local lab app-i ZAP-a qoş. Scope-u localhost origin ilə məhdudlaşdır və test hesabından istifadə et.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. ZAP scope və passive-only konfiqurasiyasını screenshot ilə sübut et.
2. App səhifələrini normal şəkildə gəzərək traffic yarat.
3. Xəbərdarlıqları false positive, təsdiqlənmiş risk və qəbul edilmiş risk kimi təsnif et.
4. Aktiv scan etmədən bir təhlükəsiz yaxşılaşdırma tətbiq et və nəticəni yenidən müşahidə et.

## Təhvil veriləcək
- Redaktə edilmiş scan xülasəsi və scope sübutu.
- 3 tapıntı üzrə risk, sübut, məhdudiyyət və tövsiyə.
- Bir təhlükəsiz config/code düzəlişi və əvvəl/sonra nəticəsi.

## Qəbul meyarları
- Hədəf yalnız lokal lab-dır; active scan və exploitation yoxdur.
- Xəbərdarlıq sübut olmadan vulnerability kimi elan edilmir.
- Screenshot-da token, cookie və şəxsi məlumat görünmür.

## Qiymətləndirmə
Scope/safety 30, triage 30, düzəliş 20, evidence 20 bal.

## Təqdim etmə
ZAP report xülasəsi, config screenshot-u və düzəliş repo-sunu təqdim et.

## Təxmini vaxt
4-5 saat.

[[EN]]
## Objective
Triage passive-scan results in application context; do not run active attacks or scan public hosts.

## Scenario and starting point
Connect a local lab app to ZAP. Restrict scope to the localhost origin and use a test account.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Capture proof of ZAP scope and passive-only configuration.
2. Generate traffic by browsing the app normally.
3. Classify alerts as false positive, confirmed risk, or accepted risk.
4. Implement one safe improvement and observe the result again without active scanning.

## Deliverables
- Redacted scan summary and scope evidence.
- Risk, evidence, limitation, and recommendation for three findings.
- One safe configuration/code fix with before/after result.

## Acceptance criteria
- The target is the local lab only; no active scan or exploitation.
- An alert is not reported as a vulnerability without evidence.
- Screenshots expose no token, cookie, or personal data.

## Evaluation
Scope/safety 30, triage 30, remediation 20, evidence 20 points.

## Submission
Submit the ZAP summary, configuration screenshot, and fix repository.

## Estimated time
4-5 hours.$cybersecurity_2_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_cybersecurity_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'cybersecurity batch 2: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_cybersecurity_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'cybersecurity batch 2: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_cybersecurity_2 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'cybersecurity batch 2: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_cybersecurity_2;
END
$curriculum_cybersecurity_2$;

DO $curriculum_cybersecurity_3$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_cybersecurity_3 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_cybersecurity_3 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('cybersecurity', 8, 9, 8, $cybersecurity_3_desc_1$[[AZ]]
Tapılmış təhlükəsizlik qüsurunu kök səbəbdən düzəlt və regression test ilə bağlandığını təsdiqlə.

[[EN]]
Fix a discovered security defect at its root cause and prove closure with a regression test.$cybersecurity_3_desc_1$, $cybersecurity_3_inst_1$[[AZ]]
## Məqsəd
Əvvəlki lab tapşırığından bir təsdiqlənmiş finding seç və symptom-u deyil, kök səbəbi aradan qaldır.

## Ssenari və başlanğıc
Zəif konfiqurasiyanı ayrıca branch-də saxla. Test yalnız local toy app-də işləməlidir; exploit payload-u zərərsiz minimal nümunə olsun.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. Finding-in severity, təsir və root cause-u qeyd et.
2. Ən kiçik təhlükəsiz fix-i tətbiq et.
3. Əvvəl fail edən regression test-in düzəlişdən sonra pass olduğunu göstər.
4. Yan təsiri və qalan riski yoxla; rollback yolunu yaz.

## Təhvil veriləcək
- Sanitized finding və patch diff-i.
- Fail-before/pass-after test çıxışı.
- Qısa remediation və qalan risk qeydi.

## Qəbul meyarları
- Finding yalnız konkret test və ya config diff ilə closed sayılır.
- Fix digər icazəli funksiyanı pozmur.
- Hesabatda exploit deyil, müdafiə dərsi və bərpa addımı göstərilir.

## Qiymətləndirmə
Root cause 25, düzəliş 35, regression sübutu 25, qalan risk 15 bal.

## Təqdim etmə
Repo, redaktə olunmuş test çıxışı və finding bağlanma qeydi əlavə et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Choose one confirmed lab finding and remove its root cause rather than masking the symptom.

## Scenario and starting point
Keep the vulnerable configuration in a separate branch. Tests must run only on a local toy app and use a harmless minimal reproduction.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. Record finding severity, impact, and root cause.
2. Apply the smallest safe fix.
3. Show the regression test fails before and passes after the fix.
4. Check side effects and remaining risks; document rollback.

## Deliverables
- Sanitized finding and patch diff.
- Fail-before/pass-after test output.
- Short remediation and residual-risk note.

## Acceptance criteria
- A finding is closed only with a concrete test or configuration diff.
- The fix does not break permitted functionality.
- The report focuses on defensive learning and recovery, not exploit use.

## Evaluation
Root cause 25, fix 35, regression evidence 25, residual risk 15 points.

## Submission
Submit the repository, redacted test output, and finding-closure note.

## Estimated time
4-6 hours.$cybersecurity_3_inst_1$),
  ('cybersecurity', 8, 10, 8, $cybersecurity_3_desc_2$[[AZ]]
Təhlükəsizlik laboratoriyasının nəticələrini sübutlu, risk üzrə sıralanmış yekun hesabatda birləşdir.

[[EN]]
Combine security-lab results into an evidence-backed, risk-ranked final report.$cybersecurity_3_desc_2$, $cybersecurity_3_inst_2$[[AZ]]
## Məqsəd
Lab layihəsi üçün texniki komanda və rəhbərin başa düşəcəyi, düzəlişləri prioritetləşdirən yekun hesabat yaz.

## Ssenari və başlanğıc
Əvvəlki tapşırıqlardan ən azı 3 sübutlu nəticə seç. Yalnız icazəli localhost lab fəaliyyətini hesabatda göstər.

## Alətlər və VS Code/terminal
- VS Code-da lab repo-nu aç, Docker Desktop və Docker Compose vəziyyətini yoxla. Yalnız özün idarə etdiyin localhost lab hədəfidir.
- Repo-da docker-compose.yml varsa, PowerShell/terminalda docker compose up -d --build və sonra docker compose ps işlət. Log-lar: docker compose logs. Lab bitəndə docker compose down ilə dayandır.
- ZAP istifadə ediləndə passive-only rejimi seç və scope-u localhost origin ilə məhdudlaşdır. Real domenə, ictimai IP-yə, digər tələbələrin lab-ına və production-a skan göndərmə.
- Dummy hesab və sintetik məlumat istifadə et. Token, cookie və parolu screenshot, repo və ya hesabatda göstərmə.

## Addım-addım icra
1. Executive summary-də scope, test tarixi və ümumi risk səviyyəsini yaz.
2. Hər finding üçün təsir, sübut, root cause, fix və retest nəticəsini ver.
3. Severity-ni impact/likelihood ilə əsaslandır və false positive-i ayır.
4. 30 günlük remediation sırası və məsul rol təklif et.

## Təhvil veriləcək
- 3-5 səhifəlik hesabat və redaktə olunmuş evidence əlavəsi.
- Severity cədvəli, düzəliş sahibi və retest statusu.
- İcra olunmayan testlər və məhdudiyyətlər bölməsi.

## Qəbul meyarları
- Hər finding local lab sübutuna bağlanır.
- Hesabat real xidmətə hücum edildiyini iddia etmir.
- Tövsiyələr prioritet, owner və yoxlama meyarı ilə yazılır.

## Qiymətləndirmə
Sübut keyfiyyəti 30, risk sıralaması 25, remediation 25, aydınlıq və scope 20 bal.

## Təqdim etmə
PDF hesabatı və redaktə edilmiş əlavə faylları təqdim et.

## Təxmini vaxt
6-8 saat.

[[EN]]
## Objective
Write a final report that helps an engineering team and a manager understand and prioritize lab findings.

## Scenario and starting point
Select at least three evidence-backed results from earlier tasks. Report only authorized localhost-lab activity.

## Tools, VS Code, and terminal
- Open the lab repository in VS Code and check Docker Desktop and Docker Compose. Only a localhost lab that you control is in scope.
- If the repository has docker-compose.yml, run docker compose up -d --build and then docker compose ps. View logs with docker compose logs. Stop the lab with docker compose down when finished.
- When using ZAP, select passive-only mode and restrict scope to the localhost origin. Do not scan a real domain, public IP, another student's lab, or production.
- Use dummy accounts and synthetic data. Do not include tokens, cookies, or passwords in screenshots, repositories, or reports.

## Step-by-step
1. State scope, test date, and overall risk in the executive summary.
2. For each finding, include impact, evidence, root cause, fix, and retest result.
3. Justify severity with impact/likelihood and identify false positives.
4. Propose a 30-day remediation order and responsible role.

## Deliverables
- Three-to-five-page report and redacted evidence appendix.
- Severity table, remediation owner, and retest status.
- Section on unperformed tests and limitations.

## Acceptance criteria
- Every finding is tied to local-lab evidence.
- The report does not claim testing of a real service.
- Recommendations include priority, owner, and verification criteria.

## Evaluation
Evidence quality 30, risk ranking 25, remediation 25, clarity/scope 20 points.

## Submission
Submit a PDF report and redacted appendix files.

## Estimated time
6-8 hours.$cybersecurity_3_inst_2$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_cybersecurity_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 2 THEN RAISE EXCEPTION 'cybersecurity batch 3: expected 2 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_cybersecurity_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'cybersecurity batch 3: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_cybersecurity_3 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 2 THEN RAISE EXCEPTION 'cybersecurity batch 3: expected 2 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_cybersecurity_3;
END
$curriculum_cybersecurity_3$;

DO $curriculum_data_analytics_1$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_data_analytics_1 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_data_analytics_1 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('data-analytics', 1, 1, 1, $data_analytics_1_desc_1$[[AZ]]
Analiz üçün verilənlər dəstini təmizlə, çevrilmələri sənədləşdir və əvvəl/sonra keyfiyyəti ölç.

[[EN]]
Clean an analysis dataset, document transformations, and measure quality before and after.$data_analytics_1_desc_1$, $data_analytics_1_inst_1$[[AZ]]
## Məqsəd
Xam qeydiyyat datasetini analizə hazır formaya gətir və hər dəyişiklik üçün səbəbi saxla.

## Ssenari və başlanğıc
Ən azı 100 synthetic sətirdən ibarət CSV yarat və ya istifadə et. Missing value, duplicate, yanlış tarix, artıq boşluq və fərqli kateqoriya yazılışları daxil olsun.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Sütunların mənasını və gözlənilən tipləri izah et.
2. Xam datanı dəyişmədən saxla, təmizləmə addımlarını ayrıca skriptdə yaz.
3. Duplicate, missing və invalid dəyərlər üçün açıq qayda seç.
4. Təmizləmədən əvvəl/sonra keyfiyyət cədvəli çıxar.

## Təhvil veriləcək
- Synthetic xam dataset və təmizləmə skripti/notebook.
- Data dictionary və çevrilmə qeydləri.
- Əvvəl/sonra keyfiyyət xülasəsi və 2 nümunə sətir.

## Qəbul meyarları
- Eyni input təkrar işlədiləndə eyni nəticə verir.
- Heç bir sətir səssizcə silinmir; çıxarılma səbəbi sayılır.
- Dəyişdirilməmiş xam nüsxə saxlanılır.

## Qiymətləndirmə
Data profiling 20, təmizləmə qaydaları 30, təkrarlana bilənlik 25, hesabat 25 bal.

## Təqdim etmə
Repo və notebook/skript, CSV-lər və qısa nəticə hesabatını göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Prepare a raw registration dataset for analysis and record the reason for each transformation.

## Scenario and starting point
Create or use a CSV with at least 100 synthetic rows. Include missing values, duplicates, invalid dates, extra whitespace, and inconsistent category spelling.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Explain column meaning and expected types.
2. Preserve the raw data and implement cleaning separately.
3. Choose explicit rules for duplicates, missing values, and invalid entries.
4. Produce a before/after data-quality table.

## Deliverables
- Synthetic raw dataset and cleaning script/notebook.
- Data dictionary and transformation notes.
- Before/after quality summary and two example rows.

## Acceptance criteria
- Re-running the same input produces the same output.
- No rows are silently deleted; exclusions are counted with reasons.
- An unchanged raw copy is preserved.

## Evaluation
Data profiling 20, cleaning rules 30, reproducibility 25, report 25 points.

## Submission
Submit the repository, notebook/script, CSV files, and short findings report.

## Estimated time
4-6 hours.$data_analytics_1_inst_1$),
  ('data-analytics', 2, 2, 2, $data_analytics_1_desc_2$[[AZ]]
SQL ilə təcrübə müraciətlərinin həftəlik funnel və əsas performans göstəricilərini hesabla.

[[EN]]
Use SQL to calculate a weekly application funnel and its key performance indicators.$data_analytics_1_desc_2$, $data_analytics_1_inst_2$[[AZ]]
## Məqsəd
Müraciət hadisələrindən təqdim edilmiş, nəzərdən keçirilmiş, qəbul və rədd saylarını düzgün hesablayan sorğular yaz.

## Ssenari və başlanğıc
Synthetic applications cədvəli qur: application_id, internship_id, created_at, status və reviewed_at. Hər vəziyyət və bir neçə həftə üçün nümunə sətirlər daxil et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Funnel mərhələlərinin dəqiq tərifini yaz.
2. Həftəlik müraciət, review rate və qəbul faizini SQL ilə hesabla.
3. NULL review date, təkrar event və sıfır denominator-u ayrıca idarə et.
4. Nəticəni əl ilə hesablanmış kiçik nümunə ilə tutuşdur.

## Təhvil veriləcək
- Seed data və ən azı 3 SQL sorğusu.
- KPI definition sheet və çıxış cədvəli.
- Edge-case testləri və query izahı.

## Qəbul meyarları
- Statuslar bir-birini istisna edən funnel tərifinə əsaslanır.
- Faizlər integer rounding səbəbindən səhv hesablanmır.
- Sorğular tarix aralığını və timezone-u açıq bildirir.

## Qiymətləndirmə
Metric tərifi 25, SQL düzgünlüyü 35, edge-case-lər 20, izah 20 bal.

## Təqdim etmə
SQL faylları, test dataları və nəticə cədvəlini repo-da təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Write queries that correctly count submitted, reviewed, accepted, and rejected applications from event data.

## Scenario and starting point
Create a synthetic applications table with application_id, internship_id, created_at, status, and reviewed_at. Include each status and several weeks of data.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Define each funnel stage precisely.
2. Calculate weekly applications, review rate, and acceptance rate in SQL.
3. Handle NULL review dates, duplicate events, and zero denominators explicitly.
4. Reconcile results against a small manually calculated example.

## Deliverables
- Seed data and at least three SQL queries.
- KPI definition sheet and output table.
- Edge-case tests and query explanation.

## Acceptance criteria
- Statuses follow a clear, mutually exclusive funnel definition.
- Rates are not corrupted by premature integer rounding.
- Date range and timezone are explicit in queries.

## Evaluation
Metric definitions 25, SQL correctness 35, edge cases 20, explanation 20 points.

## Submission
Submit SQL files, test data, and result tables in a repository.

## Estimated time
4-6 hours.$data_analytics_1_inst_2$),
  ('data-analytics', 4, 3, 4, $data_analytics_1_desc_3$[[AZ]]
Qərar verən üçün müraciət funnel-ını göstərən interaktiv dashboard prototipi hazırla.

[[EN]]
Build an interactive dashboard prototype that explains the application funnel to decision-makers.$data_analytics_1_desc_3$, $data_analytics_1_inst_3$[[AZ]]
## Məqsəd
Koordinatorun müraciət həcmi və mərhələlərdəki gecikmələri görə biləcəyi sadə dashboard hazırla.

## Ssenari və başlanğıc
Ən azı 3 istiqamət və 8 həftə əhatə edən synthetic data istifadə et. KPI-lar: yeni müraciət, review backlog, qəbul faizi və median baxılma müddəti.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Hər KPI üçün formula və istifadəçi qərarını yaz.
2. Filter-lər əlavə et: tarix və istiqamət.
3. Trend, funnel və backlog üçün uyğun vizuallar seç.
4. Empty state, filter nəticəsiz qalması və mobil görünüşü yoxla.

## Təhvil veriləcək
- Interaktiv dashboard və synthetic dataset.
- KPI tərifləri, filter davranışı və 3 insight.
- Ekran görüntüsü və accessibility yoxlama qeydi.

## Qəbul meyarları
- Qrafiklərin başlığı ölçüləni və vaxt aralığını bildirir.
- Eyni filter bütün əlaqəli vizuallara tətbiq edilir.
- Rəngdən başqa ölçü və etiket də istifadə olunur.

## Qiymətləndirmə
Məlumat modeli 20, KPI və vizuallar 35, filter/UX 25, insight və a11y 20 bal.

## Təqdim etmə
Dashboard linki/faylı, source və 3 insight-ı göndər.

## Təxmini vaxt
6-8 saat.

[[EN]]
## Objective
Create a simple dashboard that helps a coordinator see application volume and delays in the review stages.

## Scenario and starting point
Use synthetic data covering at least three internship tracks and eight weeks. KPIs: new applications, review backlog, acceptance rate, and median review time.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Define the formula and decision supported by each KPI.
2. Add date and internship-track filters.
3. Choose suitable visuals for trends, funnel stages, and backlog.
4. Check empty states, no-result filters, and mobile layout.

## Deliverables
- Interactive dashboard and synthetic dataset.
- KPI definitions, filter behavior, and three insights.
- Screenshot and accessibility-check note.

## Acceptance criteria
- Chart titles state the measure and time range.
- A filter applies consistently to related visuals.
- Color is not the only carrier of meaning; use labels or shapes too.

## Evaluation
Data model 20, KPIs and visuals 35, filters/UX 25, insights and accessibility 20 points.

## Submission
Submit the dashboard link/file, source, and three insights.

## Estimated time
6-8 hours.$data_analytics_1_inst_3$),
  ('data-analytics', 4, 5, 4, $data_analytics_1_desc_4$[[AZ]]
Mənbə datasetləri üçün schema və biznes qaydalarına əsaslanan data validation qur.

[[EN]]
Validate source datasets against a schema and explicit business rules.$data_analytics_1_desc_4$, $data_analytics_1_inst_4$[[AZ]]
## Məqsəd
Dashboard-a ötürülməzdən əvvəl müraciət məlumatında format, aralıq və əlaqə səhvlərini aşkar et.

## Ssenari və başlanğıc
Synthetic dataset-ə duplicate ID, gələcək tarix, naməlum status, boş internship_id və mənfi review time daxil et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Type/schema qaydaları ilə biznes qaydalarını ayrı yaz.
2. Hər qayda üçün warning və error səviyyəsi seç.
3. Hər pozuntu üçün qeyd açarı, qayda ID-si və aydın xəta izahı ver.
4. Düzgün, yalnız xəbərdarlığı olan və bloklanan fayl nümunələrini test et.

## Təhvil veriləcək
- Validation pipeline və rule kataloqu.
- Synthetic bad-data fixture-ləri və violation report.
- Səhv sətrə görə hansı addımın dayandığını göstərən qrafik.

## Qəbul meyarları
- Eyni sətir eyni rule ID ilə təkrar aşkar olunur.
- Error və warning bir-birindən seçilir.
- Validation zamanı xam dəyər itmədən saxlanılır.

## Qiymətləndirmə
Rule əhatəsi 30, violation report 25, test keyfiyyəti 25, data qorunması 20 bal.

## Təqdim etmə
Repo, test output-u və validation nəticə faylını təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Detect format, range, and relationship problems in application data before it reaches a dashboard.

## Scenario and starting point
Add duplicate IDs, future dates, unknown statuses, missing internship_id, and negative review durations to synthetic data.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Separate schema/type rules from business rules.
2. Assign each rule a warning or error severity.
3. Report record key, rule ID, and a clear explanation for each violation.
4. Test valid, warning-only, and blocked-file examples.

## Deliverables
- Validation pipeline and rule catalog.
- Synthetic bad-data fixtures and violation report.
- Diagram showing which step stops for which error.

## Acceptance criteria
- The same invalid row is identified consistently with the same rule ID.
- Errors and warnings are distinguishable.
- Raw values remain available for investigation.

## Evaluation
Rule coverage 30, violation report 25, test quality 25, data preservation 20 points.

## Submission
Submit the repository, test output, and validation results file.

## Estimated time
4-6 hours.$data_analytics_1_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_data_analytics_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'data-analytics batch 1: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_data_analytics_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'data-analytics batch 1: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_data_analytics_1 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'data-analytics batch 1: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_data_analytics_1;
END
$curriculum_data_analytics_1$;

DO $curriculum_data_analytics_2$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_data_analytics_2 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_data_analytics_2 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('data-analytics', 4, 6, 3, $data_analytics_2_desc_1$[[AZ]]
Müraciət datasetində paylanma, kənar dəyər və istiqamətlərarası fərqləri araşdır.

[[EN]]
Explore distributions, outliers, and differences between internship tracks.$data_analytics_2_desc_1$, $data_analytics_2_inst_1$[[AZ]]
## Məqsəd
Qərar verməyə yararlı hipotezlər qurmaq üçün müraciət və baxılma vaxtı datasetini araşdır.

## Ssenari və başlanğıc
Ən azı 500 synthetic application sətri, 4 istiqamət və 12 həftə istifadə et. Dataset süni olduğu hesabatda açıq göstərilməlidir.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Təkdəyişən paylanmaları və çatışmayan dəyərləri yoxla.
2. İstiqamət və həftə üzrə müraciət həcmini müqayisə et.
3. Review time outlier-lərini robust qayda ilə araşdır; avtomatik silmə.
4. Hər insight üçün alternativ izah və növbəti yoxlama yaz.

## Təhvil veriləcək
- Notebook və EDA qrafikləri.
- 5 əsas müşahidə, 2 hipotez və data limitation qeydi.
- Kənar dəyər qərarlarının izahı.

## Qəbul meyarları
- Nümunə sayı və synthetic mənbə hər nəticədə görünür.
- Korrelyasiya səbəb-nəticə kimi təqdim edilmir.
- Qrafik oxları, vahid və legend aydındır.

## Qiymətləndirmə
Profiling 20, vizual analiz 30, insight keyfiyyəti 30, məhdudiyyətlər 20 bal.

## Təqdim etmə
Notebook, istifadə olunan data və qısa EDA hesabatını təqdim et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Explore application and review-time data to generate decision-relevant hypotheses.

## Scenario and starting point
Use at least 500 synthetic application rows across four tracks and twelve weeks. State clearly in the report that the dataset is synthetic.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Inspect univariate distributions and missing values.
2. Compare application volume by track and week.
3. Investigate review-time outliers with a robust rule; do not automatically delete them.
4. For each insight, state an alternative explanation and a next validation step.

## Deliverables
- Notebook and EDA charts.
- Five observations, two hypotheses, and a data-limitations note.
- Explanation of outlier decisions.

## Acceptance criteria
- Sample size and synthetic source are visible with every finding.
- Correlation is not presented as causation.
- Chart axes, units, and legends are clear.

## Evaluation
Profiling 20, visual analysis 30, insight quality 30, limitations 20 points.

## Submission
Submit the notebook, data used, and short EDA report.

## Estimated time
5-7 hours.$data_analytics_2_inst_1$),
  ('data-analytics', 5, 7, 5, $data_analytics_2_desc_2$[[AZ]]
Qəbul cohort-larının zamanla aktiv qalma və tapşırıq tamamlama fərqini hesabla.

[[EN]]
Compare retention and task completion over time across enrollment cohorts.$data_analytics_2_desc_2$, $data_analytics_2_inst_2$[[AZ]]
## Məqsəd
Qəbul həftəsinə görə cohort yaradıb hər sonrakı həftədə internlərin aktiv və tapşırıq tamamlamış faizini ölç.

## Ssenari və başlanğıc
Synthetic enrollment və weekly_activity cədvəlləri qur. Cohort start, activity date, task completion və cancellation sahələrini daxil et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Cohort tərifini və week 0 qaydasını müəyyən et.
2. Həftəlik retention matrix və completion curve hesabla.
3. Müşahidə pəncərəsi tam olmayan yeni cohort-ları ayrıca işarələ.
4. Cohort ölçüsü və denominator-u nəticə ilə yanaşı göstər.

## Təhvil veriləcək
- SQL/notebook hesablaması və cohort heatmap.
- Metric tərifləri və əl ilə yoxlanmış kiçik nümunə.
- 3 ehtiyatlı insight və mümkün data bias-ı.

## Qəbul meyarları
- Eyni intern eyni cohort-a düşür.
- Gələcək həftələrdə məlumat yoxluğu 0 retention kimi səhv yozulmur.
- Hər hüceyrədə count və faiz uyğun gəlir.

## Qiymətləndirmə
Cohort definition 25, calculation 35, visualization 20, interpretation 20 bal.

## Təqdim etmə
Query/notebook, heatmap və nəticə izahını repo-da göndər.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Create cohorts by enrollment week and measure the share of interns active and completing tasks in later weeks.

## Scenario and starting point
Create synthetic enrollment and weekly_activity tables with cohort start, activity date, task completion, and cancellation fields.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Define cohort assignment and week-zero rules.
2. Calculate a weekly retention matrix and completion curve.
3. Mark recent cohorts whose observation window is incomplete.
4. Show cohort size and denominator beside each result.

## Deliverables
- SQL/notebook calculation and cohort heatmap.
- Metric definitions and a manually checked small example.
- Three cautious insights and possible data biases.

## Acceptance criteria
- Each intern is assigned to exactly one cohort.
- Missing future weeks are not misread as zero retention.
- Counts and percentages agree in every cell.

## Evaluation
Cohort definition 25, calculation 35, visualization 20, interpretation 20 points.

## Submission
Submit the query/notebook, heatmap, and explanation in a repository.

## Estimated time
5-7 hours.$data_analytics_2_inst_2$),
  ('data-analytics', 5, 8, 5, $data_analytics_2_desc_3$[[AZ]]
Mövcud dashboard-u metrik, filtr, əlçatanlıq və səhv yozulma baxımından audit et.

[[EN]]
Audit an existing dashboard for metric correctness, filters, accessibility, and misinterpretation risk.$data_analytics_2_desc_3$, $data_analytics_2_inst_3$[[AZ]]
## Məqsəd
Dashboard-un rəhbərə düzgün nəticə çıxarmağa kömək edib-etmədiyini yoxla və prioritetli düzəliş siyahısı hazırla.

## Ssenari və başlanğıc
Task 3 dashboard-unu və ya öz prototipini götür. Dörd istifadəçi sualı seç: neçə müraciət var, harada backlog var, dəyişiklik nə vaxt baş verib, hansı istiqamət fərqlənir.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Hər qrafikdə metric formula, denominator, tarix aralığını tap.
2. Filter-lərin bir-birinə və KPI kartlarına təsirini yoxla.
3. Keyboard, kontrast, label, mobil layout və empty state-i audit et.
4. Səhv yozulma riski olan qrafikə düzəliş eskizi hazırla.

## Təhvil veriləcək
- Audit checklist və ekran görüntüləri.
- Ən azı 5 tapıntı: təsir, sübut, təklif edilən düzəliş.
- Bir qrafikin əvvəl/sonra yenilənmiş versiyası.

## Qəbul meyarları
- Tapıntılar konkret qrafik və istifadəçi qərarına bağlanır.
- Məhdudiyyətlərdən başqa rəng seçimi ilə kifayətlənilmir.
- Düzəliş eyni mənbə rəqəmləri qoruyur.

## Qiymətləndirmə
Metric audit 25, UX/accessibility 25, finding sübutu 25, düzəliş keyfiyyəti 25 bal.

## Təqdim etmə
Audit hesabatını və düzəliş prototipini təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Determine whether a dashboard helps a decision-maker reach correct conclusions and produce a prioritized fix list.

## Scenario and starting point
Use the dashboard from Task 3 or your own prototype. Choose four user questions: application volume, backlog location, timing of change, and track differences.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Check each chart's metric formula, denominator, and date range.
2. Verify how filters affect one another and KPI cards.
3. Audit keyboard use, contrast, labels, mobile layout, and empty states.
4. Redesign one chart that is at risk of being misread.

## Deliverables
- Audit checklist and screenshots.
- At least five findings with impact, evidence, and recommended fix.
- Before/after version of one chart.

## Acceptance criteria
- Findings point to a specific chart and user decision.
- Color choice is not the only accessibility improvement considered.
- The redesign preserves the underlying source values.

## Evaluation
Metric audit 25, UX/accessibility 25, evidence quality 25, redesign quality 25 points.

## Submission
Submit the audit report and redesign prototype.

## Estimated time
4-6 hours.$data_analytics_2_inst_3$),
  ('data-analytics', 6, 4, 6, $data_analytics_2_desc_4$[[AZ]]
Müraciət məlumatından koordinator üçün tövsiyə və məhdudiyyətləri olan tam data case study hazırla.

[[EN]]
Create a complete application-data case study with recommendations and limitations for a coordinator.$data_analytics_2_desc_4$, $data_analytics_2_inst_4$[[AZ]]
## Məqsəd
Müraciət funnel-ı üzrə biznes sualını data ilə cavabla; nəticəni qərar və növbəti ölçmə planına çevir.

## Ssenari və başlanğıc
Synthetic 12 həftəlik application data istifadə et. Sual: review gecikməsi hansı mərhələdə artır və hansı istiqamətlərdə fərq var? Data-nın süni olduğunu göstər.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Analiz planı və KPI təriflərini əvvəlcədən yaz.
2. Data validation və SQL/EDA ilə nəticələri hesabla.
3. Dashboard və əsas insight-ları birləşdir.
4. Tövsiyənin gözlənilən təsirini, riskini və yoxlama metric-ini müəyyən et.

## Təhvil veriləcək
- Təkrarlana bilən notebook/query və data dictionary.
- Funnel/dashboard vizualı və 3 sübutlu insight.
- 2 əməli tövsiyə, məhdudiyyətlər və növbəti eksperiment planı.

## Qəbul meyarları
- Hər iddia query və ya qrafiklə izlənə bilir.
- Synthetic data-dan real şirkət barədə fakt çıxarılmır.
- Tövsiyə owner, vaxt və ölçülə bilən nəticə ilə yazılır.

## Qiymətləndirmə
Metod 20, texniki düzgünlük 30, insight/tövsiyə 30, şəffaflıq və təqdimat 20 bal.

## Təqdim etmə
Repo, hesabat və 5 dəqiqəlik demo və ya slaydlı təqdimat ver.

## Təxmini vaxt
8-10 saat.

[[EN]]
## Objective
Answer a business question about the application funnel and turn evidence into a decision and measurement plan.

## Scenario and starting point
Use synthetic 12-week application data. Question: where does review delay increase, and which tracks differ? State clearly that the data is synthetic.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Write an analysis plan and KPI definitions before exploring.
2. Validate the data and calculate results with SQL/EDA.
3. Combine a dashboard with the key insights.
4. Define expected impact, risk, and a metric to validate each recommendation.

## Deliverables
- Reproducible notebook/query and data dictionary.
- Funnel/dashboard visual and three evidence-backed insights.
- Two operational recommendations, limitations, and next-experiment plan.

## Acceptance criteria
- Every claim can be traced to a query or chart.
- Synthetic data is not presented as a fact about a real organization.
- Recommendations name an owner, timeframe, and measurable outcome.

## Evaluation
Method 20, technical correctness 30, insight/recommendation 30, transparency/presentation 20 points.

## Submission
Submit the repository, report, and a five-minute demo or slide presentation.

## Estimated time
8-10 hours.$data_analytics_2_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_data_analytics_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'data-analytics batch 2: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_data_analytics_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'data-analytics batch 2: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_data_analytics_2 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'data-analytics batch 2: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_data_analytics_2;
END
$curriculum_data_analytics_2$;

DO $curriculum_data_analytics_3$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_data_analytics_3 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_data_analytics_3 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('data-analytics', 6, 9, 6, $data_analytics_3_desc_1$[[AZ]]
Analiz nəticəsini qeyri-texniki auditoriyaya problem–sübut–tövsiyə hekayəsi ilə çatdır.

[[EN]]
Communicate analytical findings to a non-technical audience using a problem-evidence-recommendation narrative.$data_analytics_3_desc_1$, $data_analytics_3_inst_1$[[AZ]]
## Məqsəd
Texniki sorğu və statistikaları rəhbərin qərar verə biləcəyi qısa, dürüst data hekayəsinə çevir.

## Ssenari və başlanğıc
Case study nəticələrini istifadə et. Tək bir əsas mesaj seç: məsələn, review gecikməsinin artıb-artmadığını yoxla. Audience: təcrübə koordinatoru.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Əsas sualı və bir cümləlik cavabı yaz.
2. 3-dən çox olmayan qrafik seç; hər birində vahid, aralıq və denominator göstər.
3. Hər insight üçün sübut, qeyri-müəyyənlik və tövsiyə ver.
4. Başlığın qrafikdən çıxan nəticəni deməsini yoxla.

## Təhvil veriləcək
- 1 səhifəlik memo və ya maksimum 5 slayd.
- Qrafiklərin source query-si və data qeydi.
- Qərar sahibi üçün 3 konkret növbəti addım.

## Qəbul meyarları
- Slayd/memo texniki biliyi olmayan şəxs tərəfindən anlaşılandır.
- Faizlərdə baza sayı gizlədilmir.
- Müşahidə ilə səbəb iddiası ayrılır.

## Qiymətləndirmə
Mesaj aydınlığı 30, sübut və vizual 30, dürüst məhdudiyyət 20, qərar addımı 20 bal.

## Təqdim etmə
PDF/PPT və mənbə qrafik/data faylını əlavə et.

## Təxmini vaxt
3-5 saat.

[[EN]]
## Objective
Turn technical queries and statistics into a concise, honest data story that supports a decision.

## Scenario and starting point
Use the case-study findings. Choose one main message, such as whether review delays have increased. Audience: an internship coordinator.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. State the main question and answer it in one sentence.
2. Use no more than three charts; show units, range, and denominator on each.
3. For every insight, give evidence, uncertainty, and a recommendation.
4. Make chart titles state the conclusion supported by the data.

## Deliverables
- One-page memo or a maximum of five slides.
- Source query and data note for each chart.
- Three concrete next steps for the decision-maker.

## Acceptance criteria
- A non-technical reader can understand the memo/slides.
- Base counts are visible for percentages.
- Observation is distinguished from causal claims.

## Evaluation
Message clarity 30, evidence/visuals 30, honest limitations 20, decision steps 20 points.

## Submission
Submit PDF/PPT and source chart/data files.

## Estimated time
3-5 hours.$data_analytics_3_inst_1$),
  ('data-analytics', 6, 10, 6, $data_analytics_3_desc_2$[[AZ]]
Analiz layihəsini başqa analitikin yenidən icra edə biləcəyi şəkildə paketlə və məhdudiyyətləri sənədləşdir.

[[EN]]
Package an analysis so another analyst can reproduce it and understand its limitations.$data_analytics_3_desc_2$, $data_analytics_3_inst_2$[[AZ]]
## Məqsəd
Data-dan yekun qrafikə qədər analiz zəncirini yeni kompüterdə təkrarlana bilən et.

## Ssenari və başlanğıc
Task 6/8 case study-ni götür. Raw synthetic data, təmizləmə skripti, query/notebook və output-u versiyala.

## Alətlər və VS Code/terminal
- VS Code-da repo-nu aç və dataset-in mənbəyini, sütunlarını və README-ni yoxla. Real tələbə və müştəri məlumatı əvəzinə açıq və ya sintetik dataset seç.
- PowerShell: py -m venv .venv; sonra .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv; sonra source .venv/bin/activate.
- Python kitabxanaları: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Notebook açmaq üçün: jupyter lab. Mövcud requirements.txt varsa, ayrıca siyahı əvəzinə python -m pip install -r requirements.txt işlət.
- Təhlil skripti: python path/to/analysis.py; testlər mövcuddursa: python -m pytest -q. SQL tapşırığında psql və ya seçilmiş SQL editorundan istifadə et; parolu komanda sətrinə yazma.

## Addım-addım icra
1. Folder quruluşu, dependency version və run order yaz.
2. Seed və random state istifadə et ki, synthetic data eyni yaransın.
3. Output üçün sanity-check assertion-ları əlavə et.
4. Başqa qovluğa clone edib setup təlimatını sıfırdan yoxla.

## Təhvil veriləcək
- README, dependency lock/requirements, data dictionary və run script.
- Raw və generated data fərqini göstərən qeyd.
- Bir əmrlə qurulan yekun cədvəl/qrafik və reproduction check.

## Qəbul meyarları
- Secret, şəxsi məlumat və local absolute path yoxdur.
- Fresh clone sənədlə uğurla işləyir.
- Mənbə, çevrilmə və nəticə bir-birinə bağlanır.

## Qiymətləndirmə
Reproducibility 35, layihə quruluşu 20, sanity check 25, handoff 20 bal.

## Təqdim etmə
Repo linki və təmiz mühitdə təkrarlanma nəticəsini təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Make the entire analysis chain reproducible on a fresh computer, from data through final charts.

## Scenario and starting point
Package the case study from Task 6/8. Version the synthetic raw data, cleaning script, query/notebook, and outputs.

## Tools, VS Code, and terminal
- Open the repository in VS Code and inspect the dataset source, columns, and README. Use an open or synthetic dataset instead of real student or customer records.
- PowerShell: py -m venv .venv, then .\.venv\Scripts\Activate.ps1. macOS/Linux: python3 -m venv .venv, then source .venv/bin/activate.
- Python tools: python -m pip install pandas numpy matplotlib seaborn jupyterlab. Start notebooks with jupyter lab. If requirements.txt already exists, use python -m pip install -r requirements.txt instead.
- Run an analysis script with python path/to/analysis.py; if tests exist, run python -m pytest -q. For SQL tasks, use psql or the selected SQL editor; never put a password in the command line.

## Step-by-step
1. Document folder structure, dependency versions, and run order.
2. Use a seed/random state so synthetic data is regenerated consistently.
3. Add sanity-check assertions for key outputs.
4. Clone to a different folder and follow setup instructions from scratch.

## Deliverables
- README, dependency lock/requirements, data dictionary, and run script.
- Note distinguishing raw data from generated outputs.
- One-command build of final tables/charts and a reproducibility check.

## Acceptance criteria
- No secrets, personal data, or machine-specific absolute paths are included.
- A fresh clone runs successfully by following the documentation.
- Sources, transformations, and results are traceable to one another.

## Evaluation
Reproducibility 35, project structure 20, sanity checks 25, handoff 20 points.

## Submission
Submit the repository link and a fresh-environment reproduction result.

## Estimated time
4-6 hours.$data_analytics_3_inst_2$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_data_analytics_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 2 THEN RAISE EXCEPTION 'data-analytics batch 3: expected 2 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_data_analytics_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'data-analytics batch 3: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_data_analytics_3 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 2 THEN RAISE EXCEPTION 'data-analytics batch 3: expected 2 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_data_analytics_3;
END
$curriculum_data_analytics_3$;

DO $curriculum_frontend_engineering_1$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_frontend_engineering_1 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_frontend_engineering_1 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('frontend-engineering', 1, 1, 1, $frontend_engineering_1_desc_1$[[AZ]]
Mobil və desktop-da oxunaqlı, əlçatan və responsive məhsul landing page-i hazırla.

[[EN]]
Build a readable, accessible, responsive product landing page for mobile and desktop.$frontend_engineering_1_desc_1$, $frontend_engineering_1_inst_1$[[AZ]]
## Məqsəd
Bir təcrübə proqramının dəyərini, uyğun namizədi və müraciət addımını aydın göstərən landing page hazırla.

## Ssenari və başlanğıc
Dizaynı özün seç; səhifədə hero, proqram faydaları, tələb olunan bacarıqlar, mərhələlər və müraciət CTA-sı olsun. Real əlaqə məlumatı uydurma.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. Əsas istifadəçi və bir əsas hərəkəti müəyyən et.
2. Semantic HTML və responsive layout qur.
3. 360px və 1280px enlərdə overflow, nav və CTA yoxla.
4. Keyboard focus, heading order, image alt və contrast yoxlaması et.

## Təhvil veriləcək
- Source code və işləyən page.
- Mobile/desktop screenshot-lar.
- Qısa qərar qeydi və responsive/a11y yoxlama nəticəsi.

## Qəbul meyarları
- Mobil görünüşdə horizontal scroll yoxdur.
- CTA label-i aydın, klaviatura ilə əlçatandır.
- Placeholder link və doldurulmamış lorem mətni yoxdur.

## Qiymətləndirmə
Məzmun iyerarxiyası 25, responsive davranış 25, əlçatanlıq 25, kod keyfiyyəti 25 bal.

## Təqdim etmə
GitHub repo və işləyən preview linkini əlavə et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Create a landing page that clearly communicates an internship program's value, target candidate, and application step.

## Scenario and starting point
Choose the design direction. Include a hero, program benefits, required skills, process steps, and application CTA. Do not invent real contact details.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Define the primary audience and one primary action.
2. Build the page with semantic HTML and responsive layout.
3. Check overflow, navigation, and CTA at 360px and 1280px widths.
4. Review keyboard focus, heading order, image alt text, and contrast.

## Deliverables
- Source code and working page.
- Mobile and desktop screenshots.
- Short design rationale and responsive/accessibility check results.

## Acceptance criteria
- No horizontal scrolling on the mobile layout.
- CTA label is clear and keyboard-accessible.
- No placeholder links or unfilled lorem text remain.

## Evaluation
Content hierarchy 25, responsive behavior 25, accessibility 25, code quality 25 points.

## Submission
Submit a GitHub repository and working preview link.

## Estimated time
5-7 hours.$frontend_engineering_1_inst_1$),
  ('frontend-engineering', 2, 2, 2, $frontend_engineering_1_desc_2$[[AZ]]
Təkrar istifadə edilən form, badge və empty-state komponentləri ilə kiçik UI sistem qur.

[[EN]]
Build a small UI system with reusable form, badge, and empty-state components.$frontend_engineering_1_desc_2$, $frontend_engineering_1_inst_2$[[AZ]]
## Məqsəd
İntern portalı üçün eyni davranış və görünüşü paylaşan, prop-ları aydın komponentlər yarat.

## Ssenari və başlanğıc
Button, TextField, StatusBadge və EmptyState komponentlərini seç. Hər biri üçün loading/disabled/error və ya empty variantını müəyyən et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. Component API və variantları əvvəlcədən yaz.
2. Spacing, rəng və typography token-larını mərkəzləşdir.
3. Controlled input və accessible label/error association əlavə et.
4. Story/demo page-də bütün variantları və real nümunələri göstər.

## Təhvil veriləcək
- 4 reusable component və TypeScript prop-ları.
- Demo/stories və ən azı 6 UI test.
- Qısa component usage guide.

## Qəbul meyarları
- Eyni variantlar bir-birindən yalnız token ilə fərqlənir.
- Form xətası assistive technology üçün əlaqələndirilir.
- Component səhv prop-da anlaşılmaz davranmır.

## Qiymətləndirmə
API dizaynı 25, vizual ardıcıllıq 25, əlçatanlıq 25, test/sənəd 25 bal.

## Təqdim etmə
Repo, demo screenshot və test nəticələrini təqdim et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Create reusable components for an intern portal with consistent behavior and clear props.

## Scenario and starting point
Choose Button, TextField, StatusBadge, and EmptyState. Define loading/disabled/error or empty variants for each.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Specify component APIs and variants first.
2. Centralize spacing, color, and typography tokens.
3. Add controlled inputs and accessible label/error associations.
4. Show every variant and realistic usage in a demo/story page.

## Deliverables
- Four reusable components with TypeScript props.
- Demo/stories and at least six UI tests.
- Short component-usage guide.

## Acceptance criteria
- Variants differ through documented tokens, not duplicated markup.
- Form errors are programmatically associated for assistive technology.
- Invalid props do not produce confusing behavior.

## Evaluation
API design 25, visual consistency 25, accessibility 25, tests/documentation 25 points.

## Submission
Submit the repository, demo screenshot, and test results.

## Estimated time
5-7 hours.$frontend_engineering_1_inst_2$),
  ('frontend-engineering', 4, 3, 3, $frontend_engineering_1_desc_3$[[AZ]]
API məlumatı ilə yüklənmə, uğur, boş və xəta vəziyyətləri olan idarəetmə paneli qur.

[[EN]]
Build a data-backed dashboard with loading, success, empty, and error states.$frontend_engineering_1_desc_3$, $frontend_engineering_1_inst_3$[[AZ]]
## Məqsəd
Koordinator üçün müraciət sayını və son müraciətləri göstərən dashboard-u API ilə birləşdir.

## Ssenari və başlanğıc
Mock endpoint 200, boş array, 401 və 500 ssenarilərini qaytarsın. Məxfi real məlumat əvəzinə synthetic name/status istifadə et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. Data type və API response contract-ını qur.
2. Loading, empty, recoverable error və success UI hazırla.
3. Refresh və retry düymələrinin davranışını müəyyən et.
4. Network failure və slow response-u test et.

## Təhvil veriləcək
- İşlək dashboard və mock API adapter-i.
- Dörd vəziyyətin screenshot-u.
- API və state davranışını əhatə edən component testləri.

## Qəbul meyarları
- Boş siyahı ilə API xətası eyni mesajı göstərmir.
- Ekran request tamamlanana qədər qırılmır.
- Retry təkrar paralel request yaratmır.

## Qiymətləndirmə
Data contract 20, UI states 30, failure/retry 25, test və a11y 25 bal.

## Təqdim etmə
Repo və public preview və ya local demo təlimatını təqdim et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Connect a coordinator dashboard showing application counts and recent submissions to an API.

## Scenario and starting point
The mock endpoint returns 200, an empty array, 401, and 500. Use synthetic names/statuses, not real personal data.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Define data types and the API response contract.
2. Build loading, empty, recoverable-error, and success states.
3. Specify refresh and retry behavior.
4. Test network failure and a slow response.

## Deliverables
- Working dashboard and mock API adapter.
- Screenshots of the four states.
- Component tests for API and state behavior.

## Acceptance criteria
- Empty results and API errors do not show the same message.
- The page remains usable while a request is pending.
- Retry does not create duplicate parallel requests.

## Evaluation
Data contract 20, UI states 30, failure/retry 25, tests/accessibility 25 points.

## Submission
Submit the repository and a public preview or local-demo instructions.

## Estimated time
5-7 hours.$frontend_engineering_1_inst_3$),
  ('frontend-engineering', 4, 5, 4, $frontend_engineering_1_desc_4$[[AZ]]
Müraciət formunu label, inline validation və aydın uğur/xəta axını ilə tamamla.

[[EN]]
Build an application form with labels, inline validation, and clear success/error flows.$frontend_engineering_1_desc_4$, $frontend_engineering_1_inst_4$[[AZ]]
## Məqsəd
Tələbənin motivasiya, təcrübə və portfolio məlumatını itkisiz təqdim edə biləcəyi form yarat.

## Ssenari və başlanğıc
Mock submit endpoint istifadə et. Required motivasiya, optional portfolio URL və mətn sahələri üçün limit müəyyən et.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. Form label, help text və client-side validation qur.
2. Server xətasını uyğun field və ya form səviyyəsinə göstər.
3. Submit zamanı disabled/loading, success və safe retry davranışı əlavə et.
4. Keyboard-only və screen-reader label/error bağlantısını yoxla.

## Təhvil veriləcək
- Form component və validation rules.
- Uğur, invalid input, server error və network failure testləri.
- Mobile screenshot və accessibility checklist.

## Qəbul meyarları
- Xəta yalnız rənglə göstərilmir və səbəbi izah edilir.
- Double-click iki müraciət yaratmır.
- Səhv cavabdan sonra istifadəçinin daxil etdiyi məlumat saxlanır.

## Qiymətləndirmə
Form UX 25, validation 25, error recovery 25, accessibility/test 25 bal.

## Təqdim etmə
Repo, demo və test nəticələrini göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Create a form that lets a student submit motivation, experience, and portfolio details without losing entered data.

## Scenario and starting point
Use a mocked submit endpoint. Define a required motivation field, optional portfolio URL, and text-length limits.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Add form labels, help text, and client-side validation.
2. Show server errors at the relevant field or form level.
3. Add disabled/loading, success, and safe-retry behavior.
4. Check keyboard-only use and screen-reader label/error associations.

## Deliverables
- Form component and validation rules.
- Tests for success, invalid input, server error, and network failure.
- Mobile screenshot and accessibility checklist.

## Acceptance criteria
- Errors are not communicated by color alone and explain the issue.
- Double-clicking submit does not create two applications.
- User input remains available after a failed response.

## Evaluation
Form UX 25, validation 25, error recovery 25, accessibility/tests 25 points.

## Submission
Submit the repository, demo, and test results.

## Estimated time
4-6 hours.$frontend_engineering_1_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_frontend_engineering_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'frontend-engineering batch 1: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_frontend_engineering_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'frontend-engineering batch 1: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_frontend_engineering_1 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'frontend-engineering batch 1: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_frontend_engineering_1;
END
$curriculum_frontend_engineering_1$;

DO $curriculum_frontend_engineering_2$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_frontend_engineering_2 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_frontend_engineering_2 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('frontend-engineering', 4, 6, 4, $frontend_engineering_2_desc_1$[[AZ]]
Dashboard filter və müraciət formu state-ini proqnozlaşdırılan, test edilən qaydada idarə et.

[[EN]]
Manage dashboard-filter and application-form state predictably and testably.$frontend_engineering_2_desc_1$, $frontend_engineering_2_inst_1$[[AZ]]
## Məqsəd
Filter, sort, pagination və form state-lərini component-lər arasında aydın şəkildə saxla.

## Ssenari və başlanğıc
Dashboard data set-inə status filter, search query və page əlavə et; form üçün dirty, submitting və success state-lərini modelləşdir.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. Hansı state-in URL, hansının local component-də olacağını seç.
2. Filter dəyişəndə page reset və query serialization davranışını qur.
3. Derived state-i təkrar saxlamadan selector/helper ilə hesabla.
4. State transition-ları unit testlə və browser refresh ilə yoxla.

## Təhvil veriləcək
- State model/diagram və kod.
- Filter/search/pagination və form transition testləri.
- Refresh/back düyməsi üçün qısa demo.

## Qəbul meyarları
- URL-də saxlanmalı filter refresh sonrası bərpa olunur.
- Bir state dəyişəndə əlaqəsiz form məlumatı itmır.
- Eyni məlumat iki yerdə ziddiyyətli saxlanmır.

## Qiymətləndirmə
State sərhədi 30, transition correctness 25, URL davranışı 20, testlər 25 bal.

## Təqdim etmə
Repo, state diagram və test output-u təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Manage filter, sort, pagination, and form state clearly across components.

## Scenario and starting point
Add status filter, search query, and page to a dashboard dataset; model dirty, submitting, and success states for a form.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Decide which state belongs in the URL and which remains local.
2. Reset page when filters change and serialize query state.
3. Compute derived state through selectors/helpers instead of storing duplicates.
4. Test transitions and verify behavior after browser refresh.

## Deliverables
- State model/diagram and implementation.
- Tests for filters, search, pagination, and form transitions.
- Short demo of refresh/back-button behavior.

## Acceptance criteria
- URL-persisted filters restore after refresh.
- Changing one state does not erase unrelated form input.
- The same data is not stored inconsistently in two places.

## Evaluation
State boundaries 30, transition correctness 25, URL behavior 20, tests 25 points.

## Submission
Submit the repository, state diagram, and test output.

## Estimated time
4-6 hours.$frontend_engineering_2_inst_1$),
  ('frontend-engineering', 5, 7, 5, $frontend_engineering_2_desc_2$[[AZ]]
Frontend yüklənməsini ölç, ən bahalı bottleneck-i müəyyən et və sübutla optimallaşdır.

[[EN]]
Measure frontend loading, identify the largest bottleneck, and optimize it with evidence.$frontend_engineering_2_desc_2$, $frontend_engineering_2_inst_2$[[AZ]]
## Məqsəd
Səhifənin real yüklənmə və bundle davranışını ölç, sonra yalnız sübut olunan bottleneck-i düzəlt.

## Ssenari və başlanğıc
Dashboard route-u baseline kimi götür. Eyni cihaz, build mode və network profile ilə ölçmə apar.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. Bundle analyzer və browser performance trace ilə başlanğıc ölç.
2. Böyük dependency-ləri, şəkilləri, bloklayan sorğuları və lazımsız yenidən renderləri araşdır.
3. Ən vacib yaxşılaşdırmanı seç və tətbiq et.
4. Eyni mühitdə yenidən ölç, əvvəlki və sonrakı nəticələri müqayisə et.

## Təhvil veriləcək
- Baseline/final trace və bundle ölçüsü.
- Bir optimallaşdırma diff-i və ölçülən təsir.
- Dəyişməyən və pisləşən metric varsa, dürüst izah.

## Qəbul meyarları
- Müqayisə eyni build və şəbəkə şərtində aparılıb.
- İstifadəçi davranışı dəyişmədən yaxşılaşma göstərilib.
- Lazımsız memoization əlavə olunmayıb.

## Qiymətləndirmə
Ölçmə keyfiyyəti 25, bottleneck təhlili 25, optimallaşdırma 30, trade-off izahı 20 bal.

## Təqdim etmə
Repo və redaktə edilmiş performance hesabatını təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Measure page loading and bundle behavior, then fix only a bottleneck supported by evidence.

## Scenario and starting point
Use the dashboard route as the baseline. Keep device, build mode, and network profile consistent.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Capture a baseline with a bundle analyzer and browser performance trace.
2. Inspect large dependencies, images, blocking requests, and re-renders.
3. Choose and implement one highest-impact improvement.
4. Measure again under the same conditions and compare before/after.

## Deliverables
- Baseline/final traces and bundle-size measurements.
- One optimization diff and measured impact.
- Honest explanation of any metric that did not improve or regressed.

## Acceptance criteria
- Comparison uses the same build and network conditions.
- Improvement is demonstrated without changing user behavior unexpectedly.
- Unnecessary memoization is not added.

## Evaluation
Measurement quality 25, bottleneck analysis 25, optimization 30, trade-off explanation 20 points.

## Submission
Submit the repository and redacted performance report.

## Estimated time
4-6 hours.$frontend_engineering_2_inst_2$),
  ('frontend-engineering', 5, 8, 5, $frontend_engineering_2_desc_3$[[AZ]]
Component, user interaction və əsas error state-lər üçün etibarlı frontend testləri yaz.

[[EN]]
Write reliable frontend tests for components, user interactions, and error states.$frontend_engineering_2_desc_3$, $frontend_engineering_2_inst_3$[[AZ]]
## Məqsəd
Tələbənin müraciət formu və koordinator dashboard-unda ən vacib davranışları regressiyadan qoru.

## Ssenari və başlanğıc
React Testing Library, Vitest/Jest və ya layihənin mövcud stack-indən istifadə et. Testlər implementation detalı deyil, istifadəçi görünüşlü davranışı yoxlasın.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. Əsas happy path və 4 error/edge state seç.
2. Label, button role və görünən mətn üzrə element tap.
3. API call-u mock et, loading və retry axınını yoxla.
4. Flaky timer, real network və ortaq state istifadəsindən qaç.

## Təhvil veriləcək
- Ən azı 8 UI test və işləyən test script-i.
- Hər testin hansı riskin qarşısını aldığını göstərən cədvəl.
- Testləri sıfırdan işə salma addımı.

## Qəbul meyarları
- Testlər clean environment-də stabil işləyir.
- Accessibility semantics istifadə olunur.
- Testlər daxili class adı və DOM quruluşuna həddən artıq bağlı deyil.

## Qiymətləndirmə
Behavior coverage 35, test sabitliyi 25, a11y queries 20, təhvil 20 bal.

## Təqdim etmə
Repo və test output-u təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Protect the most important behaviors in a student application form and coordinator dashboard from regressions.

## Scenario and starting point
Use React Testing Library, Vitest/Jest, or the project's existing stack. Test user-visible behavior rather than implementation details.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Select the main happy path and four error/edge states.
2. Locate elements by label, button role, and visible text.
3. Mock API calls and verify loading and retry behavior.
4. Avoid flaky timers, real network access, and shared-state leakage.

## Deliverables
- At least eight UI tests and a working test script.
- Table showing which risk each test prevents.
- Instructions for running tests from a clean checkout.

## Acceptance criteria
- Tests run reliably in a clean environment.
- Tests use accessible semantics.
- Tests do not depend heavily on private class names or DOM structure.

## Evaluation
Behavior coverage 35, test stability 25, accessibility queries 20, handoff 20 points.

## Submission
Submit the repository and test output.

## Estimated time
4-6 hours.$frontend_engineering_2_inst_3$),
  ('frontend-engineering', 6, 9, 6, $frontend_engineering_2_desc_4$[[AZ]]
Code review tapıntılarını istifadəçi təsiri üzrə prioritetləşdir və təhlükəsiz düzəlişlə bağla.

[[EN]]
Prioritize code-review findings by user impact and close them with safe fixes.$frontend_engineering_2_desc_4$, $frontend_engineering_2_inst_4$[[AZ]]
## Məqsəd
Frontend pull request-də correctness, accessibility, performance və maintainability problemlərini sübutla tap və ən vacibini düzəlt.

## Ssenari və başlanğıc
Kiçik component və ya öz əvvəlki tapşırığındakı diff-i audit et. Style preference-i bug kimi təqdim etmə.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. PR məqsədi və qəbul meyarlarını oxu.
2. Tapıntını reproducible addım, line/component və təsirlə yaz.
3. Severity və istifadəçiyə təsirə görə sırala.
4. Bir yüksək təsirli finding-i test əlavə edərək düzəlt.

## Təhvil veriləcək
- 3-5 review tapıntısı olan hesabat.
- Bir düzəliş diff-i və əvvəl fail edən test.
- Qalan risk və retest statusu.

## Qəbul meyarları
- Hər finding təkrarlana bilən və konkret fayla bağlıdır.
- Rəng/üslub seçimi yalnız standart və user impact pozulanda finding sayılır.
- Fix regressiya testi ilə qorunur.

## Qiymətləndirmə
Finding dəqiqliyi 30, prioritet 20, düzəliş 30, regression sübutu 20 bal.

## Təqdim etmə
GitHub repo və review qeydlərini təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Identify correctness, accessibility, performance, and maintainability issues in a frontend change and fix the highest-impact one with evidence.

## Scenario and starting point
Review a small component or a diff from an earlier task. Do not report personal style preference as a bug.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Read the pull request goal and acceptance criteria.
2. Describe findings with reproduction steps, file/component, and impact.
3. Rank them by severity and user effect.
4. Fix one high-impact finding and add a test.

## Deliverables
- Report with three to five review findings.
- One fix diff and a test that failed before the fix.
- Residual-risk note and retest status.

## Acceptance criteria
- Each finding is reproducible and tied to a specific file.
- Aesthetic preference is reported only when it violates a standard or harms users.
- The fix is protected by a regression test.

## Evaluation
Finding accuracy 30, prioritization 20, remediation 30, regression evidence 20 points.

## Submission
Submit the GitHub repository and review notes.

## Estimated time
4-6 hours.$frontend_engineering_2_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_frontend_engineering_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'frontend-engineering batch 2: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_frontend_engineering_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'frontend-engineering batch 2: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_frontend_engineering_2 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'frontend-engineering batch 2: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_frontend_engineering_2;
END
$curriculum_frontend_engineering_2$;

DO $curriculum_frontend_engineering_3$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_frontend_engineering_3 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_frontend_engineering_3 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('frontend-engineering', 6, 10, 7, $frontend_engineering_3_desc_1$[[AZ]]
Frontend xüsusiyyətini developer və dizaynerə təhvil ver: setup, component, test və məhdudiyyətləri yaz.

[[EN]]
Hand off a frontend feature with setup, component, test, and limitation details.$frontend_engineering_3_desc_1$, $frontend_engineering_3_inst_1$[[AZ]]
## Məqsəd
Başqa developer feature-i local-da qura, yoxlaya və dəyişə bilsin; dizayner də state və breakpoints-i başa düşsün.

## Ssenari və başlanğıc
Responsive dashboard və ya form feature-ini seç. Synthetic data və public demo istifadə et; production credentials paylaşma.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. Install, environment example və dev command yaz.
2. Component tree, data flow və state dəyişikliklərini göstər.
3. Browser support, breakpoints, empty/error/loading state-i sənədləşdir.
4. Test, lint və build nəticələrini təkrar işə sal.

## Təhvil veriləcək
- README və feature guide.
- Component/data-flow diaqramı və screenshot-lar.
- Test command, known issues və növbəti 3 təklif.

## Qəbul meyarları
- Fresh clone quraşdırma addımı ilə işləyir.
- `.env` nümunəsində dummy dəyərdən başqa secret yoxdur.
- İstifadəçi davranışı və bütün state-lər sənəddə görünür.

## Qiymətləndirmə
Təkrarlana bilən setup 25, texniki izah 25, UI handoff 25, test və limitation 25 bal.

## Təqdim etmə
Repo linki, preview və qısa handoff qeydi əlavə et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Enable another developer to run and modify the feature locally and help a designer understand its states and breakpoints.

## Scenario and starting point
Choose a responsive dashboard or form feature. Use synthetic data and a public demo; share no production credentials.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Document installation, environment example, and dev command.
2. Show the component tree, data flow, and state transitions.
3. Document browser support, breakpoints, and empty/error/loading states.
4. Rerun tests, lint, and build.

## Deliverables
- README and feature guide.
- Component/data-flow diagram and screenshots.
- Test command, known issues, and next three improvements.

## Acceptance criteria
- A fresh clone runs by following the setup steps.
- The .env example contains no secret beyond dummy values.
- User behavior and all important states are documented.

## Evaluation
Reproducible setup 25, technical explanation 25, UI handoff 25, tests/limitations 25 points.

## Submission
Submit the repository link, preview, and short handoff note.

## Estimated time
4-6 hours.$frontend_engineering_3_inst_1$),
  ('frontend-engineering', 8, 4, 8, $frontend_engineering_3_desc_2$[[AZ]]
Müraciət idarəetməsi üçün polished frontend-i API, responsive design və testlərlə tamamla.

[[EN]]
Complete a polished application-management frontend with API integration, responsive design, and tests.$frontend_engineering_3_desc_2$, $frontend_engineering_3_inst_2$[[AZ]]
## Məqsəd
Tələbə müraciət formu və koordinatorun müraciət siyahısını bir-birinə uyğun, təkrar istifadə edilən frontend feature kimi təqdim et.

## Ssenari və başlanğıc
Mock API ilə işlət. Tələbə tərəfi submit statusunu, admin tərəfi filter/detail state-lərini göstərsin; real şəxsi məlumat daxil etmə.

## Alətlər və VS Code/terminal
- VS Code-da repo-nun əsas qovluğunu aç; package.json və lock faylını yoxla. package-lock.json varsa npm ci, lock yoxdursa npm install işlət. pnpm-lock.yaml və ya yarn.lock varsa həmin package manager-dən istifadə et.
- Yeni Next.js + TypeScript layihəsi üçün: npx create-next-app@latest internship-frontend --ts --eslint --app; sonra cd internship-frontend və npm run dev.
- Mövcud layihədə npm run əmri ilə scripts siyahısına bax; uyğun olduqda npm run dev, npm run lint, npm test və npm run build icra et. Olmayan script-i uydurma.
- Ekran ölçülərini brauzerin responsive mode-u ilə yoxla; test hesabından başqa real şəxsi məlumat daxil etmə.

## Addım-addım icra
1. User flow, route və data contract-ı sənədləşdir.
2. Form validation, list filter, pagination və loading/error/empty state qur.
3. Responsive layout və keyboard/screen-reader davranışını yoxla.
4. Unit/UI testləri yaz, performansın bir göstəricisini ölç və sübut olunan yaxşılaşdırmanı tətbiq et.
5. Təmiz mühitdə quraşdırma və build prosesini təsdiqlə.

## Təhvil veriləcək
- İşləyən frontend feature və source repository.
- API mock, testlər və preview screenshot-ları.
- Accessibility/performance check, README və məlum məhdudiyyətlər.

## Qəbul meyarları
- Submit təkrar basıldıqda duplicate yaranmır.
- List və detail state-ləri bir-birinə uyğun gəlir.
- Mobile, error və empty hallar ayrıca yoxlanılıb.

## Qiymətləndirmə
Feature completeness 25, UX/responsive 25, test/a11y 25, kod və handoff 25 bal.

## Təqdim etmə
GitHub repo, preview linki və 5 dəqiqəlik demo və ya hesabat təqdim et.

## Təxmini vaxt
8-12 saat.

[[EN]]
## Objective
Deliver a consistent, reusable frontend feature containing a student application form and a coordinator application list.

## Scenario and starting point
Use a mock API. The student side shows submission status; the admin side shows filter/detail states. Do not use real personal data.

## Tools, VS Code, and terminal
- Open the repository root in VS Code and inspect package.json and its lockfile. If package-lock.json exists, run npm ci; if there is no lockfile, run npm install. Use pnpm or Yarn instead when its lockfile is present.
- To create a new Next.js + TypeScript project: npx create-next-app@latest internship-frontend --ts --eslint --app; then run cd internship-frontend and npm run dev.
- In an existing project, use npm run to inspect available scripts; run npm run dev, npm run lint, npm test, and npm run build only when those scripts exist.
- Check screen sizes in the browser's responsive mode and use no real personal data beyond a test account.

## Step-by-step
1. Document the user flow, routes, and data contract.
2. Build form validation, list filtering, pagination, and loading/error/empty states.
3. Verify responsive layout and keyboard/screen-reader behavior.
4. Add unit/UI tests, capture a performance baseline, and make one justified improvement.
5. Verify setup and build in a fresh environment.

## Deliverables
- Working frontend feature and source repository.
- API mock, tests, and preview screenshots.
- Accessibility/performance check, README, and known limitations.

## Acceptance criteria
- Repeated submission does not create duplicates.
- List and detail states remain consistent.
- Mobile, error, and empty cases are checked separately.

## Evaluation
Feature completeness 25, UX/responsiveness 25, tests/accessibility 25, code/handoff 25 points.

## Submission
Submit the GitHub repository, preview link, and a five-minute demo or report.

## Estimated time
8-12 hours.$frontend_engineering_3_inst_2$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_frontend_engineering_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 2 THEN RAISE EXCEPTION 'frontend-engineering batch 3: expected 2 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_frontend_engineering_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'frontend-engineering batch 3: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_frontend_engineering_3 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 2 THEN RAISE EXCEPTION 'frontend-engineering batch 3: expected 2 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_frontend_engineering_3;
END
$curriculum_frontend_engineering_3$;

DO $curriculum_mobile_development_1$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_mobile_development_1 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_mobile_development_1 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('mobile-development', 1, 1, 1, $mobile_development_1_desc_1$[[AZ]]
Expo əsaslı mobil layihəni qur, cihazda işə sal və başlanğıc quraşdırmanı təkrarlana bilən et.

[[EN]]
Set up an Expo mobile project, run it on a device, and make the initial setup reproducible.$mobile_development_1_desc_1$, $mobile_development_1_inst_1$[[AZ]]
## Məqsəd
Android və ya iOS cihazında açıla bilən, struktur və işə salma addımları sənədləşdirilmiş Expo app yarat.

## Ssenari və başlanğıc
Layihə qovluğu, Node versiyası və Expo Go və ya emulator seç. API key və şəxsi cihaz məlumatı tələb etməyən başlanğıc ekranı qur.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. Expo layihəsi və TypeScript template seçimini izah et.
2. Home screen, app icon placeholder və app config əlavə et.
3. Təmiz clone-dan dependency quraşdırıb app-i başlat.
4. Android cihaz/emulator-da screenshot və startup log yoxla.

## Təhvil veriləcək
- İşlək source repo və package lock.
- Setup README və cihazda açılma sübutu.
- Folder strukturunu və istifadə olunan SDK versiyasını izah edən qeyd.

## Qəbul meyarları
- App təmiz checkout-dan sənədlə işə düşür.
- Secret və real personal data repository-də yoxdur.
- Launch zamanı fatal error və qırıq placeholder yoxdur.

## Qiymətləndirmə
Quraşdırma 30, təkrarlana bilənlik 25, struktur 25, sənədləşmə 20 bal.

## Təqdim etmə
GitHub repo linki və Android/iOS preview screenshot-u göndər.

## Təxmini vaxt
3-5 saat.

[[EN]]
## Objective
Create an Expo app that opens on an Android or iOS device with documented structure and startup steps.

## Scenario and starting point
Choose a project folder, Node version, and Expo Go or emulator. Build a starter screen that needs no API key or personal device data.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Explain the Expo project and TypeScript-template choice.
2. Add a home screen, app-icon placeholder, and app configuration.
3. Install dependencies and start the app from a clean clone.
4. Capture device/emulator proof and check startup logs.

## Deliverables
- Working source repository and package lock.
- Setup README and proof it opens on a device.
- Note explaining folder structure and SDK version.

## Acceptance criteria
- The app starts from a clean checkout by following the documentation.
- No secrets or real personal data are in the repository.
- No fatal startup errors or broken placeholders remain.

## Evaluation
Setup 30, reproducibility 25, structure 25, documentation 20 points.

## Submission
Submit a GitHub repository link and Android/iOS preview screenshot.

## Estimated time
3-5 hours.$mobile_development_1_inst_1$),
  ('mobile-development', 2, 2, 2, $mobile_development_1_desc_2$[[AZ]]
Təcrübə dashboard-unda əsas ekranlar arasında geri düyməsi və deep-link-i nəzərə alan navigation qur.

[[EN]]
Build app navigation for internship screens, accounting for back behavior and deep links.$mobile_development_1_desc_2$, $mobile_development_1_inst_2$[[AZ]]
## Məqsəd
Təcrübə siyahısı, detal, tapşırıq və profil ekranları üçün anlaşılan navigation axını yarat.

## Ssenari və başlanğıc
Expo Router və ya React Navigation-dan birini seç. Login tələb etməyən mock screen-lər qur; seçimini platforma davranışı ilə əsaslandır.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. Route map və tab/stack sərhədlərini çəkmək.
2. List-dən detail-ə task ID ötürmək.
3. Android back, modal dismiss və unknown deep link-i yoxlamaq.
4. Screen title, loading və missing-route vəziyyətlərini əlavə etmək.

## Təhvil veriləcək
- Navigation source və route diagram.
- List → detail → task flow demo.
- Back/deep-link davranışını yoxlayan test və screenshot.

## Qəbul meyarları
- Back düyməsi gözlənilən əvvəlki ekrana qaytarır.
- Missing ID ilə detail ekranı crash etmir.
- Route params-da həssas data daşınmır.

## Qiymətləndirmə
Axın modeli 25, platforma davranışı 25, edge state-lər 25, test/sənəd 25 bal.

## Təqdim etmə
Repo və ekranlar arası demo videosu və ya screenshot ardıcıllığı təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Create clear navigation for internship list, detail, task, and profile screens.

## Scenario and starting point
Choose Expo Router or React Navigation. Use mock screens without login and justify the choice for platform behavior.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Draw the route map and tab/stack boundaries.
2. Pass a task ID from list to detail.
3. Check Android back, modal dismissal, and an unknown deep link.
4. Add screen titles and loading/missing-route states.

## Deliverables
- Navigation source and route diagram.
- Demo of list → detail → task flow.
- Test and screenshot showing back/deep-link behavior.

## Acceptance criteria
- Back returns to the expected previous screen.
- A detail route with a missing ID does not crash.
- Sensitive data is not carried in route params.

## Evaluation
Flow model 25, platform behavior 25, edge states 25, tests/documentation 25 points.

## Submission
Submit the repository and a screen-flow demo video or screenshot sequence.

## Estimated time
4-6 hours.$mobile_development_1_inst_2$),
  ('mobile-development', 3, 3, 3, $mobile_development_1_desc_3$[[AZ]]
Task card, status badge və form sahələrini mobil ekranda təkrar istifadə edilən komponentlərə ayır.

[[EN]]
Create reusable mobile components for task cards, status badges, and form fields.$mobile_development_1_desc_3$, $mobile_development_1_inst_3$[[AZ]]
## Məqsəd
Bir neçə screen-də təkrar işlənən UI hissələrini vahid davranış və accessibility ilə component-lərə ayır.

## Ssenari və başlanğıc
TaskCard, StatusBadge və TextInputField komponentlərini qur. Variantlar: overdue, completed, disabled və validation error.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. Props və variant müqaviləsini yaz.
2. Kiçik ekranda uzun task adı və iri font üçün layout yoxla.
3. Screen-reader label və touch target ölçülərini nəzərə al.
4. Component demo və testlə variantları yoxla.

## Təhvil veriləcək
- Üç reusable component və type-lar.
- Demo screen və ən azı 6 component test.
- İstifadə nümunəsi və görünüş screenshot-u.

## Qəbul meyarları
- Uzun title və böyük font kəsilmədən oxunur.
- Badge statusu yalnız rənglə deyil, mətnlə də bildirir.
- Tap target rahat istifadə edilə bilən ölçüdədir.

## Qiymətləndirmə
Reusable API 25, responsive mobile layout 25, accessibility 25, test/sənəd 25 bal.

## Təqdim etmə
GitHub repo, demo screenshot-u və test nəticəsini əlavə et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Extract repeated UI patterns into reusable components with consistent behavior and accessibility.

## Scenario and starting point
Build TaskCard, StatusBadge, and TextInputField. Include overdue, completed, disabled, and validation-error variants.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Define props and variant contracts.
2. Check long task titles and larger text on a small screen.
3. Account for screen-reader labels and touch-target sizes.
4. Verify variants in a demo screen and tests.

## Deliverables
- Three reusable components and types.
- Demo screen and at least six component tests.
- Usage examples and screenshots.

## Acceptance criteria
- Long titles and larger text remain readable without clipping.
- Badges communicate status with text, not color alone.
- Touch targets are comfortable to use.

## Evaluation
Reusable API 25, responsive mobile layout 25, accessibility 25, tests/documentation 25 points.

## Submission
Submit the GitHub repository, demo screenshot, and test result.

## Estimated time
4-6 hours.$mobile_development_1_inst_3$),
  ('mobile-development', 4, 4, 4, $mobile_development_1_desc_4$[[AZ]]
API-dən tapşırıqları çəkən mobil siyahıda loading, refresh, empty və network error vəziyyətlərini qur.

[[EN]]
Build a mobile task list backed by an API with loading, refresh, empty, and network-error states.$mobile_development_1_desc_4$, $mobile_development_1_inst_4$[[AZ]]
## Məqsəd
Tələbənin təcrübə tapşırıqlarını API-dən təhlükəsiz yükləyib əlçatan siyahıda görməsini təmin et.

## Ssenari və başlanğıc
Mock API task title, due date və status qaytarsın. Response gecikə, boş ola və ya 500 verə bilər.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. API response üçün TypeScript model və adapter yaz.
2. Loading indicator, pull-to-refresh və retry qur.
3. Empty və error halları üçün bir-birindən fərqli, aydın mətn ver.
4. Unmount sonrası state update və təkrar request riskini yoxla.

## Təhvil veriləcək
- API-backed task list screen.
- Loading/success/empty/error screenshot-ları.
- Mock API ilə ən azı 5 test.

## Qəbul meyarları
- Network xətası boş nəticə kimi təqdim edilmir.
- Refresh zamanı mövcud data istifadəyə yararlı qalır.
- Stale request nəticəsi yeni nəticəni əvəz etmir.

## Qiymətləndirmə
Data contract 20, screen state-ləri 30, refresh/retry 25, test və accessibility 25 bal.

## Təqdim etmə
Repo linki, qısa ekran videosu və test output-u göndər.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Allow students to safely load internship tasks from an API and view them in an accessible list.

## Scenario and starting point
The mock API returns task title, due date, and status. Responses can be delayed, empty, or return a 500 error.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Define a TypeScript response model and adapter.
2. Add a loading indicator, pull-to-refresh, and retry.
3. Use clear, distinct text for empty and error states.
4. Check unmounted state updates and duplicate-request risks.

## Deliverables
- API-backed task-list screen.
- Loading/success/empty/error screenshots.
- At least five tests using a mocked API.

## Acceptance criteria
- A network error is not presented as an empty result.
- Existing data remains usable while refreshing.
- A stale request cannot overwrite a newer result.

## Evaluation
Data contract 20, screen states 30, refresh/retry 25, tests/accessibility 25 points.

## Submission
Submit the repository link, short screen video, and test output.

## Estimated time
5-7 hours.$mobile_development_1_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_mobile_development_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'mobile-development batch 1: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_mobile_development_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'mobile-development batch 1: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_mobile_development_1 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'mobile-development batch 1: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_mobile_development_1;
END
$curriculum_mobile_development_1$;

DO $curriculum_mobile_development_2$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_mobile_development_2 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_mobile_development_2 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('mobile-development', 5, 5, 5, $mobile_development_2_desc_1$[[AZ]]
Tapşırıq siyahısına status filter-i və yerli axtarış əlavə et, filter dəyişməsini aydın göstər.

[[EN]]
Add status filters and local search to the task list with clear filter-state feedback.$mobile_development_2_desc_1$, $mobile_development_2_inst_1$[[AZ]]
## Məqsəd
Tapşırıqlar çoxaldıqda tələbənin lazım olan işi tez tapması üçün search və filter qur.

## Ssenari və başlanğıc
Ən azı 30 mock task, status, week və title field-ləri ilə istifadə et. Search case-insensitive olsun.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. Filter chip-ləri və search input-u dizayn et.
2. Search və status/week filter-lərinin birlikdə işləməsini təmin et.
3. Clear-all və no-match vəziyyəti əlavə et.
4. Klaviatura ilə idarəetməni, təmizləmə düyməsini və screen reader üçün status bildirişini yoxla.

## Təhvil veriləcək
- Filter/search component və screen.
- 6 filter combination test.
- Empty-result və filter-active screenshot-ları.

## Qəbul meyarları
- Search title üzərində gözlənilən uyğunluğu verir.
- Filter reset ediləndə bütün task-lar qayıdır.
- Aktiv filter vəziyyəti istifadəçiyə görünür və silinə bilir.

## Qiymətləndirmə
Filter logic 30, usability 25, accessibility 20, testlər 25 bal.

## Təqdim etmə
Repo, demo screenshot-u və test output-u təqdim et.

## Təxmini vaxt
3-5 saat.

[[EN]]
## Objective
Help students find a task quickly as the list grows by adding search and filters.

## Scenario and starting point
Use at least 30 mock tasks with status, week, and title fields. Search should be case-insensitive.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Design filter chips and a search input.
2. Make search work together with status/week filters.
3. Add clear-all and no-match states.
4. Check keyboard behavior, clear button, and screen-reader status updates.

## Deliverables
- Filter/search component and screen.
- Six filter-combination tests.
- Screenshots of no-results and active-filter states.

## Acceptance criteria
- Search returns expected title matches.
- Reset restores the full task list.
- Active filters are visible and removable.

## Evaluation
Filter logic 30, usability 25, accessibility 20, tests 25 points.

## Submission
Submit the repository, demo screenshot, and test output.

## Estimated time
3-5 hours.$mobile_development_2_inst_1$),
  ('mobile-development', 6, 6, 6, $mobile_development_2_desc_2$[[AZ]]
İstifadəçi seçimini yalnız həssas olmayan məlumatlar üçün lokal storage-da saxla və migration qərarını yaz.

[[EN]]
Persist non-sensitive user preferences locally and document the storage/migration choice.$mobile_development_2_desc_2$, $mobile_development_2_inst_2$[[AZ]]
## Məqsəd
Task filter-i və theme preference-i app yenidən açıldıqda bərpa et, amma token və private data-nı local storage-a yazma.

## Ssenari və başlanğıc
Platformaya uyğun storage seç və seçimin riskini izah et. Saxlanacaq məlumat yalnız status filter, preferred theme və schema version olsun.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. Persistent və memory-only data sərhədini yaz.
2. Storage adapter-i, versiya sahəsini və ilkin dəyəri əlavə et.
3. Korlanmış və ya köhnə məlumatı təhlükəsiz ilkin vəziyyətə qaytar.
4. Save/load/reset və yenilənmə ssenarilərini test et.

## Təhvil veriləcək
- Storage abstraction və istifadə nümunəsi.
- Reset və migration testləri.
- Threat/privacy qeydi: nəyin saxlanmadığı açıq göstərilsin.

## Qəbul meyarları
- Access token, parol və şəxsi müraciət mətni saxlanmır.
- Köhnə/corrupt state app-i crash etmir.
- User seçimi təmizləmə funksiyası ilə silinə bilir.

## Qiymətləndirmə
Storage seçimi 25, təhlükəsiz sərhəd 30, migration 20, test 25 bal.

## Təqdim etmə
Repo və local storage davranışının ekran videosunu təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Restore task filters and theme preference after restart without storing tokens or private data locally.

## Scenario and starting point
Choose platform-appropriate storage and explain the risk. Persist only status filter, preferred theme, and schema version.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Define the boundary between persistent and memory-only data.
2. Add a storage adapter, version field, and defaults.
3. Recover corrupt or old data to safe defaults.
4. Test save, load, reset, and migration.

## Deliverables
- Storage abstraction and usage example.
- Reset and migration tests.
- Threat/privacy note stating what is not stored.

## Acceptance criteria
- No access token, password, or private application text is stored.
- Old/corrupt state does not crash the app.
- Users can clear the saved preference.

## Evaluation
Storage choice 25, security boundary 30, migration 20, tests 25 points.

## Submission
Submit the repository and a short screen video of storage behavior.

## Estimated time
4-6 hours.$mobile_development_2_inst_2$),
  ('mobile-development', 7, 7, 7, $mobile_development_2_desc_3$[[AZ]]
Müraciət formunda mobil klaviatura, field validation və submit zamanı səhv bərpasını həll et.

[[EN]]
Handle mobile keyboard behavior, field validation, and recovery from submission errors.$mobile_development_2_desc_3$, $mobile_development_2_inst_3$[[AZ]]
## Məqsəd
İstifadəçi telefonunda motivasiya və link məlumatını rahat daxil edib səhv olduqda itirməsin.

## Ssenari və başlanğıc
Mock submit endpoint qur. Required text, optional URL və maximum length qaydasını müəyyən et.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. Hər sahəyə label, input type və autocomplete hint seç.
2. Inline validation və server field error göstər.
3. Keyboard açıqkən form scroll və submit button əlçatan qalmasını yoxla.
4. Network failure sonrası text-i saxla; double submit-i blokla.

## Təhvil veriləcək
- Form screen və validation model.
- Valid/invalid/server error/offline submit testləri.
- Android və ya iOS keyboard behavior screenshot-u.

## Qəbul meyarları
- Required error sahəyə və screen reader-ə bağlıdır.
- URL yanlış olduqda səbəb aydın göstərilir.
- Failed submission-dan sonra input silinmir.

## Qiymətləndirmə
Form usability 25, validation 25, keyboard behavior 25, error recovery/test 25 bal.

## Təqdim etmə
Repo, ekran sübutu və test output-u təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Let users enter motivation and links comfortably on a phone and recover without losing input.

## Scenario and starting point
Use a mocked submit endpoint. Define required text, optional URL, and maximum-length rules.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Choose a label, input type, and autocomplete hint for each field.
2. Show inline validation and server field errors.
3. Verify the form scrolls and submit button stays reachable when the keyboard is open.
4. Preserve text after network failure and prevent double submit.

## Deliverables
- Form screen and validation model.
- Tests for valid, invalid, server-error, and offline submissions.
- Android or iOS keyboard-behavior screenshot.

## Acceptance criteria
- Required errors are associated with the field and screen reader.
- Invalid URLs show a clear reason.
- Inputs remain after failed submission.

## Evaluation
Form usability 25, validation 25, keyboard behavior 25, error recovery/tests 25 points.

## Submission
Submit the repository, screen evidence, and test output.

## Estimated time
4-6 hours.$mobile_development_2_inst_3$),
  ('mobile-development', 8, 8, 8, $mobile_development_2_desc_4$[[AZ]]
Şəbəkə itəndə cache edilmiş tapşırıqları oxunaqlı saxla və sync vəziyyətini dürüst göstər.

[[EN]]
Keep cached tasks readable offline and report synchronization state honestly.$mobile_development_2_desc_4$, $mobile_development_2_inst_4$[[AZ]]
## Məqsəd
Müvəqqəti bağlantı kəsiləndə tapşırıq siyahısını göstər, son yenilənmə vaxtını bildir və stale data-nı yeni kimi təqdim etmə.

## Ssenari və başlanğıc
Task 4/6 data layer-ini istifadə et. Oxuma üçün cache və yenilənmə üçün mock network status qur; offline halda təhlükəli write queue yaratma.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. Cache source, freshness müddəti və refresh qaydasını müəyyən et.
2. Offline banner və last-synced vaxtı əlavə et.
3. Yenidən qoşulanda stale cache-i yenilə.
4. Cache boş, outdated və sync failure ssenarilərini test et.

## Təhvil veriləcək
- Offline-aware repository/service layer.
- Online/offline/cache-empty testləri və 3 ekran görüntüsü.
- Data freshness, privacy və retry qeydi.

## Qəbul meyarları
- Cache data stale olduqda bu açıq bildirilir.
- Offline status write-ın uğurlu olduğunu iddia etmir.
- Sync bərpa olunanda duplicate task və itki yaranmır.

## Qiymətləndirmə
Offline states 25, data consistency 30, privacy/retry 20, test/sənəd 25 bal.

## Təqdim etmə
GitHub repo, test output-u və ekran qeydlərini əlavə et.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Show task lists during temporary connectivity loss, display the last update time, and never present stale data as current.

## Scenario and starting point
Reuse the data layer from Task 4/6. Add a read cache and mocked network state; do not queue risky writes while offline.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Define cache source, freshness duration, and refresh behavior.
2. Add an offline banner and last-synced time.
3. Refresh stale cached data when connectivity returns.
4. Test empty-cache, outdated-cache, and sync-failure scenarios.

## Deliverables
- Offline-aware repository/service layer.
- Online/offline/cache-empty tests and three screenshots.
- Note on freshness, privacy, and retries.

## Acceptance criteria
- Stale cached data is clearly identified.
- Offline state never claims a write succeeded.
- Reconnection causes no duplicate tasks or data loss.

## Evaluation
Offline states 25, data consistency 30, privacy/retry 20, tests/documentation 25 points.

## Submission
Submit the GitHub repository, test output, and screen notes.

## Estimated time
5-7 hours.$mobile_development_2_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_mobile_development_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'mobile-development batch 2: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_mobile_development_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'mobile-development batch 2: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_mobile_development_2 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'mobile-development batch 2: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_mobile_development_2;
END
$curriculum_mobile_development_2$;

DO $curriculum_mobile_development_3$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_mobile_development_3 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_mobile_development_3 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('mobile-development', 8, 9, 8, $mobile_development_3_desc_1$[[AZ]]
Əsas mobil istifadə axınını real cihaz ölçüləri, əlçatanlıq və performans baxımından yoxla.

[[EN]]
Review the main mobile flow for device sizes, accessibility, and performance.$mobile_development_3_desc_1$, $mobile_development_3_inst_1$[[AZ]]
## Məqsəd
Tələbənin tapşırığı tapması, detalı oxuması və həll linkini təqdim etməsi axınında maneələri aşkarlayıb prioritetləşdir.

## Ssenari və başlanğıc
Öz app-in və ya local demo-nun ən azı 3 ölçüdə/simulyatorda istifadə testini apar. Synthetic account istifadə et.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. 3 task-based usability scenario yaz.
2. Font scale, touch target, orientation və slow network-i yoxla.
3. Crash, layout clip, keyboard overlap və a11y focus problemlərini qeyd et.
4. Top 3 problemi impact/effort üzrə sırala və ən azı birini düzəlt.

## Təhvil veriləcək
- Test script və cihaz/OS matrisi.
- Screenshot/video sübutu və ən azı 5 finding.
- Bir düzəliş diff-i və retest nəticəsi.

## Qəbul meyarları
- Finding-lər real task flow addımına bağlanır.
- Ekran görüntülərində şəxsi məlumat yoxdur.
- Fix sonrası eyni ssenari təkrar yoxlanır.

## Qiymətləndirmə
Test dizaynı 25, finding evidence 25, prioritet 20, retest/fix 30 bal.

## Təqdim etmə
Repo və test hesabatını təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Find and prioritize obstacles in the student flow for finding a task, reading details, and submitting a solution link.

## Scenario and starting point
Test your app or local demo on at least three device sizes/emulators. Use a synthetic account.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Write three task-based usability scenarios.
2. Check font scaling, touch targets, orientation, and slow networks.
3. Record crashes, clipped layouts, keyboard overlap, and accessibility-focus issues.
4. Rank the top three by impact/effort and fix at least one.

## Deliverables
- Test script and device/OS matrix.
- Screenshot/video evidence and at least five findings.
- One fix diff and retest results.

## Acceptance criteria
- Findings relate to a real step in the task flow.
- Screenshots contain no personal data.
- The same scenario is retested after the fix.

## Evaluation
Test design 25, finding evidence 25, prioritization 20, retest/fix 30 points.

## Submission
Submit the repository and test report.

## Estimated time
4-6 hours.$mobile_development_3_inst_1$),
  ('mobile-development', 8, 10, 8, $mobile_development_3_desc_2$[[AZ]]
Tapşırıqları idarə edən tamamlanmış mobil app-i API, offline davranış, test və handoff sənədi ilə təqdim et.

[[EN]]
Deliver a complete task-management mobile app with API, offline behavior, tests, and handoff documentation.$mobile_development_3_desc_2$, $mobile_development_3_inst_2$[[AZ]]
## Məqsəd
Tələbənin tapşırığı gözdən keçirib filter etməsi, detalı oxuması və həllini təqdim etməsi üçün işlək mobil təcrübə qur.

## Ssenari və başlanğıc
Əvvəlki task-lardakı screen və component-ləri birləşdir. Mock API və synthetic account istifadə et; production credentials və real tələbə datası yoxdur.

## Alətlər və VS Code/terminal
- VS Code və Node.js LTS istifadə et. Mövcud Expo repo-sunda package-lock.json varsa npm ci; yoxdursa npm install. Mövcud olmayan paketi kor-koranə yenidən quraşdırma.
- Sıfırdan TypeScript Expo app yaratmaq üçün: npx create-expo-app@latest mobile-practice --template blank-typescript; sonra cd mobile-practice və npx expo start.
- Expo Go ilə telefonda açmaq mümkündür; emulator üçün Android Studio tələb oluna bilər. Layihənin scripts sahəsi varsa, npm run əmri ilə yoxla; test mövcuddursa npm test işlət.
- API açarı və şəxsi cihaz məlumatını app source-a yazma; sintetik test hesablarından istifadə et.

## Addım-addım icra
1. Navigation, task list/detail, search/filter və submission flow tamamla.
2. Loading, empty, error, offline/cache və form validation state-lərini əlavə et.
3. Keyboard, screen reader, large font və Android back davranışını yoxla.
4. Unit/UI test, build check və clean-device smoke test işlət.
5. Setup, limitation və recovery addımlarını yaz.

## Təhvil veriləcək
- Expo source, setup README və mock API.
- Test nəticələri və 5 əsas screen-in screenshot-u.
- Accessibility/offline yoxlama siyahısı və known limitations.

## Qəbul meyarları
- Əsas axın başlanğıcdan həll linkinin mock submit-inə qədər işləyir.
- Offline və server error state-ləri bir-birindən seçilir.
- Clean clone quraşdırılır və testlər sənədə əsasən işləyir.

## Qiymətləndirmə
Feature completeness 25, UX/accessibility 25, data/error behavior 25, test/handoff 25 bal.

## Təqdim etmə
GitHub repo, emulator/device demo və qısa handoff qeydi əlavə et.

## Təxmini vaxt
8-12 saat.

[[EN]]
## Objective
Build a working mobile experience for students to browse/filter tasks, read details, and submit a solution.

## Scenario and starting point
Combine screens and components from earlier tasks. Use a mock API and synthetic account; include no production credentials or real student data.

## Tools, VS Code, and terminal
- Use VS Code and Node.js LTS. In an existing Expo repository, run npm ci when package-lock.json exists; otherwise run npm install. Do not reinstall packages blindly.
- To create a new TypeScript Expo app: npx create-expo-app@latest mobile-practice --template blank-typescript; then run cd mobile-practice and npx expo start.
- Expo Go can open the app on a phone; Android Studio may be needed for an emulator. Use npm run to inspect project scripts and npm test only if the test script exists.
- Do not put API keys or private device data in app source; use synthetic test accounts.

## Step-by-step
1. Complete navigation, task list/detail, search/filter, and submission flow.
2. Add loading, empty, error, offline/cache, and form-validation states.
3. Check keyboard, screen reader, larger fonts, and Android back behavior.
4. Run unit/UI tests, build checks, and a clean-device smoke test.
5. Document setup, limitations, and recovery steps.

## Deliverables
- Expo source, setup README, and mock API.
- Test results and screenshots of five key screens.
- Accessibility/offline checklist and known limitations.

## Acceptance criteria
- The primary flow works from launch through mock solution submission.
- Offline and server-error states are distinguishable.
- A clean clone installs and its tests run by following the documentation.

## Evaluation
Feature completeness 25, UX/accessibility 25, data/error behavior 25, tests/handoff 25 points.

## Submission
Submit the GitHub repository, emulator/device demo, and short handoff note.

## Estimated time
8-12 hours.$mobile_development_3_inst_2$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_mobile_development_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 2 THEN RAISE EXCEPTION 'mobile-development batch 3: expected 2 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_mobile_development_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'mobile-development batch 3: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_mobile_development_3 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 2 THEN RAISE EXCEPTION 'mobile-development batch 3: expected 2 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_mobile_development_3;
END
$curriculum_mobile_development_3$;

DO $curriculum_ui_ux_design_1$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_ui_ux_design_1 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_ui_ux_design_1 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('ui-ux-design', 1, 1, 1, $ui_ux_design_1_desc_1$[[AZ]]
İntern portalında tələbələrin tapşırıq axtarışı və təhvil vermə ehtiyacını öyrənmək üçün müsahibə planı hazırla.

[[EN]]
Prepare an interview plan to understand how students find and submit tasks in an intern portal.$ui_ux_design_1_desc_1$, $ui_ux_design_1_inst_1$[[AZ]]
## Məqsəd
Fərziyyələri yoxlayan, yönləndirməyən müsahibə sualları ilə tələbələrin real iş üsulunu və çətinliklərini öyrən.

## Ssenari və başlanğıc
Mövzu: tələbə tapşırığı tapır, tələbi anlayır, vaxtını planlayır və həll linkini təqdim edir. İştirakçı tapılmırsa, müsahibə simulyasiyasını açıq şəkildə qeyd et.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Tədqiqat sualı, hədəf istifadəçi və scope-u yaz.
2. 8-10 açıq sual və 3 follow-up prompt hazırla.
3. Razılıq, anonim qeyd və məlumatın saxlanması qaydasını əlavə et.
4. 20 dəqiqəlik pilot et və sualları leading bias-a görə yenilə.

## Təhvil veriləcək
- Interview guide, consent script və participant screener.
- Pilot qeydi və dəyişdirilmiş suallar.
- Fərziyyələr və tədqiqat məhdudiyyətləri.

## Qəbul meyarları
- Sual istifadəçiyə düzgün cavabı təlqin etmir.
- Lazımsız şəxsi və həssas məlumat toplanmır.
- Real müsahibə və simulyasiya bir-birindən açıq fərqlənir.

## Qiymətləndirmə
Tədqiqat fokusu 25, sual keyfiyyəti 30, etika/məxfilik 25, pilot və təkmilləşdirmə 20 bal.

## Təqdim etmə
Guide və pilot xülasəsini PDF və ya repo-da təqdim et.

## Təxmini vaxt
3-4 saat.

[[EN]]
## Objective
Learn how students actually work and where they struggle using non-leading interview questions.

## Scenario and starting point
Topic: students find a task, understand requirements, plan time, and submit a solution link. If no participant is available, label a simulated interview clearly.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. State the research question, target user, and scope.
2. Prepare eight to ten open questions and three follow-up prompts.
3. Add consent, anonymous-note, and data-retention rules.
4. Pilot a 20-minute session and revise leading or biased questions.

## Deliverables
- Interview guide, consent script, and participant screener.
- Pilot notes and revised questions.
- Assumptions and research limitations.

## Acceptance criteria
- Questions do not lead participants toward a preferred answer.
- No unnecessary personal or sensitive data is collected.
- Real interviews and simulations are clearly distinguished.

## Evaluation
Research focus 25, question quality 30, ethics/privacy 25, pilot and iteration 20 points.

## Submission
Submit the guide and pilot summary as PDF or in a repository.

## Estimated time
3-4 hours.$ui_ux_design_1_inst_1$),
  ('ui-ux-design', 2, 2, 2, $ui_ux_design_1_desc_2$[[AZ]]
Müsahibə tapıntılarından tapşırıq tapma və təqdim etmə üçün əsas user flow və edge case-lər qur.

[[EN]]
Turn interview findings into a primary task-discovery/submission user flow and edge cases.$ui_ux_design_1_desc_2$, $ui_ux_design_1_inst_2$[[AZ]]
## Məqsəd
Tələbənin dashboard-dan uyğun tapşırığa keçib həllini təqdim etməsini addım-addım modelləşdir.

## Ssenari və başlanğıc
Task 1 tapıntılarını istifadə et və ya fərziyyələri qeyd et. Happy path ilə yanaşı tapşırıq bağlıdır, deadline keçib və submit uğursuzdur hallarını daxil et.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. User goal, entry point və success state yaz.
2. Hər addımda istifadəçi seçimi və sistem cavabını göstər.
3. Decision point və error/recovery branch əlavə et.
4. Flow-u ən azı bir iştirakçıya və ya peer-ə yoxlat.

## Təhvil veriləcək
- User-flow diagram və ekran siyahısı.
- 3 edge-case axını və əsas ehtimallar.
- Müsahibə tapıntısından flow qərarına traceability qeydi.

## Qəbul meyarları
- Hər path başlanğıc və son vəziyyətə malikdir.
- Xəta zamanı istifadəçi çıxılmaz vəziyyətdə qalmır.
- System response istifadəçinin növbəti addımını aydınlaşdırır.

## Qiymətləndirmə
Axın tamlığı 30, edge-case-lər 25, recovery 25, sübut/izah 20 bal.

## Təqdim etmə
Diaqram linkini və qısa qərar izahını göndər.

## Təxmini vaxt
3-5 saat.

[[EN]]
## Objective
Model how a student moves from the dashboard to a relevant task and submits a solution.

## Scenario and starting point
Use Task 1 findings or label your assumptions. Include the happy path and cases where a task is closed, overdue, or submission fails.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. State the user goal, entry point, and success state.
2. Show the user's choice and system response at each step.
3. Add decision points and error/recovery branches.
4. Review the flow with at least one participant or peer.

## Deliverables
- User-flow diagram and screen list.
- Three edge-case flows and key assumptions.
- Traceability note linking research findings to flow decisions.

## Acceptance criteria
- Every path has a start and end state.
- Errors do not leave the user at a dead end.
- System responses clarify the user's next step.

## Evaluation
Flow completeness 30, edge cases 25, recovery 25, evidence/rationale 20 points.

## Submission
Submit the diagram link and short design rationale.

## Estimated time
3-5 hours.$ui_ux_design_1_inst_2$),
  ('ui-ux-design', 3, 3, 3, $ui_ux_design_1_desc_3$[[AZ]]
Dashboard, tapşırıq detalı və submit axını üçün low-fidelity wireframe və layout qərarları hazırla.

[[EN]]
Create low-fidelity wireframes for the dashboard, task detail, and submission flow.$ui_ux_design_1_desc_3$, $ui_ux_design_1_inst_3$[[AZ]]
## Məqsəd
Vizual ciladan əvvəl əsas məzmun iyerarxiyasını, naviqasiyanı və əsas hərəkətləri kağızda/prototipdə yoxla.

## Ssenari və başlanğıc
User flow-dakı ekranları əhatə et. Ən azı dashboard, task detail, submit və submit error state çək.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Ekranın məqsədini və birincil CTA-nı qeyd et.
2. Sidebar/tab, status və deadline məlumatını iyerarxiyalaşdır.
3. Desktop və mobil wireframe hazırla.
4. Peer walkthrough zamanı 3 istifadəçi tapşırığını ver və ilişmə nöqtələrini qeyd et.

## Təhvil veriləcək
- Ən azı 4 wireframe ekranı və mobil variant.
- Component/section label-ləri və CTA izahı.
- Peer feedback və ən azı 3 iterasiya.

## Qəbul meyarları
- İstifadəçi növbəti addımı vizual olaraq tapır.
- Error state-də form məlumatı və recovery action görünür.
- Wireframe UI bəzəyi deyil, struktur qərarı yoxlayır.

## Qiymətləndirmə
Məlumat iyerarxiyası 30, axın uyğunluğu 25, mobil quruluş 20, iterasiya 25 bal.

## Təqdim etmə
Figma/Penpot linki və ya PDF export-u göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Validate content hierarchy, navigation, and key actions before polishing the visual style.

## Scenario and starting point
Cover the screens from the user flow. Sketch at least dashboard, task detail, submission, and submission-error states.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. State each screen's purpose and primary CTA.
2. Prioritize navigation, status, and deadline information.
3. Create desktop and mobile wireframes.
4. Run a peer walkthrough with three user tasks and record friction points.

## Deliverables
- At least four wireframe screens and a mobile variant.
- Component/section labels and CTA rationale.
- Peer feedback and at least three iterations.

## Acceptance criteria
- The next action is visually discoverable.
- Error state preserves form context and shows a recovery action.
- Wireframes test structure, not decorative styling.

## Evaluation
Information hierarchy 30, flow alignment 25, mobile structure 20, iteration 25 points.

## Submission
Submit a Figma/Penpot link or PDF export.

## Estimated time
4-6 hours.$ui_ux_design_1_inst_3$),
  ('ui-ux-design', 4, 4, 4, $ui_ux_design_1_desc_4$[[AZ]]
Wireframe-i real məzmun, visual hierarchy və responsive variantları olan high-fidelity ekranlara çevir.

[[EN]]
Turn wireframes into high-fidelity screens with real content, visual hierarchy, and responsive variants.$ui_ux_design_1_desc_4$, $ui_ux_design_1_inst_4$[[AZ]]
## Məqsəd
Tələbənin tapşırığın məqsədini, təxmini vaxtını, çətinliyini və təhvil formatını bir baxışda anlaya biləcəyi ekran yarat.

## Ssenari və başlanğıc
Task detail, dashboard və submit screen üçün wireframe-i əsas götür. Eyni content və status label-lər bütün ekranlarda ardıcıl olsun.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Grid, spacing, typography və color scale müəyyən et.
2. Əsas tapşırıq məlumatını, ətraflı təlimatı və təqdimetmə CTA-sını vizual olaraq ayır.
3. Desktop, dar mobil ekran və boş/xəta vəziyyətlərinin variantlarını hazırla.
4. Contrast, focus indicator və mətn ölçüsünü yoxla.

## Təhvil veriləcək
- Ən azı 3 high-fidelity ekran və 2 responsive state.
- Rəng/font/spacing qərarlarını izah edən note.
- Əsas component və status variantları.

## Qəbul meyarları
- Məcburi və optional məlumat fərqlənir.
- Tələbin özü dekorativ elementlərdən daha nəzərəçarpandır.
- Contrast və mətn ölçüsü oxunaqlı və yoxlanılandır.

## Qiymətləndirmə
Visual hierarchy 25, content clarity 25, responsive states 25, consistency/a11y 25 bal.

## Təqdim etmə
Design file linki və ekran görüntülərini göndər.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Design a task-detail screen where students can quickly understand the goal, estimated effort, difficulty, and submission format.

## Scenario and starting point
Use the dashboard, task-detail, and submission wireframes. Keep content and status labels consistent across screens.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. Define grid, spacing, typography, and color scales.
2. Separate task metadata, detailed instructions, and submission CTA.
3. Create desktop, narrow-mobile, and empty/error variants.
4. Check contrast, focus indicators, and readable text sizes.

## Deliverables
- At least three high-fidelity screens and two responsive states.
- Note explaining color/font/spacing decisions.
- Core components and status variants.

## Acceptance criteria
- Required and optional information are distinguishable.
- Instructions are more prominent than decorative elements.
- Contrast and text size are readable and verifiable.

## Evaluation
Visual hierarchy 25, content clarity 25, responsive states 25, consistency/accessibility 25 points.

## Submission
Submit the design-file link and screenshots.

## Estimated time
5-7 hours.$ui_ux_design_1_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_ui_ux_design_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'ui-ux-design batch 1: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_ui_ux_design_1 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'ui-ux-design batch 1: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_ui_ux_design_1 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'ui-ux-design batch 1: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_ui_ux_design_1;
END
$curriculum_ui_ux_design_1$;

DO $curriculum_ui_ux_design_2$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_ui_ux_design_2 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_ui_ux_design_2 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('ui-ux-design', 5, 5, 5, $ui_ux_design_2_desc_1$[[AZ]]
Rəng, type, spacing və əsas component variantlarını token-larla ifadə edən kiçik design system qur.

[[EN]]
Build a small design system with tokens for color, type, spacing, and component variants.$ui_ux_design_2_desc_1$, $ui_ux_design_2_inst_1$[[AZ]]
## Məqsəd
Tapşırıq portalında UI-nın ardıcıl görünməsini və gələcək dəyişikliklərin mərkəzdən idarə olunmasını təmin et.

## Ssenari və başlanğıc
Task detail, status badge, button və form field nümunələrini seç. Token-lar semantic məqsəd daşısın, yalnız palette adı olmasın.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Brand/semantic color, typography, spacing və radius token müəyyən et.
2. Button, badge, input və card üçün 2–3 variant müəyyən et.
3. Kontrastı yoxla, token-ların açıq və tünd fonlarda istifadəsini təsdiqlə.
4. Component usage üçün istifadə et/etmə nümunələri və yeniləmə qaydasını yaz.

## Təhvil veriləcək
- Token sheet və component inventory.
- Ən azı 5 component variantı olan library.
- Do/don't nümunəsi və contrast nəticəsi.

## Qəbul meyarları
- Eyni semantic state bütün component-lərdə eyni məna daşıyır.
- Token dəyişəndə əlaqəli preview-lər ardıcıl yenilənir.
- Rəng istifadəsi accessibility minimumlarına uyğun yoxlanıb.

## Qiymətləndirmə
Token modeli 25, komponent ardıcıllığı 30, accessibility 25, sənəd 20 bal.

## Təqdim etmə
Figma/Penpot library linki və design-system qısa guide təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Keep the task portal visually consistent and make future changes centrally manageable.

## Scenario and starting point
Choose task detail, status badge, button, and form-field examples. Tokens should communicate semantic purpose, not just palette names.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. Define brand/semantic colors, typography, spacing, and radius tokens.
2. Specify two or three variants for buttons, badges, inputs, and cards.
3. Check contrast and verify use on light/dark backgrounds.
4. Write component do/don't examples and update rules.

## Deliverables
- Token sheet and component inventory.
- Library with at least five component variants.
- Do/don't example and contrast results.

## Acceptance criteria
- The same semantic state means the same thing across components.
- Changing a token updates related previews consistently.
- Color use is checked against accessibility requirements.

## Evaluation
Token model 25, component consistency 30, accessibility 25, documentation 20 points.

## Submission
Submit the Figma/Penpot library link and short design-system guide.

## Estimated time
4-6 hours.$ui_ux_design_2_inst_1$),
  ('ui-ux-design', 6, 6, 6, $ui_ux_design_2_desc_2$[[AZ]]
Tapşırıq oxuma, status dəyişməsi və submit interaction-larını clickable prototype-da sına.

[[EN]]
Test task-reading, status-change, and submission interactions in a clickable prototype.$ui_ux_design_2_desc_2$, $ui_ux_design_2_inst_2$[[AZ]]
## Məqsəd
Static ekranların real istifadə axınında anlaşılmasını yoxla və qarşılıqlı əlaqənin boş qaldığı yerləri tap.

## Ssenari və başlanğıc
Dashboard-dan tapşırıq aç, instructions oxu, status filter et və solution linki təqdim et. Uğur və error path-lərini prototipə daxil et.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Tap targets, tab order və overlay davranışını qur.
2. Form submit, loading və validation feedback interaction-u bağla.
3. Back, cancel və retry path-lərini əlavə et.
4. Peer test zamanı click-lərin gözlənilən nəticə verib-vermədiyini qeyd et.

## Təhvil veriləcək
- Clickable prototype və 3 task scenario.
- Hər scenario üçün success/failure state screenshot-u.
- Interaction qərarlarını və məlum məhdudiyyətləri yaz.

## Qəbul meyarları
- Bütün primary CTA-lar işləyən növbəti addıma aparır.
- Loading və error state-ləri prototipdə görünür.
- İstifadəçi ilişəndə geri dönmək və yenidən cəhd etmək mümkündür.

## Qiymətləndirmə
Interaction coverage 30, flow clarity 25, error recovery 25, prototype/test 20 bal.

## Təqdim etmə
Share edilən prototype linkini və test qeydlərini təqdim et.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Validate that static screens work as a real flow and find missing or unclear interactions.

## Scenario and starting point
Open a task from the dashboard, read instructions, filter by status, and submit a solution link. Include success and error paths.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. Define tap targets, tab order, and overlay behavior.
2. Connect form submission, loading, and validation feedback.
3. Add back, cancel, and retry paths.
4. Record whether prototype clicks produce the expected result during a peer test.

## Deliverables
- Clickable prototype and three task scenarios.
- Success/failure screenshots for each scenario.
- Note explaining interaction choices and known limitations.

## Acceptance criteria
- Every primary CTA leads to a working next step.
- Loading and error states appear in the prototype.
- Users can go back and retry when stuck.

## Evaluation
Interaction coverage 30, flow clarity 25, error recovery 25, prototype/testing 20 points.

## Submission
Submit a shareable prototype link and test notes.

## Estimated time
4-6 hours.$ui_ux_design_2_inst_2$),
  ('ui-ux-design', 7, 7, 7, $ui_ux_design_2_desc_3$[[AZ]]
Task detail prototipində keyboard, screen reader, kontrast və mətn böyütmə baryerlərini audit et.

[[EN]]
Audit keyboard, screen-reader, contrast, and text-scaling barriers in a task-detail prototype.$ui_ux_design_2_desc_3$, $ui_ux_design_2_inst_3$[[AZ]]
## Məqsəd
Fərqli istifadə ehtiyaclarının tapşırıq tələblərini tapıb təqdim etməsinə mane olmadığını yoxla.

## Ssenari və başlanğıc
Task list/detail və submit prototipinə bax. WCAG 2.2 AA-nı yoxlama siyahısı kimi istifadə et; audit nəticəsini avtomatik uyğunluq sertifikatı kimi təqdim etmə.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Keyboard focus order və visible indicator-ı yoxla.
2. Contrast, 200% text zoom, status label və error association-ı ölç.
3. Screen-reader ilə page heading və CTA-nın adını sına.
4. Tapıntını WCAG success criterion, təsir və düzəlişlə bağla.

## Təhvil veriləcək
- Accessibility checklist və evidence screenshot-ları.
- Ən azı 5 finding, severity və düzəliş təklifi.
- Bir yüksək təsirli problemi düzəldən yenilənmiş prototip.

## Qəbul meyarları
- Tapıntılar konkret element və istifadəçi təsirini göstərir.
- Təkcə avtomatik scan-a etibar edilmir.
- Rəngdən asılı olmayan status/error siqnalı təklif olunur.

## Qiymətləndirmə
Audit coverage 30, evidence 25, prioritization 20, redesign 25 bal.

## Təqdim etmə
Audit report və prototip linkini göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Check that users with different access needs can find task requirements and submit a solution.

## Scenario and starting point
Review task-list/detail and submission prototypes. Use WCAG 2.2 AA as a checklist; do not present the audit as an automatic compliance certification.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. Check keyboard focus order and visible focus indicator.
2. Measure contrast and test 200% text zoom, status labels, and error associations.
3. Use a screen reader to test page headings and CTA names.
4. Link each finding to a WCAG success criterion, impact, and fix.

## Deliverables
- Accessibility checklist and evidence screenshots.
- At least five findings with severity and recommended fixes.
- Updated prototype fixing one high-impact problem.

## Acceptance criteria
- Findings identify a specific element and user impact.
- The review does not rely only on automated scans.
- Status/error signals are not communicated by color alone.

## Evaluation
Audit coverage 30, evidence 25, prioritization 20, redesign 25 points.

## Submission
Submit the audit report and prototype link.

## Estimated time
4-6 hours.$ui_ux_design_2_inst_3$),
  ('ui-ux-design', 8, 8, 8, $ui_ux_design_2_desc_4$[[AZ]]
Eyni task axınını dar mobil, tablet və desktop enlərində yenidən yerləşdir və content prioritetini saxla.

[[EN]]
Adapt the same task flow across narrow mobile, tablet, and desktop while preserving content priorities.$ui_ux_design_2_desc_4$, $ui_ux_design_2_inst_4$[[AZ]]
## Məqsəd
Task metadata, instructions və submission panelini viewport dəyişdikdə də oxunaqlı və əlçatan saxla.

## Ssenari və başlanğıc
360px, 768px və 1280px viewport-ları üçün task detail dizayn et. Desktop layout-u sadəcə kiçiltmək əvəzinə mobil prioritetləri yenidən seç.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Breakpoint və content reflow qaydasını izah et.
2. Sidebar/nav-ın mobile variantını və back behavior-ı müəyyən et.
3. Uzun instruction, code sample və submit button davranışını yoxla.
4. Landscape, zoom və touch target state-lərini nəzərdən keçir.

## Təhvil veriləcək
- Üç viewport üçün task detail və submit ekranları.
- Breakpoint decision note və navigation variantları.
- 3 overflow/legibility test screenshot-u.

## Qəbul meyarları
- Üfüqi scrolling və kəsilən primary CTA yoxdur.
- Mobil ekranda təlimat submit-dən əvvəl məntiqli oxunur.
- Eyni funksiyalar mobil və desktop-da əlçatandır.

## Qiymətləndirmə
Responsive strategy 25, content readability 25, navigation 25, test/evidence 25 bal.

## Təqdim etmə
Design file linkini və hər üç viewport-un screenshot-unu göndər.

## Təxmini vaxt
4-6 saat.

[[EN]]
## Objective
Keep task metadata, instructions, and submission controls readable and accessible as the viewport changes.

## Scenario and starting point
Design task detail for 360px, 768px, and 1280px viewports. Reprioritize content for mobile instead of merely shrinking desktop.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. Explain breakpoints and content-reflow rules.
2. Define the mobile navigation variant and back behavior.
3. Test long instructions, code samples, and the submit button.
4. Review landscape, zoom, and touch-target states.

## Deliverables
- Task-detail and submission screens for three viewports.
- Breakpoint decision note and navigation variants.
- Three screenshots showing overflow/readability checks.

## Acceptance criteria
- No horizontal scrolling or clipped primary CTA.
- Instructions remain logically readable before submission on mobile.
- The same functionality is accessible on mobile and desktop.

## Evaluation
Responsive strategy 25, content readability 25, navigation 25, tests/evidence 25 points.

## Submission
Submit the design-file link and screenshots for all three viewports.

## Estimated time
4-6 hours.$ui_ux_design_2_inst_4$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_ui_ux_design_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 4 THEN RAISE EXCEPTION 'ui-ux-design batch 2: expected 4 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_ui_ux_design_2 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'ui-ux-design batch 2: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_ui_ux_design_2 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 4 THEN RAISE EXCEPTION 'ui-ux-design batch 2: expected 4 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_ui_ux_design_2;
END
$curriculum_ui_ux_design_2$;

DO $curriculum_ui_ux_design_3$
DECLARE matched_count INTEGER; updated_count INTEGER; conflict_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;
  CREATE TEMP TABLE curriculum_patch_ui_ux_design_3 (slug TEXT NOT NULL, old_week INTEGER NOT NULL, task_number INTEGER NOT NULL, new_week INTEGER NOT NULL, description TEXT NOT NULL, instructions TEXT NOT NULL, PRIMARY KEY (slug, old_week, task_number)) ON COMMIT DROP;
  INSERT INTO pg_temp.curriculum_patch_ui_ux_design_3 (slug, old_week, task_number, new_week, description, instructions) VALUES
  ('ui-ux-design', 8, 9, 8, $ui_ux_design_3_desc_1$[[AZ]]
Prototipdə tapşırığı tapma və təqdim etmə usability testini apar, tapıntıları prioritetləşdir.

[[EN]]
Run a usability test on finding and submitting a task, then prioritize findings.$ui_ux_design_3_desc_1$, $ui_ux_design_3_inst_1$[[AZ]]
## Məqsəd
İstifadəçilərin task list və detail axınını əlavə izah olmadan başa düşüb-düşmədiyini yoxla.

## Ssenari və başlanğıc
3-5 iştirakçı ilə moderated test apar və ya sayı azdırsa bunu qeyd et. Hər kəsdən statusu gözlənilən tapşırığı tapıb həll formatını müəyyən etməsini istə.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Neutral test script və success definition hazırla.
2. Vaxt, səhv klik, yardım istəyi və task completion qeyd et.
3. Think-aloud istifadə edərkən cavabı yönləndirmə.
4. Finding-ləri severity və tezliyə görə qrupla; bir düzəlişi prototipdə sına.

## Təhvil veriləcək
- Script, participant count və anonymized observation notes.
- Ən azı 5 finding və severity/impact cədvəli.
- Bir iterasiya və retest nəticəsi.

## Qəbul meyarları
- İştirakçı məlumatı və razılıq qorunur.
- Sitatlar anonimdir və nəticə nümunə ölçüsünü bildirir.
- Fix real müşahidəyə bağlanır.

## Qiymətləndirmə
Test neytrallığı 25, müşahidə keyfiyyəti 25, prioritet 25, iterasiya 25 bal.

## Təqdim etmə
Redaktə edilmiş test hesabatı və updated prototype linki göndər.

## Təxmini vaxt
5-7 saat.

[[EN]]
## Objective
Check whether users can understand the task-list and detail flow without extra explanation.

## Scenario and starting point
Run a moderated test with three to five participants, or state clearly if the sample is smaller. Ask each person to find a task with a target status and identify its submission format.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. Prepare a neutral test script and success definition.
2. Record time, misclicks, help requests, and task completion.
3. Do not lead participants while using think-aloud.
4. Group findings by severity/frequency and test one prototype change.

## Deliverables
- Script, participant count, and anonymized observation notes.
- At least five findings with severity/impact table.
- One iteration and retest result.

## Acceptance criteria
- Participant information and consent are protected.
- Quotes are anonymous and results state the sample size.
- The fix is tied to an observed issue.

## Evaluation
Test neutrality 25, observation quality 25, prioritization 25, iteration 25 points.

## Submission
Submit a redacted test report and updated prototype link.

## Estimated time
5-7 hours.$ui_ux_design_3_inst_1$),
  ('ui-ux-design', 8, 10, 8, $ui_ux_design_3_desc_2$[[AZ]]
Araşdırma, axın, ekran və test nəticələrini qərara yönəlmiş UX case study-də birləşdir.

[[EN]]
Combine research, flows, screens, and test results into a decision-oriented UX case study.$ui_ux_design_3_desc_2$, $ui_ux_design_3_inst_2$[[AZ]]
## Məqsəd
Dizayn probleminin necə araşdırıldığını, hansı qərarların verildiyini və prototipin nəyi yaxşılaşdırdığını sübutla göstər.

## Ssenari və başlanğıc
Əvvəlki tapşırıqların materiallarını istifadə et. Problem: tələbə tapşırıq təlimatını anlamır və ya təqdim etmə addımında tərəddüd edir. Həqiqi tədqiqat yoxdursa, fərziyyəni açıq yaz.

## Alətlər və iş mühiti
- Figma və ya Penpot-dan istifadə et; bu tapşırıq üçün terminal və VS Code quraşdırmaq tələb olunmur. Komandada başqa alət seçilibsə, həmin alətdə davam et.
- Faylı ekran və komponent adları ilə təşkil et; desktop və mobil variantları, boş/yüklənir/xəta vəziyyətlərini ayrı frame-lərdə göstər.
- Təqdimatda redaktə edilə bilən source linkini view access ilə paylaş və tələb olunan ekranları PNG/PDF kimi export et. Linkdə şəxsi məlumat və ictimai olmayan layihə məlumatı göstərmə.

## Addım-addım icra
1. Problem statement, istifadəçi və uğur ölçüsünü bir səhifədə qur.
2. Interview finding → user flow → wireframe → final screen əlaqəsini göstər.
3. Prototype/usability test nəticəsini əvvəlki fərziyyələrlə müqayisə et.
4. Əlçatanlıq, responsive variant və növbəti iterasiyanı sənədləşdir.

## Təhvil veriləcək
- Case study: problem, sübut, qərar, dizayn və nəticə.
- Ekran/flow artefaktları və anonymized test finding-lər.
- 3 prioritet növbəti addım və ölçmə planı.

## Qəbul meyarları
- Hər dizayn qərarı istifadəçi ehtiyacı və ya test sübutuna bağlanır.
- Nəticə ölçülməyibsə, uğur uydurulmur.
- Handoff faylları və prototype linki açıq və ardıcıldır.

## Qiymətləndirmə
Problem və tədqiqat 25, qərar traceability 25, final UX 25, ölçülə bilən handoff 25 bal.

## Təqdim etmə
Case study PDF/web linki, source design file və 5 dəqiqəlik təqdimat əlavə et.

## Təxmini vaxt
8-10 saat.

[[EN]]
## Objective
Show with evidence how the design problem was researched, what decisions were made, and what the prototype improves.

## Scenario and starting point
Use artifacts from earlier tasks. Problem: students misunderstand task instructions or hesitate at submission. If no real research was conducted, label assumptions clearly.

## Tools and working environment
- Use Figma or Penpot; this task does not require a terminal or VS Code installation. If the team selected another design tool, continue in that tool.
- Organize the file with clear screen and component names; show desktop and mobile variants plus empty/loading/error states in separate frames.
- Share an editable source link with view access and export the requested screens as PNG/PDF. Do not expose personal or non-public project data in the link.

## Step-by-step
1. State the problem, user, and success measure on one page.
2. Connect interview finding → user flow → wireframe → final screen.
3. Compare prototype/usability results against earlier assumptions.
4. Document accessibility, responsive variants, and next iteration.

## Deliverables
- Case study covering problem, evidence, decisions, design, and outcome.
- Screen/flow artifacts and anonymized test findings.
- Three prioritized next steps and measurement plan.

## Acceptance criteria
- Every design decision connects to a user need or test evidence.
- Do not invent success metrics that were not measured.
- Handoff files and prototype link are accessible and consistent.

## Evaluation
Problem/research 25, decision traceability 25, final UX 25, measurable handoff 25 points.

## Submission
Submit a case-study PDF/web link, source design file, and five-minute presentation.

## Estimated time
8-10 hours.$ui_ux_design_3_inst_2$);
  SELECT COUNT(*) INTO matched_count FROM pg_temp.curriculum_patch_ui_ux_design_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  IF matched_count <> 2 THEN RAISE EXCEPTION 'ui-ux-design batch 3: expected 2 source rows, matched %', matched_count; END IF;
  SELECT COUNT(*) INTO conflict_count FROM pg_temp.curriculum_patch_ui_ux_design_3 p JOIN public.internships i ON i.slug=p.slug JOIN public.internship_tasks t ON t.internship_id=i.id AND t.week_number=p.new_week AND t.task_number=p.task_number WHERE NOT (t.week_number=p.old_week AND t.task_number=p.task_number);
  IF conflict_count <> 0 THEN RAISE EXCEPTION 'ui-ux-design batch 3: target key conflict count %', conflict_count; END IF;
  UPDATE public.internship_tasks t SET week_number=p.new_week, description=p.description, instructions=p.instructions FROM pg_temp.curriculum_patch_ui_ux_design_3 p JOIN public.internships i ON i.slug=p.slug WHERE t.internship_id=i.id AND t.week_number=p.old_week AND t.task_number=p.task_number AND t.status='published';
  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 2 THEN RAISE EXCEPTION 'ui-ux-design batch 3: expected 2 updated rows, got %', updated_count; END IF;
  DROP TABLE pg_temp.curriculum_patch_ui_ux_design_3;
END
$curriculum_ui_ux_design_3$;

COMMIT;
