-- ==========================================================
-- EXPAND TASK INSTRUCTIONS
-- Core tasks previously had a one-line instruction. Students could not tell
-- what to build, how to start, what to submit or how it is graded.
-- Each task now has: Məqsəd, Başlamazdan əvvəl, Addımlar, Nə təqdim etməlisən,
-- Necə qiymətləndirilir, Tez-tez edilən səhvlər.
-- The format is a small Markdown subset (## headings, - bullets, 1. lists,
-- **bold**, `code`) rendered by components/tasks/task-instructions.tsx.
-- Idempotent: safe to run more than once. Only touches the 20 seeded tasks.
-- ==========================================================

-- ---------------------------------------------------------
-- FRONTEND
-- ---------------------------------------------------------

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Bir məhsul və ya xidmət üçün tək səhifəlik tanıtım saytı (landing page) hazırlayırsan. Əsas məsələ saytın telefonda, planşetdə və kompüterdə düzgün görünməsidir.

## Başlamazdan əvvəl
- HTML və CSS əsaslarını bilmək kifayətdir. React/Next.js istifadə etmək məcburi deyil, amma məsləhətdir.
- Məhsulu özün seç: kafe, onlayn kurs, mobil tətbiq, studiya və s. Əsas odur ki, nə satdığını bir cümlə ilə deyə biləsən.
- GitHub hesabın hazır olmalıdır.

## Addımlar
1. Məhsulu seç və 3 cümlə yaz: nədir, kim üçündür, əsas faydası nədir.
2. Kağızda və ya Figma-da eskiz çək: **Hero**, **Features** (3-4 kart), **Pricing** (2-3 plan), **Footer**.
3. GitHub-da public repozitoriya aç və layihəni qur (`git init`, ilk commit).
4. Hər bölməni ayrıca komponent kimi yaz: `Hero`, `Features`, `Pricing`, `Footer`.
5. Əvvəlcə **mobil (360px)** üçün yaz, sonra `min-width` media query ilə 768px və 1280px üçün genişləndir.
6. Şəkillərə `alt` mətni əlavə et. Düymələr və linklər klaviatura (Tab) ilə də işləməlidir.
7. Chrome DevTools → Device Toolbar ilə 360, 768 və 1280 ölçülərini yoxla. Üfüqi scroll (yana sürüşmə) olmamalıdır.
8. Saytı Vercel və ya Netlify-da deploy et.
9. `README.md` yaz: layihənin təsviri, necə işə salınır, canlı link, 3 ekran görüntüsü.

## Nə təqdim etməlisən
- GitHub repozitoriya linki
- Canlı demo linki
- İstəyə görə: mentora qeyd (nə çətin gəldi, nəyi öyrəndin)

## Necə qiymətləndirilir
- 4 bölmənin hamısı var və məzmunu məntiqlidir
- 3 ekran ölçüsündə dizayn pozulmur
- Kod komponentlərə bölünüb
- README tam, canlı link işləyir
- Ən azı 5 mənalı commit var (məsələn: `add hero section`)

## Tez-tez edilən səhvlər
- Enləri `px` ilə sabit yazmaq (mobil ekranda sınır)
- Yalnız kompüterdə yoxlamaq
- Bütün kodu tək fayla yığmaq
- README yazmamaq və ya canlı linki test etməmək
$i$ WHERE id = 'b1000000-0000-4000-8000-000000000001';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Layihədə təkrar-təkrar istifadə edə biləcəyin kiçik UI komponent kitabxanası yaradırsan. Eyni düyməni 10 yerdə kopyalamaq əvəzinə, bir dəfə yazıb hər yerdə çağırmağı öyrənirsən.

## Başlamazdan əvvəl
- React-də komponent və `props` anlayışını bil.
- TypeScript bilirsənsə prop tiplərini yaz. Bilmirsənsə JavaScript ilə də olar, amma tip yazmaq əlavə bal gətirir.
- Birinci tapşırığın layihəsindən istifadə edə bilərsən.

## Addımlar
1. Beş komponent seç: `Button`, `Input`, `Card`, `Modal`, `Badge`.
2. Hər komponent üçün variantları müəyyən et. Məsələn, `Button`: `variant` (primary/secondary/danger), `size` (sm/md/lg), `disabled`, `loading`.
3. Komponentləri `components/ui/` qovluğunda ayrı-ayrı fayllara yaz.
4. `Modal` Escape düyməsi ilə və kənara klikləyəndə bağlansın. Açılanda fokus modalın içinə keçsin.
5. `Input` üçün `label`, `error` mesajı və `disabled` vəziyyətini dəstəklə.
6. Komponentləri **ən azı iki fərqli səhifədə** işlət (məsələn: giriş formu və profil səhifəsi).
7. Hər komponent üçün README-də 1 istifadə nümunəsi (kod parçası) göstər və prop-ların cədvəlini yaz.
8. Kodu GitHub-a göndər.

## Nə təqdim etməlisən
- GitHub repozitoriya linki. README-də komponentlərin siyahısı və nümunələr olmalıdır.

## Necə qiymətləndirilir
- 5 komponentin hamısı işləyir
- Prop-lar ilə fərqli görünüş əldə olunur
- Komponentlər ən azı 2 səhifədə istifadə edilib
- README-də API nümunələri aydındır
- Kod təkrarı azdır

## Tez-tez edilən səhvlər
- Komponentin içinə konkret mətn yazmaq (`children` və ya prop istifadə et)
- `Modal`-ı klaviatura ilə bağlamamaq
- Nümunə göstərmədən yalnız komponent yazıb README-ni boş buraxmaq
$i$ WHERE id = 'b1000000-0000-4000-8000-000000000002';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Açıq (public) bir API-dən məlumat çəkib istifadəçiyə cədvəl və ya kartlar şəklində göstərən dashboard hazırlayırsan. Əsas məsələ yükləmə, boş nəticə və xəta hallarını düzgün idarə etməkdir.

## Başlamazdan əvvəl
- `fetch` və `useEffect` (və ya Next.js server fetch) bilməlisən.
- API seç. Məsələn: Open-Meteo (hava), REST Countries (ölkələr), PokéAPI, ExchangeRate API. Açar (API key) tələb etməyən API seçmək daha asandır.

## Addımlar
1. API-nin sənədini oxu və hansı məlumatı göstərəcəyini seç (ən azı 20 qeyd olsun).
2. Məlumatı çək və ekranda göstər: cədvəl və ya kart şəbəkəsi.
3. **Üç vəziyyəti ayrıca göstər:**
   - `loading` — yüklənir (spinner və ya skeleton)
   - `empty` — nəticə yoxdur (məsələn: "Heç nə tapılmadı")
   - `error` — xəta var ("Məlumat yüklənmədi, yenidən cəhd et" və "Yenidən cəhd et" düyməsi)
