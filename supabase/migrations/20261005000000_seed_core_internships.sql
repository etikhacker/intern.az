-- ==========================================================
-- SEED: CORE INTERNSHIP PROGRAMS AND PRACTICAL TASKS
-- Intern.az — Frontend, Backend, Data, AI, Automation
-- ==========================================================
-- Idempotent seed: safe to run more than once.

INSERT INTO public.internships (
  id, title, slug, short_description, description, category,
  duration_weeks, difficulty, skills, requirements, responsibilities,
  benefits, max_students, status
)
VALUES
(
  'a1000000-0000-4000-8000-000000000001',
  'Frontend Engineering Internship',
  'frontend-engineering',
  'React, Next.js və TypeScript ilə müasir, əlçatan və responsiv web interfeyslər hazırla.',
  'Bu proqramda real məhsul interfeysinin planlaşdırılmasından deploy mərhələsinə qədər işləyəcəksən. Komponent arxitekturası, formalar, API inteqrasiyası, performans və accessibility üzərində praktiki tapşırıqlar yerinə yetirəcəksən.',
  'Frontend', 8, 'intermediate',
  ARRAY['HTML', 'CSS', 'JavaScript', 'TypeScript', 'React', 'Next.js', 'Git'],
  ARRAY['JavaScript əsasları', 'HTML və CSS ilə işləmə bacarığı', 'Git və GitHub haqqında ilkin anlayış', 'Həftədə ən azı 10 saat ayırmaq'],
  ARRAY['Responsiv UI komponentləri hazırlamaq', 'Kod review rəylərini tətbiq etmək', 'Pull request və texniki sənədləşdirmə ilə işləmək'],
  ARRAY['Real portfolio layihəsi', 'Mentor feedback-i', 'Komanda workflow təcrübəsi'], 15, 'published'
),
(
  'a1000000-0000-4000-8000-000000000002',
  'Backend Engineering Internship',
  'backend-engineering',
  'FastAPI, PostgreSQL və REST API-lərlə təhlükəsiz backend xidmətləri qur.',
  'Proqram backend sistemlərinin necə dizayn edildiyini və production-a hazır API-lərin necə yazıldığını öyrədir. Database modelləşdirməsi, authentication, validation, error handling və testlər real ssenarilər üzərindən tətbiq olunur.',
  'Backend', 8, 'intermediate',
  ARRAY['Python', 'FastAPI', 'REST API', 'PostgreSQL', 'SQL', 'JWT', 'Docker', 'Git'],
  ARRAY['Python əsasları', 'SQL haqqında ilkin bilik', 'HTTP və JSON anlayışı', 'Həftədə ən azı 10 saat ayırmaq'],
  ARRAY['API endpoint-ləri hazırlamaq', 'Database sxemini və migration-ları yazmaq', 'Authentication və input validation tətbiq etmək'],
  ARRAY['Deploy edilə bilən API', 'Backend portfolio təcrübəsi', 'Texniki code review'], 15, 'published'
),
(
  'a1000000-0000-4000-8000-000000000003',
  'Data Analytics Internship',
  'data-analytics',
  'Məlumatları təmizlə, analiz et və qərar verməyə kömək edən dashboard hazırla.',
  'Bu proqram data ilə işləməyin tam axınını əhatə edir: xam məlumatların təmizlənməsi, KPI-ların müəyyənləşdirilməsi, statistik analiz və nəticələrin vizuallaşdırılması. Tapşırıqlar biznesə yaxın dataset-lər əsasında hazırlanır.',
  'Data', 6, 'beginner',
  ARRAY['Python', 'Pandas', 'SQL', 'Data Cleaning', 'Statistics', 'Data Visualization'],
  ARRAY['Python və ya spreadsheet əsasları', 'Riyazi məntiq və əsas statistik anlayışlar', 'Məlumatla işləməyə maraq', 'Həftədə ən azı 8 saat ayırmaq'],
  ARRAY['Dataset-ləri təmizləmək və yoxlamaq', 'SQL sorğuları və KPI hesablamaları yazmaq', 'Analiz nəticələrini qrafik və hesabatla təqdim etmək'],
  ARRAY['Analitik portfolio işi', 'Dashboard nümunəsi', 'Data storytelling təcrübəsi'], 20, 'published'
),
(
  'a1000000-0000-4000-8000-000000000004',
  'Applied AI Engineering Internship',
  'applied-ai-engineering',
  'LLM API-ləri, prompt engineering və RAG yanaşması ilə faydalı AI funksiyaları qur.',
  'Proqram AI ideyasını işlək məhsul funksiyasına çevirməyə fokuslanır. Model seçimi, structured output, prompt testləri, sənədlər üzərindən axtarış və cavab keyfiyyətinin qiymətləndirilməsi praktiki layihə ilə öyrənilir.',
  'AI', 8, 'intermediate',
  ARRAY['Python', 'LLM APIs', 'Prompt Engineering', 'Embeddings', 'RAG', 'Evaluation', 'FastAPI'],
  ARRAY['Python və API əsasları', 'JSON ilə işləmə bacarığı', 'AI alətlərinə maraq', 'Həftədə ən azı 10 saat ayırmaq'],
  ARRAY['AI feature prototipi hazırlamaq', 'Prompt və cavab keyfiyyətini test etmək', 'Model xərci, latency və təhlükəsizlik risklərini sənədləşdirmək'],
  ARRAY['AI portfolio layihəsi', 'Evaluation yanaşması', 'Məhsul yönümlü AI təcrübəsi'], 12, 'published'
),
(
  'a1000000-0000-4000-8000-000000000005',
  'Automation Engineering Internship',
  'automation-engineering',
  'Təkrarlanan iş axınlarını API-lər, Python və workflow avtomatlaşdırması ilə sadələşdir.',
  'Bu proqramda manual prosesləri analiz edib avtomatlaşdırılmış workflow-lara çevirəcəksən. Webhook, API inteqrasiyası, məlumat çevrilməsi, retry məntiqi və monitorinq real biznes ssenariləri ilə tətbiq olunur.',
  'Automation', 6, 'intermediate',
  ARRAY['Python', 'REST APIs', 'Webhooks', 'n8n', 'Data Transformation', 'Logging'],
  ARRAY['Python və HTTP əsasları', 'JSON və webhook anlayışı', 'Problem həll etmə bacarığı', 'Həftədə ən azı 8 saat ayırmaq'],
  ARRAY['Manual prosesi xəritələndirmək', 'API-ləri bir workflow-da birləşdirmək', 'Xəta halları və loglama üçün həll hazırlamaq'],
  ARRAY['Avtomatlaşdırılmış workflow', 'Process improvement təcrübəsi', 'Portfolio üçün real case study'], 15, 'published'
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO public.internship_tasks (
  id, internship_id, title, description, instructions,
  week_number, task_number, difficulty, submission_type, is_required, status
)
VALUES
-- Frontend
('b1000000-0000-4000-8000-000000000001', 'a1000000-0000-4000-8000-000000000001', 'Responsive Landing Page', 'Kiçik bir məhsul üçün responsive landing page hazırla.', 'Hero, feature, pricing və footer bölmələrini komponentlərə ayır. Mobil, tablet və desktop ölçülərində düzgün görünməsini təmin et. GitHub repository və canlı demo linki göndər.', 1, 1, 'beginner', 'multiple', true, 'published'),
('b1000000-0000-4000-8000-000000000002', 'a1000000-0000-4000-8000-000000000001', 'Reusable Component System', 'Layihə üçün təkrar istifadə edilə bilən UI komponentləri yarat.', 'Button, Input, Card, Modal və Badge komponentlərini prop-larla qur. Ən azı iki fərqli səhifədə istifadə et və README-də API nümunələrini göstər.', 2, 2, 'intermediate', 'github', true, 'published'),
('b1000000-0000-4000-8000-000000000003', 'a1000000-0000-4000-8000-000000000001', 'API-powered Dashboard', 'Xarici API-dən məlumat alan dashboard hazırla.', 'Loading, empty və error state-ləri nəzərə al. Filter və axtarış əlavə et. Network xətası zamanı istifadəçiyə aydın mesaj göstər.', 4, 3, 'intermediate', 'multiple', true, 'published'),
('b1000000-0000-4000-8000-000000000004', 'a1000000-0000-4000-8000-000000000001', 'Final Frontend Project', 'Seçdiyin real problemi həll edən kiçik web məhsulu hazırla.', 'Məhsulun məqsədini, istifadəçi axınını və texniki qərarlarını README-də izah et. Responsive dizayn, accessibility və deploy tələblərini yerinə yetir.', 8, 4, 'advanced', 'multiple', true, 'published'),
-- Backend
('b2000000-0000-4000-8000-000000000001', 'a1000000-0000-4000-8000-000000000002', 'REST API Design', 'Task management üçün REST API dizayn et.', 'Resources, endpoint-lər, HTTP status kodları və pagination strategiyasını sənədləşdir. Ən azı CRUD əməliyyatlarını implement et.', 1, 1, 'beginner', 'github', true, 'published'),
('b2000000-0000-4000-8000-000000000002', 'a1000000-0000-4000-8000-000000000002', 'PostgreSQL Data Model', 'Task management API üçün relational database sxemi hazırla.', 'Users, projects və tasks cədvəllərini əlaqələndir. Primary key, foreign key, index və migration əlavə et. Seçdiyin qərarları qısa şəkildə izah et.', 2, 2, 'intermediate', 'github', true, 'published'),
('b2000000-0000-4000-8000-000000000003', 'a1000000-0000-4000-8000-000000000002', 'Authentication and Validation', 'API-yə qeydiyyat, login və qorunan endpoint-lər əlavə et.', 'Şifrəni təhlükəsiz hash-lə, token əsaslı authentication tətbiq et və bütün input-ları validate et. Yanlış sorğular üçün ardıcıl error response qaytar.', 4, 3, 'intermediate', 'multiple', true, 'published'),
('b2000000-0000-4000-8000-000000000004', 'a1000000-0000-4000-8000-000000000002', 'Final Backend Service', 'Deploy edilə bilən, testləri olan backend servisi tamamla.', 'Ən azı 5 endpoint, unit/integration testləri, environment configuration, logging və API documentation əlavə et. Swagger/OpenAPI sənədini təqdim et.', 8, 4, 'advanced', 'multiple', true, 'published'),
-- Data
('b3000000-0000-4000-8000-000000000001', 'a1000000-0000-4000-8000-000000000003', 'Dataset Cleaning', 'Səhvlərlə və boş dəyərlərlə dolu dataset-i analiz üçün hazırla.', 'Missing values, duplicate rows, yanlış data type və outlier-ləri tap. Təmizləmə addımlarını notebook-da izah et və əvvəl/sonra statistikalarını müqayisə et.', 1, 1, 'beginner', 'multiple', true, 'published'),
('b3000000-0000-4000-8000-000000000002', 'a1000000-0000-4000-8000-000000000003', 'SQL KPI Analysis', 'Satış və ya istifadəçi datası üçün əsas KPI-ları hesabla.', 'Ən azı 5 SQL sorğusu yaz: aylıq trend, top kateqoriyalar, retention və conversion göstəriciləri daxil olsun. Sorğuların nəyi ölçdüyünü qeyd et.', 2, 2, 'intermediate', 'github', true, 'published'),
('b3000000-0000-4000-8000-000000000003', 'a1000000-0000-4000-8000-000000000003', 'Insight Dashboard', 'Analiz nəticələrini istifadəçinin başa düşəcəyi dashboard-a çevir.', 'Ən vacib 3–5 insight-ı seç. Ən uyğun qrafik növlərindən istifadə et, filter əlavə et və yanlış interpretasiyaya səbəb ola biləcək qrafiklərdən qaç.', 4, 3, 'intermediate', 'multiple', true, 'published'),
('b3000000-0000-4000-8000-000000000004', 'a1000000-0000-4000-8000-000000000003', 'Final Data Case Study', 'Real biznes sualına data əsaslı cavab hazırla.', 'Sualı, metodologiyanı, məhdudiyyətləri və nəticəni hesabat formatında təqdim et. Notebook, təmiz dataset və yekun təqdimat linkini əlavə et.', 6, 4, 'advanced', 'multiple', true, 'published'),
-- AI
('b4000000-0000-4000-8000-000000000001', 'a1000000-0000-4000-8000-000000000004', 'Reliable Prompt Template', 'Müştəri dəstəyi üçün structured output qaytaran prompt hazırla.', 'Modeldən sabit JSON schema tələb et. Ən azı 10 nümunə input ilə test et və yanlış cavab nümunələrini qeyd et. Prompt versiyalarını müqayisə et.', 1, 1, 'beginner', 'multiple', true, 'published'),
('b4000000-0000-4000-8000-000000000002', 'a1000000-0000-4000-8000-000000000004', 'Document Q&A Prototype', 'Sənədlər üzərindən sual-cavab edən kiçik RAG prototipi qur.', 'Sənədləri hissələrə böl, embedding yarat, relevant parçaları tap və cavabı mənbə ilə birlikdə qaytar. “Cavab tapılmadı” halını ayrıca idarə et.', 3, 2, 'intermediate', 'github', true, 'published'),
('b4000000-0000-4000-8000-000000000003', 'a1000000-0000-4000-8000-000000000004', 'AI Evaluation Report', 'AI funksiyasının keyfiyyətini ölçmək üçün evaluation set hazırla.', 'Qiymətləndirmə meyarlarını müəyyən et: correctness, relevance, groundedness və latency. Ən azı 20 test nümunəsi ilə nəticələri cədvəldə təqdim et.', 5, 3, 'intermediate', 'multiple', true, 'published'),
('b4000000-0000-4000-8000-000000000004', 'a1000000-0000-4000-8000-000000000004', 'Final AI Product Feature', 'Real istifadəçi problemini həll edən AI funksiyasını məhsula inteqrasiya et.', 'Frontend və backend hissəsini birləşdir. Rate limit, error handling, prompt injection riskləri və API xərcləri barədə texniki qeydlər əlavə et.', 8, 4, 'advanced', 'multiple', true, 'published'),
-- Automation
('b5000000-0000-4000-8000-000000000001', 'a1000000-0000-4000-8000-000000000005', 'Process Mapping', 'Manual və təkrarlanan bir prosesi addım-addım xəritələndir.', 'Hazırkı prosesi, giriş-çıxışları, istifadə olunan alətləri və ən çox xəta yaranan nöqtələri sənədləşdir. Avtomatlaşdırma üçün ölçülə bilən məqsəd təyin et.', 1, 1, 'beginner', 'file', true, 'published'),
('b5000000-0000-4000-8000-000000000002', 'a1000000-0000-4000-8000-000000000005', 'Webhook to Workflow', 'Webhook qəbul edib məlumatı başqa bir servisə göndərən workflow qur.', 'Input məlumatını validate et, lazımi field-ləri transform et və nəticəni üçüncü tərəf API-sinə göndər. Uğurlu və uğursuz ssenariləri test et.', 2, 2, 'intermediate', 'multiple', true, 'published'),
('b5000000-0000-4000-8000-000000000003', 'a1000000-0000-4000-8000-000000000005', 'Retries and Monitoring', 'Workflow üçün retry və sadə monitorinq mexanizmi əlavə et.', 'Temporary və permanent xətaları fərqləndir. Retry limitini müəyyən et, uğursuz execution barədə notification göndər və əsas hadisələri log-la.', 4, 3, 'intermediate', 'github', true, 'published'),
('b5000000-0000-4000-8000-000000000004', 'a1000000-0000-4000-8000-000000000005', 'Final Automation Case Study', 'Real proses üçün başdan sona avtomatlaşdırma həlli hazırla.', 'Əvvəlki manual vaxtı və avtomatlaşdırmadan sonrakı nəticəni müqayisə et. Workflow export-u, arxitektura diaqramı, setup təlimatı və məhdudiyyətləri təqdim et.', 6, 4, 'advanced', 'multiple', true, 'published')
ON CONFLICT (id) DO NOTHING;