4. Axtarış sahəsi əlavə et (ada görə).
5. Ən azı bir filtr əlavə et (məsələn: region, kateqoriya).
6. Şəbəkəni söndürüb (DevTools → Network → Offline) xəta mesajını yoxla.
7. Saytı deploy et və README yaz.

## Nə təqdim etməlisən
- GitHub repozitoriya linki
- Canlı demo linki

## Necə qiymətləndirilir
- Məlumat düzgün göstərilir
- Loading, empty və error halları var və aydındır
- Axtarış və filtr işləyir
- Xəta mesajı istifadəçi üçün başa düşüləndir ("undefined" və ya texniki yazı göstərilmir)
- Kod səliqəlidir, API açarı kodda açıq saxlanmayıb

## Tez-tez edilən səhvlər
- Yalnız uğurlu halı yoxlamaq
- Hər düymə basanda API-yə sorğu göndərmək (axtarışda gecikdirmə/debounce istifadə et)
- API açarını repozitoriyaya yükləmək
$i$ WHERE id = 'b1000000-0000-4000-8000-000000000003';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Proqramın sonunda portfoliyona qoya biləcəyin tam, işlək bir web məhsul hazırlayırsan. Məhsul real bir problemi həll etməlidir (məsələn: tapşırıq izləyici, xərc hesablayıcı, tələbə cədvəli, kitab siyahısı).

## Başlamazdan əvvəl
- Əvvəlki tapşırıqlardakı komponentlərdən və biliklərdən istifadə edə bilərsən.
- Ideyanı mentorla razılaşdırmaq məsləhətdir. Çox böyük ideya seçmə: 1-2 əsas funksiyanı yaxşı etmək 10 yarımçıq funksiyadan yaxşıdır.

## Addımlar
1. Problemi bir cümlə ilə yaz: "Mənim məhsulum ___ üçün ___ problemini həll edir."
2. İstifadəçinin yolunu çək: səhifəyə girir → nə edir → nəticə nə olur (3-5 addım).
3. Texnologiyaları seç və səbəbini yaz (məsələn: Next.js + Supabase).
4. Əsas funksiyanı işlək hala gətir. Yalnız ondan sonra əlavə funksiyalara keç.
5. Responsiv dizayn: telefonda və kompüterdə yoxla.
6. Accessibility: bütün şəkillərdə `alt`, düymələrdə aydın mətn, klaviatura ilə gəzmək, kifayət qədər rəng kontrastı. Lighthouse Accessibility ≥ 90 hədəfləyin.
7. Deploy et (Vercel/Netlify).
8. README-də bunları yaz: problem, istifadəçi axını, texniki qərarlar (niyə bu texnologiyalar), necə işə salınır, məhdudiyyətlər.

## Nə təqdim etməlisən
- GitHub repozitoriya linki
- Canlı demo linki
- README-də problem, istifadəçi axını və texniki qərarların izahı

## Necə qiymətləndirilir
- Məhsul real problemi həll edir və əsas funksiya işləyir
- Dizayn responsivdir və accessibility qaydalarına əməl edilib
- Canlı link işləyir
- README-də qərarlar əsaslandırılıb
- Kod strukturu və commit tarixçəsi səliqəlidir

## Tez-tez edilən səhvlər
- Çox funksiya, amma heç biri tam işləmir
- Canlı demo linkinin qapalı və ya xətalı olması
- README-də "nə etdim" yazıb "niyə belə etdim" yazmamaq
$i$ WHERE id = 'b1000000-0000-4000-8000-000000000004';

-- ---------------------------------------------------------
-- BACKEND
-- ---------------------------------------------------------

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Tapşırıq idarəetmə (task management) tətbiqi üçün REST API dizayn edib işlək hala gətirirsən. API — mobil tətbiq və ya sayt ilə serverin danışdığı "dil"dir. Bu tapşırıqda həmin dili düzgün qurmağı öyrənirsən.

## Başlamazdan əvvəl
- Python əsasları, HTTP metodlarının (GET, POST, PUT, DELETE) mənasını bil.
- Tövsiyə olunan alət: **FastAPI**. Quraşdırma: `pip install fastapi uvicorn`.
- Bu mərhələdə verilənlər bazası məcburi deyil. Siyahı (list) və ya dictionary kifayətdir. Baza növbəti tapşırıqdadır.

## Addımlar
1. Resursları müəyyən et: `users`, `projects`, `tasks`.
2. Hər resurs üçün endpoint-ləri yaz. Nümunə (`tasks`):
   - `GET /tasks` — siyahı
   - `GET /tasks/{id}` — biri
   - `POST /tasks` — yarat
   - `PUT /tasks/{id}` — yenilə
   - `DELETE /tasks/{id}` — sil
3. Düzgün HTTP status kodları qaytar: `200` (uğurlu), `201` (yaradıldı), `204` (silindi), `400/422` (yanlış sorğu), `404` (tapılmadı).
4. Siyahı endpoint-inə **pagination** əlavə et: `GET /tasks?page=1&limit=20`. Cavabda `items`, `total`, `page` olsun.
5. Ən azı `tasks` üçün tam CRUD-u (yarat, oxu, yenilə, sil) implement et.
6. `uvicorn main:app --reload` ilə işə sal və brauzerdə `http://localhost:8000/docs` səhifəsindən hər endpoint-i test et.
7. `docs/api.md` faylında cədvəl hazırla: metod, yol, təsvir, nümunə sorğu, nümunə cavab, status kodları.
8. Kodu GitHub-a göndər, README-də işə salma təlimatı yaz.

## Nə təqdim etməlisən
- GitHub repozitoriya linki (kod + `docs/api.md` + README)

## Necə qiymətləndirilir
- Resurs adları və yollar düzgündür (cəm şəkildə: `/tasks`, fel yox)
- Status kodları məntiqlidir
- Pagination işləyir
- CRUD tam işləyir
- Sənəd başqa developer-in oxuyub istifadə edə biləcəyi qədər aydındır

## Tez-tez edilən səhvlər
- Yollarda fel işlətmək (`/getTasks`, `/createTask`)
- Hər şeyə `200` qaytarmaq
- Tapılmayan resurs üçün `404` yerinə `200` və boş cavab qaytarmaq
- Sənəd yazmamaq
$i$ WHERE id = 'b2000000-0000-4000-8000-000000000001';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Task management API üçün PostgreSQL verilənlər bazası sxemi (cədvəllər və aralarındakı əlaqələr) hazırlayırsan. Yaxşı sxem sonradan problemlərin böyük hissəsini qabaqcadan həll edir.

## Başlamazdan əvvəl
- SQL əsasları: `CREATE TABLE`, `SELECT`, `JOIN`.
- Docker ilə PostgreSQL qaldırmaq asandır: `docker run -e POSTGRES_PASSWORD=pass -p 5432:5432 postgres`.
- Əvvəlki tapşırıqdakı API layihəsindən davam edə bilərsən.

## Addımlar
1. Üç cədvəl hazırla: `users`, `projects`, `tasks`.
2. Əlaqələri müəyyən et: bir istifadəçinin çox layihəsi, bir layihənin çox tapşırığı ola bilər (**one-to-many**).
3. Hər cədvəldə **primary key** (məsələn `id UUID`), uyğun yerlərdə **foreign key** (`project_id`, `owner_id`) olsun.
4. Məhdudiyyətlər əlavə et: `NOT NULL`, `UNIQUE` (məsələn email), `CHECK` (məsələn status yalnız `todo/in_progress/done`).
5. Tez-tez axtarılan sütunlara **index** yaz (məsələn `tasks.project_id`, `tasks.status`). Niyə seçdiyini bir cümlə ilə qeyd et.
6. Sxemi **migration** faylı kimi yaz (`001_init.sql` və ya Alembic). Sxemi əl ilə dəyişmə, hər dəyişiklik yeni migration olsun.
7. Test üçün seed data əlavə et (2 istifadəçi, 3 layihə, 10 tapşırıq).
8. Bir `JOIN` sorğusu yaz: "Hər layihə üzrə tamamlanmış tapşırıqların sayı".
9. README-də ER diaqramı göstər (dbdiagram.io və ya Mermaid ilə) və 3 qərarını izah et. Məsələn: "Niyə `UUID`?", "Niyə bu index?", "Niyə `ON DELETE CASCADE`?".

## Nə təqdim etməlisən
- GitHub repozitoriya linki (migration fayllar, seed data, README, diaqram)

## Necə qiymətləndirilir
- Sxem normallaşdırılıb (təkrarlanan məlumat yoxdur)
- Primary key, foreign key və index düzgün qoyulub
- Migration sıfırdan işə salınanda xətasız keçir
- Qərarların izahı məntiqlidir

## Tez-tez edilən səhvlər
- Foreign key yazmayıb yalnız `project_id` adlı sütun qoymaq
- Hər sütuna index əlavə etmək
- Şifrəni açıq mətn kimi saxlamaq (növbəti tapşırıqda hash olacaq, indidən `password_hash` sütunu qoy)
$i$ WHERE id = 'b2000000-0000-4000-8000-000000000002';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
API-yə qeydiyyat (register), giriş (login) və yalnız giriş etmiş istifadəçinin görə biləcəyi (qorunan) endpoint-lər əlavə edirsən. Təhlükəsizlik backend-in ən vacib hissələrindən biridir.

## Başlamazdan əvvəl
- Əvvəlki tapşırıqların layihəsini davam etdir.
- Anla: **hash** (şifrəni geri qaytarıla bilməyən şəkildə saxlamaq) ilə **şifrələmə** fərqlidir.
- Alətlər: FastAPI üçün `passlib[bcrypt]` və `python-jose` (JWT), validation üçün Pydantic.

## Addımlar
1. `POST /auth/register` — email və şifrə qəbul et. Email formatını yoxla, şifrə ən azı 8 simvol olsun. Şifrəni **bcrypt və ya argon2** ilə hash-lə. Heç vaxt açıq mətn saxlama.
2. `POST /auth/login` — email və şifrəni yoxla, düzgündürsə **JWT token** qaytar (məsələn, 30 dəqiqəlik ömür).
3. `GET /me` — token ilə cari istifadəçinin məlumatını qaytar. Token yoxdursa və ya səhvdirsə `401`.
4. Mövcud `tasks` endpoint-lərini qoru: yalnız giriş etmiş istifadəçi görsün və istifadəçi yalnız öz tapşırıqlarına toxuna bilsin (başqasınınkı üçün `403` və ya `404`).
5. Bütün giriş məlumatlarını (body, query) Pydantic ilə yoxla.
6. Eyni formatda xəta cavabı qaytar:
   - `{"error": {"code": "invalid_credentials", "message": "Email və ya şifrə səhvdir"}}`
7. Login zamanı "bu email mövcud deyil" və "şifrə səhvdir" kimi ayrı mesaj vermə. Hər ikisi üçün eyni mesaj ver (hesab axtarışının qarşısını alır).
8. Gizli açarları (`SECRET_KEY`) kodda saxlama. `.env` faylından oxu, repoya yalnız `.env.example` qoy.
9. Test üçün Postman collection və ya `curl` nümunələri hazırla.

## Nə təqdim etməlisən
- GitHub repozitoriya linki
- Qısa mətn: layihəni necə işə salmaq və test etmək (qeydiyyat → login → qorunan endpoint)

## Necə qiymətləndirilir
- Şifrələr hash-lənib
- JWT düzgün yaradılır və yoxlanılır
- Qorunan endpoint-lər tokensiz açılmır
- Bütün input-lar yoxlanılır, xəta cavabları eyni formatdadır
- Repoda gizli açar və ya real şifrə yoxdur

## Tez-tez edilən səhvlər
- `SECRET_KEY`-i və ya `.env` faylını GitHub-a yükləmək
- Tokenin müddətini sonsuz qoymaq
- `401` (giriş yoxdur) ilə `403` (icazə yoxdur) arasında fərqi bilməmək
$i$ WHERE id = 'b2000000-0000-4000-8000-000000000003';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Əvvəlki tapşırıqlardakı işi tamamlayıb canlı mühitdə işləyən, testləri olan, sənədləşdirilmiş backend servisi təqdim edirsən. Bu, portfoliona qoyacağın əsas backend işindir.

## Başlamazdan əvvəl
- Əvvəlki 3 tapşırığın kodu hazır olmalıdır: API, verilənlər bazası, authentication.
- Alətlər: `pytest` (test), `Docker` (paketləmə), Render / Railway / Fly.io (deploy).

## Addımlar
1. Ən azı **5 endpoint** işlək olsun (auth + tasks + projects birlikdə).
2. **Testlər yaz** (`pytest`): ən azı 8 test. Həm uğurlu hal (düzgün sorğu), həm xəta halı (səhv şifrə, tapılmayan id, tokensiz sorğu) olsun.
3. **Environment configuration:** bütün tənzimləmələr (baza URL, secret key) `.env` faylından oxunsun. Repoda `.env.example` olsun.
4. **Logging:** hər sorğu üçün metod, yol, status kodu və müddəti log-la. Xətaları `ERROR` səviyyəsində yaz. Şifrə və token log-a düşməsin.
5. **API sənədi:** FastAPI `/docs` (Swagger) və `/openapi.json` avtomatik yaranır. Hər endpoint üçün `summary` və nümunə cavab yaz.
6. `Dockerfile` hazırla və konteynerin lokalda işlədiyini yoxla.
7. Servisi **deploy et** və canlı URL-i yoxla (`/docs` açılmalıdır).
8. README-də bunları yaz: layihənin təsviri, arxitektura (qısa diaqram), quraşdırma, testləri necə işə salmaq, canlı link, sənəd linki.

## Nə təqdim etməlisən
- GitHub repozitoriya linki
- Deploy edilmiş servisin linki
- Swagger/OpenAPI sənədinin linki (`/docs`)

## Necə qiymətləndirilir
- 5+ endpoint düzgün işləyir
- Testlər keçir (`pytest` yaşıl)
- Konfiqurasiya `.env`-dədir, gizli məlumat repoda yoxdur
- Logging mənalıdır
- Deploy işləyir, sənəd aydındır

## Tez-tez edilən səhvlər
- Testləri yalnız uğurlu hal üçün yazmaq
- Deploy etdikdən sonra yoxlamamaq
- Log-a şifrə və ya token yazmaq
- README-ni boş buraxmaq
$i$ WHERE id = 'b2000000-0000-4000-8000-000000000004';

-- ---------------------------------------------------------
-- DATA
-- ---------------------------------------------------------

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Xəta və boşluqlarla dolu verilənlər dəstini (dataset) analizə hazır hala gətirirsən. Real işdə vaxtın böyük hissəsi məhz təmizləməyə gedir.

## Başlamazdan əvvəl
- Python + Pandas və ya Excel/Google Sheets istifadə edə bilərsən (Python məsləhətdir).
- Dataset: Kaggle-dan "dirty" və ya "messy" dataset (məsələn, satış və ya müştəri datası, ən azı 500 sətir). Mentorun verdiyi dataset varsa, onu işlət.
- Jupyter Notebook və ya Google Colab istifadə et.

## Addımlar
1. Datasetə ilk baxış: `df.head()`, `df.info()`, `df.describe()`, `df.isna().sum()`.
2. **Boş dəyərləri (missing values)** tap. Hər sütun üçün qərar ver və səbəbini yaz: silmək, ortalama/median ilə doldurmaq, yoxsa "Naməlum" yazmaq.
3. **Təkrarlanan sətirləri (duplicates)** tap və sil: `df.duplicated().sum()`.
4. **Yanlış data tipləri:** tarix `object` kimi qalıbsa `datetime`-a, rəqəm mətn kimi yazılıbsa `float`-a çevir.
5. **Outlier-lər (kənar dəyərlər):** IQR metodu ilə tap (`Q1 - 1.5*IQR` və `Q3 + 1.5*IQR`). Hər birini silmək lazım deyil. Hansını saxlayıb hansını sildiyini və niyə belə etdiyini yaz.
6. Mətn sütunlarını standartlaşdır (böyük/kiçik hərf, əlavə boşluqlar: `df['col'].str.strip().str.lower()`).
7. Əvvəl və sonra statistikasını cədvəldə müqayisə et: sətir sayı, boş dəyər sayı, təkrar sayı.
8. Təmiz datanı `clean_data.csv` kimi saxla.
9. Notebook-un hər xanasının üstündə qısa izah (Markdown) yaz: nə edirsən və niyə.

## Nə təqdim etməlisən
- Notebook faylı (`.ipynb`) və ya GitHub linki
- Təmizlənmiş dataset (`clean_data.csv`)

## Necə qiymətləndirilir
- Bütün problemlər (boş dəyər, təkrar, tip, outlier) tapılıb
- Hər qərar izah olunub
- Əvvəl/sonra müqayisəsi aydındır
- Notebook sıfırdan sona xətasız işləyir

## Tez-tez edilən səhvlər
- Bütün boş sətirləri izahsız silmək (datanın yarısı itə bilər)
- Outlier-i avtomatik silmək (bəzən real və vacib dəyərdir)
- Kodu yazıb niyə belə etdiyini yazmamaq
$i$ WHERE id = 'b3000000-0000-4000-8000-000000000001';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
SQL ilə satış və ya istifadəçi datasından əsas biznes göstəricilərini (KPI) hesablayırsan. KPI — biznesin nə qədər yaxşı getdiyini göstərən rəqəmdir (məsələn, aylıq gəlir).

## Başlamazdan əvvəl
- SQL əsasları: `SELECT`, `WHERE`, `GROUP BY`, `JOIN`.
- Dataseti SQLite, PostgreSQL və ya DuckDB-yə yüklə. Əvvəlki tapşırığın təmiz datasından istifadə edə bilərsən.

## Addımlar
1. Dataseti bazaya yüklə və cədvəl strukturunu README-də qeyd et.
2. Ən azı **5 SQL sorğusu** yaz. Bunlar mütləq olsun:
   - **Aylıq trend:** hər ay üzrə gəlir və ya sifariş sayı (`GROUP BY` ay)
   - **Top kateqoriyalar:** ən çox gəlir gətirən 5 kateqoriya (`ORDER BY ... LIMIT 5`)
   - **Retention:** bir ay alış-veriş edənlərin neçə faizi növbəti ay da alış-veriş edib
   - **Conversion:** ziyarətçilərin (və ya qeydiyyatdan keçənlərin) neçə faizi alış edib
   - Özün seçdiyin 1 əlavə sorğu
3. Hər sorğunun üstündə şərh (`-- ...`) yaz: **nəyi ölçür**, **düstur nədir**, **nəticə nə deyir** (1-2 cümlə).
4. Sorğuları `queries.sql` faylına yığ.
5. README-də hər KPI üçün nəticəni cədvəldə göstər və qısa şərh yaz. Məsələn: "Dekabr ayında gəlir 30% artıb. Səbəb ola bilər: bayram endirimləri."

## Nə təqdim etməlisən
- GitHub repozitoriya linki (`queries.sql` + `README.md`)

## Necə qiymətləndirilir
- 5+ sorğu düzgün işləyir və nəticə verir
- Retention və conversion düzgün hesablanıb
- Hər sorğunun nəyi ölçdüyü izah olunub
- Nəticələr rəqəm və şərh ilə təqdim olunub

## Tez-tez edilən səhvlər
- `GROUP BY`-da bütün sütunları yazmamaq (xəta verir)
- Retention-u sadəcə "ümumi müştəri sayı" kimi hesablamaq
- Sorğu yazıb nəticəni şərh etməmək
$i$ WHERE id = 'b3000000-0000-4000-8000-000000000002';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Analiz nəticələrini qeyri-texniki bir adamın da başa düşəcəyi dashboard-a çevirirsən. Yaxşı dashboard rəqəmləri yox, **qərarı** göstərir.

## Başlamazdan əvvəl
- Əvvəlki tapşırıqların datası və nəticələri hazır olsun.
- Alət seç: Streamlit (Python), Plotly Dash, Power BI, Looker Studio və ya Tableau Public. Hamısı olar.

## Addımlar
1. Dataya baxıb ən vacib **3-5 insight (nəticə)** seç. İnsight "cədvəl" deyil, cümlədir. Məsələn: "Gəlirin 60%-i yalnız 2 kateqoriyadan gəlir."
2. Hər insight üçün bir sual → bir qrafik → bir cümlə nəticə ("so what") yaz.
3. Düzgün qrafik növünü seç:
   - Zamanla dəyişmə → **xətt (line)**
   - Kateqoriyaları müqayisə → **sütun (bar)**
   - Hissələrin payı → **pie** yalnız 5-dən az hissə üçün, əks halda bar
4. Ən azı 1-2 **filtr** əlavə et (tarix aralığı, kateqoriya).
5. Qrafiklərdə başlıq, ox adları və vahid olsun. Rəng sayını azalt.
6. Yanıldıcı qrafiklərdən qaç: oxu 0-dan başlat (bar-da), 3D qrafik işlətmə, bir qrafikdə həddindən artıq xətt qoyma.
7. Dashboard-un yuxarısında 2-3 əsas rəqəm (KPI kartı) göstər.
8. Dashboard-u yayımla (və ya ekran görüntüləri + video) və README yaz.

## Nə təqdim etməlisən
- Dashboard linki (və ya ekran görüntüləri)
- GitHub repozitoriya linki
- Qısa mətn: 3-5 insight-ın siyahısı

## Necə qiymətləndirilir
- İnsight-lar biznes baxımından məntiqlidir
- Qrafik növləri düzgün seçilib
- Filtrlər işləyir
- Dashboard yanıldıcı deyil və oxunaqlıdır
- Hər qrafikdən nə nəticə çıxdığı yazılıb

## Tez-tez edilən səhvlər
- Çox qrafik, az məna (5 yaxşı qrafik 15 pis qrafikdən yaxşıdır)
- Qırılmış ox ilə fərqi şişirtmək
- Qrafik qoyub nəticəni yazmamaq
$i$ WHERE id = 'b3000000-0000-4000-8000-000000000003';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Real bir biznes sualına data əsasında cavab verən tam analiz hazırlayırsan. Bu, data analitik portfoliosunun əsas işidir: sual → data → metod → nəticə → tövsiyə.

## Başlamazdan əvvəl
- Əvvəlki tapşırıqlardakı bacarıqlar (təmizləmə, SQL, vizuallaşdırma) lazımdır.
- Sualı mentorla razılaşdır. Yaxşı sual nümunəsi: "Hansı müştəri qrupu bizə ən çox gəlir gətirir və onları necə artıra bilərik?"

## Addımlar
1. **Sualı** bir cümlə ilə yaz və niyə vacib olduğunu izah et.
2. Dataseti seç (public və ya mentorun verdiyi), mənbəyini qeyd et.
3. Dataseti təmizlə və hansı addımları atdığını qeyd et.
4. Analiz et: SQL və ya Python ilə hesabla, qrafiklər çək.
5. **Metodologiyanı** izah et: hansı göstəricilərdən, hansı üsullardan istifadə etdin və niyə.
6. **Məhdudiyyətləri** açıq yaz. Məsələn: "Data yalnız 2023-ü əhatə edir", "Region məlumatı yoxdur".
7. **Tövsiyə ver:** nəticəyə əsasən biznes nə etməlidir (2-3 konkret addım).
8. Hesabatı 5-8 səhifə (və ya slayd) formatında hazırla: Sual → Data → Metod → Tapıntılar → Məhdudiyyətlər → Tövsiyə.

## Nə təqdim etməlisən
- Notebook (`.ipynb`) və ya GitHub linki
- Təmizlənmiş dataset
- Təqdimat/hesabat linki (PDF, Google Slides və ya Notion)

## Necə qiymətləndirilir
- Sual aydındır və cavab verilib
- Metodologiya düzgündür və izah olunub
- Məhdudiyyətlər dürüst şəkildə qeyd olunub
- Tövsiyələr nəticələrə əsaslanır
- Hesabat başa düşülən və səliqəlidir

## Tez-tez edilən səhvlər
- Sual qoyub cavab verməmək
- Korrelyasiyanı səbəb kimi təqdim etmək ("A artıb və B artıb, deməli A B-ni artırıb" demək)
- Məhdudiyyətləri gizlətmək
$i$ WHERE id = 'b3000000-0000-4000-8000-000000000004';

-- ---------------------------------------------------------
-- APPLIED AI
-- ---------------------------------------------------------

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Müştəri dəstəyi üçün modeldən hər dəfə eyni formatda (JSON) cavab alan etibarlı prompt hazırlayırsan. Real məhsulda AI cavabını proqram oxuyur, ona görə format sabit olmalıdır.

## Başlamazdan əvvəl
- Python əsasları və bir LLM API-si (Claude, Gemini, OpenAI və ya OpenRouter). API açarını `.env` faylında saxla, repoya yükləmə.
- JSON formatını bil.

## Addımlar
1. Giriş: müştəri mesajı. Çıxış (JSON schema) belə olsun:
   - `category`: `billing` / `technical` / `delivery` / `other`
   - `urgency`: `low` / `medium` / `high`
   - `summary`: 1 cümləlik xülasə
   - `suggested_reply`: müştəriyə təklif olunan cavab
2. Prompt-un **v1** versiyasını yaz (sadə təlimat).
3. **10 müxtəlif test mesajı** hazırla (aydın, qarışıq, qəzəbli, qısa, boş və ya mənasız mesajlar da daxil).
4. Hər mesajı modelə göndər və nəticəni cədvəldə qeyd et: mesaj, alınan cavab, düzgündür/səhvdir.
5. Cavabı Pydantic (və ya `json.loads` + yoxlama) ilə **yoxla**: format səhvdirsə proqram bunu tutsun.
6. Səhv cavabları analiz et və prompt-u yaxşılaşdır: **v2**, sonra **v3**. Nümunələr (few-shot) və aydın qaydalar əlavə et.
7. Versiyaları müqayisə et: v1, v2, v3-də neçə test düz cavab verdi.
8. README-də bunları göstər: prompt-un hər versiyası, test cədvəli, nəticə, nələrin işləmədiyi.

## Nə təqdim etməlisən
- GitHub repozitoriya linki (kod, promptlar, test nəticələri, README)

## Necə qiymətləndirilir
- Cavab hər dəfə düzgün JSON-dur
- 10 test nümunəsi müxtəlifdir və nəticələr qeyd olunub
- Ən azı 2 prompt versiyası müqayisə olunub
- Uğursuz hallar açıq yazılıb və təhlil olunub
- API açarı repoda yoxdur

## Tez-tez edilən səhvlər
- "Yalnız JSON qaytar" yazıb formatı yoxlamamaq
- Yalnız 2-3 asan nümunə ilə test etmək
- API açarını koda yazıb GitHub-a göndərmək
$i$ WHERE id = 'b4000000-0000-4000-8000-000000000001';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Sənədlərdən cavab tapıb mənbə ilə birlikdə qaytaran kiçik sual-cavab sistemi (RAG prototipi) qurursan. RAG = modelə cavab verməzdən əvvəl sənəddən uyğun parçaları tapıb verməkdir. Bu halda model uydurmur, sənədə əsaslanır.

## Başlamazdan əvvəl
- Python və bir LLM API-si. Embedding (mətni rəqəm vektoruna çevirmə) üçün API-nin embedding modelini istifadə et.
- Vektor saxlamaq üçün sadə `numpy` kifayətdir. İstəsən FAISS və ya Chroma işlət.
- 3-5 sənəd seç (PDF və ya mətn). Məsələn: universitet qaydaları, bir məhsulun təlimatı.

## Addımlar
1. Sənədləri oxu və **hissələrə böl (chunking)**: təxminən 300-500 söz, hissələr arasında bir az üst-üstə düşmə (overlap) olsun ki, cümlə ortadan kəsilməsin.
2. Hər hissə üçün **embedding** yarat və hissənin mətni və mənbə adı (fayl, səhifə) ilə birlikdə saxla.
3. İstifadəçi sual verəndə sualın da embedding-ini yarat və ən oxşar **3 hissəni** tap (cosine similarity).
4. Modelə bu 3 hissəni və sualı ver. Təlimat: "Yalnız verilmiş mətnə əsasən cavab ver. Cavab mətndə yoxdursa, bunu de."
5. Cavabı **mənbə ilə birlikdə** qaytar (məsələn: "Mənbə: qaydalar.pdf, səh. 3").
6. **"Cavab tapılmadı" halı:** ən yaxşı oxşarlıq balı müəyyən həddən aşağıdırsa (məsələn 0.5), modelə göndərmə və "Bu sualın cavabı sənədlərdə tapılmadı" yaz.
7. 10 sualla test et. Onlardan **ən azı 3-nün cavabı sənədlərdə olmasın**. Sistem uydurmamalıdır.
8. README-də arxitekturanı (qısa diaqram), seçdiyin chunk ölçüsünü və test nəticələrini yaz.

## Nə təqdim etməlisən
- GitHub repozitoriya linki (kod + README + test sualları və nəticələri)

## Necə qiymətləndirilir
- Chunking və embedding düzgün işləyir
- Cavab sənədə əsaslanır və mənbə göstərilir
- "Cavab tapılmadı" halı düzgün idarə olunur
- Cavabı sənəddə olmayan suallarda sistem uydurmur
- Testlər və nəticələr sənədləşdirilib

## Tez-tez edilən səhvlər
- Bütün sənədi tək hissə kimi modelə vermək
- Mənbə göstərməmək
- Cavabı tapılmayan suallarda modelin uydurmasına icazə vermək
$i$ WHERE id = 'b4000000-0000-4000-8000-000000000002';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
AI funksiyanın nə qədər yaxşı işlədiyini təxmin yox, **ölçü ilə** göstərirsən. Evaluation (qiymətləndirmə) AI məhsulunu təkmilləşdirmək üçün ən vacib bacarıqlardandır.

## Başlamazdan əvvəl
- Əvvəlki tapşırıqlardan birinin nəticəsini (məsələn, RAG prototipi və ya prompt) qiymətləndirəcəksən.
- Əsas anlayışlar:
  - **Correctness** — cavab düzdür?
  - **Relevance** — cavab suala aiddir?
  - **Groundedness** — cavab verilmiş mənbəyə əsaslanır, yoxsa uydurulub?
  - **Latency** — cavab neçə saniyəyə gəlir?

## Addımlar
1. Qiymətləndirəcəyin funksiyanı seç və 1 cümlə ilə təsvir et.
2. **Ən azı 20 test nümunəsi** hazırla: sual/giriş, gözlənilən düzgün cavab, kateqoriya (asan, çətin, cavabı olmayan, qeyri-müəyyən). Cədvəl formatında (CSV) saxla.
3. Hər nümunəni sistemdən keçir və cavabı, cavab müddətini (latency) yaz.
4. Bal vermə qaydası (rubric) yaz. Məsələn: 0 = səhv, 1 = qismən düz, 2 = tam düz. Eyni qaydanı bütün nümunələrə tətbiq et.
5. Hər nümunəyə 3 meyar üzrə bal ver: correctness, relevance, groundedness.
6. Nəticələri cədvəldə göstər: ortalama bal, ən pis 5 nümunə, orta latency.
7. **Uğursuz halları analiz et:** hansı növ suallarda səhv edir və niyə? Ən azı 3 səbəb yaz.
8. İki variantı müqayisə et (iki prompt və ya iki model) və hansının niyə yaxşı olduğunu yaz.
9. `report.md` yaz: məqsəd, test seti, meyarlar, nəticələr cədvəli, analiz, nəticə və növbəti addım.

## Nə təqdim etməlisən
- GitHub repozitoriya linki və ya hesabat faylı (`report.md`)
- Test seti (`eval_set.csv`) və nəticə cədvəli

## Necə qiymətləndirilir
- 20+ nümunə var və müxtəlifdir
- Meyarlar və bal vermə qaydası aydındır
- Nəticələr rəqəmlə göstərilib
- Uğursuz hallar təhlil olunub
- Müqayisə və nəticə məntiqlidir

## Tez-tez edilən səhvlər
- Yalnız asan nümunələr seçmək
- Meyarı izah etmədən bal vermək
- Uğursuzluqları gizlətmək (məqsəd mükəmməl göstərmək yox, düzgün ölçməkdir)
$i$ WHERE id = 'b4000000-0000-4000-8000-000000000003';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Real istifadəçi problemini həll edən AI funksiyanı tam məhsulun içinə (frontend + backend) qoşursan. Bu tapşırıq AI-nin təhlükəsizliyi, xərci və xəta halları ilə də işləməyi tələb edir.

## Başlamazdan əvvəl
- Əvvəlki tapşırıqların nəticələri (prompt, RAG, evaluation) lazımdır.
- Problemi sadə seç. Məsələn: "Kurs materialından suallara cavab ver", "Uzun mətni xülasə et", "Müştəri mesajını kateqoriyalara ayır".

## Addımlar
1. Problemi və istifadəçini 3 cümlə ilə yaz.
2. **Backend:** AI API-yə sorğunu serverdən göndər. API açarı heç vaxt brauzerə getməsin.
3. **Frontend:** istifadəçi giriş edir, nəticəni görür. Gözləmə zamanı yüklənmə göstəricisi olsun.
4. **Rate limit:** bir istifadəçi dəqiqədə ən çox N sorğu göndərə bilsin. Limit aşılanda aydın mesaj ver.
5. **Xəta idarəetməsi:** API cavab vermirsə (timeout, 429, 5xx) istifadəçiyə başa düşülən mesaj göstər və proqram çökməsin.
6. **Prompt injection müdafiəsi:** istifadəçi "əvvəlki təlimatları unut" kimi mətn göndərə bilər. Sistem təlimatı ilə istifadəçi mətnini ayrı yerdə ötür, modelin cavabını heç vaxt kod kimi icra etmə, çıxışı yoxla.
7. **Xərc hesabı:** orta sorğuda neçə token gedir, modelin qiyməti nədir, 1000 sorğunun təxmini qiyməti nə qədərdir. Bunu cədvəldə göstər.
8. `docs/ai-notes.md` faylı yaz: rate limit, xəta halları, injection riskləri, xərc.
9. Deploy et və README yaz.

## Nə təqdim etməlisən
- GitHub repozitoriya linki
- Canlı demo linki
- `docs/ai-notes.md` texniki qeydlər

## Necə qiymətləndirilir
- AI funksiyası real problemi həll edir və məhsulla inteqrasiya olunub
- API açarı serverdədir
- Rate limit və xəta idarəetməsi işləyir
- Prompt injection riskləri nəzərə alınıb
- Xərc hesabı və qeydlər dürüst və aydındır

## Tez-tez edilən səhvlər
- API açarını frontend kodunda saxlamaq
- Modelin cavabını yoxlamadan birbaşa göstərmək və ya icra etmək
- Xərci hesablamamaq
$i$ WHERE id = 'b4000000-0000-4000-8000-000000000004';

-- ---------------------------------------------------------
-- AUTOMATION
-- ---------------------------------------------------------

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Təkrarlanan manual bir prosesi addım-addım xəritələndirirsən. Avtomatlaşdırmadan əvvəl prosesi başa düşmək lazımdır. Yaxşı xəritə yarım iş deməkdir.

## Başlamazdan əvvəl
- Proses seç: gündəlik hesabat göndərmək, yoxlama cədvəli doldurmaq, sifarişləri Excel-ə köçürmək, qəbzləri toplamaq və s.
- Xəritə üçün alət: draw.io, Miro, Figma və ya kağızda çəkib şəkil çək.

## Addımlar
1. Prosesi seç və adını yaz. Məsələn: "Gündəlik yoxlama cədvəlinin doldurulması."
2. Prosesi özün 3 dəfə yerinə yetir və hər dəfə nə qədər vaxt çəkdiyini ölç. Ortalamanı hesabla.
3. Axın sxemi çək. Hər addım üçün qeyd et:
   - **Trigger:** proses nə vaxt başlayır?
   - **Giriş:** hansı məlumat və ya fayl lazımdır?
   - **Çıxış:** nəticə nədir?
   - **Alət:** hansı proqram istifadə olunur?
4. **Xəta nöqtələrini** qırmızı ilə qeyd et: harada ən çox səhv olur (əl ilə köçürmə, unutma, gecikmə).
5. Avtomatlaşdırma üçün ölçülə bilən məqsəd yaz. Məsələn: "Gündə 30 dəqiqəni 3 dəqiqəyə endirmək, səhvləri sıfırlamaq."
6. Hansı addımların avtomatlaşdırıla biləcəyini, hansılarının insan qərarı tələb etdiyini ayır.
7. Hamısını 1-2 səhifəlik PDF-də topla: proses təsviri, sxem, ölçülmüş vaxt, xəta nöqtələri, məqsəd.

## Nə təqdim etməlisən
- PDF və ya şəkil faylı (fayl yükləmə ilə göndər)

## Necə qiymətləndirilir
- Proses aydın təsvir olunub və gerçəkdir
- Sxem bütün addımları, giriş və çıxışları göstərir
- Vaxt real ölçülüb
- Xəta nöqtələri tapılıb
- Məqsəd ölçülə biləndir (rəqəmlə)

## Tez-tez edilən səhvlər
- Prosesi ölçmədən təxmini yazmaq
- Çox böyük proses seçmək (1-2 saatlıq bir prosesdən başla)
- Məqsədi "vaxtı azaltmaq" kimi qeyri-müəyyən yazmaq
$i$ WHERE id = 'b5000000-0000-4000-8000-000000000001';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Kənardan gələn məlumatı (webhook) qəbul edib, yoxlayıb, çevirib başqa servisə göndərən workflow qurursan. Avtomatlaşdırmanın əsas bloku budur.

## Başlamazdan əvvəl
- **Webhook** — başqa sistemin sənin ünvanına göndərdiyi avtomatik sorğudur (məsələn, formu dolduranda).
- Alət: **n8n** (vizual) və ya Python (FastAPI) seçə bilərsən.
- Məlumatı göndərəcəyin servis: Telegram bot, Google Sheets, Slack və ya Discord webhook.

## Addımlar
1. Ssenari seç. Məsələn: "Formdan yeni müraciət gəlir → məlumatı yoxla → Telegram-a bildiriş göndər."
2. Webhook endpoint-i yarat və JSON məlumat qəbul et.
3. **Yoxla (validate):** tələb olunan sahələr (məsələn `name`, `email`) varmı, email düzgün formatdadır? Yoxdursa `400` və aydın xəta qaytar.
4. **Çevir (transform):** lazımi sahələri seç, adlarını dəyiş, tarixi formata sal, mətni səliqəyə sal.
5. Nəticəni üçüncü tərəf API-yə göndər (məsələn, Telegram `sendMessage`).
6. **İki ssenarini test et:**
   - Uğurlu: düzgün məlumat → bildiriş gəlir
   - Uğursuz: yanlış və ya natamam məlumat → xəta cavabı qaytarılır, bildiriş getmir
7. Workflow-nu export et (n8n üçün JSON faylı, Python üçün repozitoriya).
8. Hər test üçün ekran görüntüsü çək.
9. README-də workflow-nun nə etdiyini, necə qurulduğunu və necə test olunduğunu yaz.

## Nə təqdim etməlisən
- GitHub repozitoriya linki (workflow export faylı və README)
- Test ekran görüntüləri (uğurlu və uğursuz hal)

## Necə qiymətləndirilir
- Webhook məlumatı qəbul edir və yoxlayır
- Çevirmə düzgündür
- Üçüncü tərəf servisə uğurla göndərir
- Uğurlu və uğursuz hallar test olunub
- Token və açarlar repoda açıq yazılmayıb

## Tez-tez edilən səhvlər
- Məlumatı yoxlamadan olduğu kimi göndərmək
- Bot tokenini və ya API açarını export faylında açıq saxlamaq
- Yalnız uğurlu halı test etmək
$i$ WHERE id = 'b5000000-0000-4000-8000-000000000002';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Workflow-nu etibarlı edirsən. Şəbəkə və xarici servislər bəzən işləmir. Yaxşı sistem müvəqqəti xətanı təkrar cəhd (retry) ilə aşır, daimi xətada isə dayanıb xəbər verir.

## Başlamazdan əvvəl
- Əvvəlki tapşırıqdakı workflow hazır olmalıdır.
- Xətaları fərqləndir:
  - **Müvəqqəti:** timeout, `429` (çox sorğu), `500/502/503` (server problemi). Təkrar cəhd kömək edə bilər.
  - **Daimi:** `400` (yanlış məlumat), `401/403` (icazə yoxdur), `404` (tapılmadı). Təkrar cəhd kömək etməz.

## Addımlar
1. Xəta növünü müəyyən edən funksiya yaz: status koda görə müvəqqəti, yoxsa daimi.
2. **Retry məntiqini** əlavə et:
   - Ən çox **3 cəhd**
   - Gözləmə artsın (exponential backoff): 1 san → 2 san → 4 san
   - Daimi xətada **dərhal dayan**, təkrar cəhd etmə
3. Cəhdlər bitəndən sonra da uğursuzdursa **bildiriş göndər** (Telegram, email və ya Slack). Mesajda nə baş verdi, hansı addımda və nə vaxt olduğu yazılsın.
4. **Log yaz:** start, uğur, hər retry, final uğursuzluq. Hər sətirdə tarix/saat, addım adı və status olsun. Fayla və ya JSON formatında yaz. Şifrə və tokeni log-a yazma.
5. Test üçün xətaları süni yarat: yanlış URL, səhv API açarı, məqsədli timeout. Hər halda sistemin nə etdiyini yoxla.
6. README-də cədvəl hazırla: xəta növü → sistem nə edir (retry/dayan/bildiriş).
7. Kodu GitHub-a göndər.

## Nə təqdim etməlisən
- GitHub repozitoriya linki (kod, nümunə log faylı, README cədvəli)

## Necə qiymətləndirilir
- Müvəqqəti və daimi xətalar düzgün ayrılır
- Retry limitli və gözləmə artımlıdır
- Uğursuz execution barədə bildiriş gəlir
- Loglar aydındır və hadisələri izləməyə kömək edir
- Xətalar test edilib

## Tez-tez edilən səhvlər
- Sonsuz retry (sistem qeyri-müəyyən müddət dayanır)
- Daimi xətada da təkrar cəhd etmək
- Bildiriş göndərmədən xətanı yalnız log-da qoymaq
$i$ WHERE id = 'b5000000-0000-4000-8000-000000000003';

UPDATE public.internship_tasks SET updated_at = NOW(), instructions = $i$
## Məqsəd
Real bir prosesi başdan sona avtomatlaşdırıb nəticənin nə qədər fayda verdiyini rəqəmlə göstərirsən. Bu, portfoliona qoyacağın əsas avtomatlaşdırma işidir.

## Başlamazdan əvvəl
- Əvvəlki tapşırıqlardan istifadə et: proses xəritəsi, webhook workflow, retry və monitorinq.
- Prosesi öz həyatından və ya tanıdığın bir kiçik biznesdən seç. Real proses daha güclü portfolio verir.

## Addımlar
1. Prosesi və problemi 3 cümlə ilə təsvir et: kim edir, nə qədər tez-tez, nə qədər vaxt aparır.
2. **Əvvəlki vaxtı ölç:** manual proses bir dəfə nə qədər çəkir? Həftədə neçə dəfə? Ümumi həftəlik vaxtı hesabla.
3. Avtomatlaşdırmanı qur: trigger, məlumatın yoxlanması, çevrilməsi, nəticənin göndərilməsi.
4. Retry, log və bildiriş mexanizmini əlavə et.
5. **Sonrakı vaxtı ölç:** avtomatlaşdırmadan sonra eyni proses nə qədər çəkir və neçə xəta olur?
6. Əvvəl/sonra cədvəli hazırla: vaxt, xəta sayı, aylıq qənaət.
7. **Arxitektura diaqramı** çək: hansı alətlər, məlumat hansı yolla gedir.
8. **Setup təlimatı** yaz: başqa adam sıfırdan quranda hansı addımları atmalıdır (hesablar, API açarları, import faylları, `.env.example`).
9. **Məhdudiyyətləri** qeyd et: hansı halda işləmir, nəyi insan yoxlamalıdır.
10. Qısa demo (1-2 dəqiqəlik video və ya ekran görüntüləri) əlavə et.

## Nə təqdim etməlisən
- Workflow export faylı və GitHub repozitoriya linki
- Arxitektura diaqramı
- Setup təlimatı (README)
- Əvvəl/sonra müqayisəsi və məhdudiyyətlər (README-də və ya ayrıca sənəddə)

## Necə qiymətləndirilir
- Proses real və avtomatlaşdırma işləyir
- Əvvəl/sonra nəticə rəqəmlə göstərilib
- Diaqram və setup təlimatı başqasının quraşdırması üçün kifayətdir
- Məhdudiyyətlər dürüst yazılıb
- Retry, log və xəta idarəetməsi var

## Tez-tez edilən səhvlər
- Qənaəti ölçmədən "çox vaxt qənaət etdim" yazmaq
- Setup təlimatı olmadan yalnız export faylı vermək
- Gizli açarları export faylında saxlamaq
$i$ WHERE id = 'b5000000-0000-4000-8000-000000000004';
