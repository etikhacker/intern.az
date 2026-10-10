BEGIN;

UPDATE public.internship_tasks SET instructions = $d2$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
SQL ilə əsas KPI-ları hesablayıb biznes sualına cavab verəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Task 1-dəki öz data repo-n, SELECT, WHERE, GROUP BY, JOIN və aggregate funksiyalarının əsasları. Yalnız sintetik məlumat istifadə et.

## 3. Addım-addım təlimat
1. Öz data repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Layihə/müraciət kimi bir mövzu üçün sintetik cədvəl və ən azı 100 sətir hazırla.
3. 3–5 KPI müəyyən et və hər KPI-nın biznes mənasını izah et.
4. SQL sorğuları ilə KPI-ları hesabla; NULL və duplicate halları yoxla.
5. Nəticələri cədvəldə göstər və hesablamaları manual sample ilə yoxla.
6. Sorğuları və data dictionary-ni README-də sənədləşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, schema/seed data, SQL faylları, KPI cədvəli və izah. KPI-lar təkrar hesablana bilməli və formulaları aydın olmalıdır.
[[EN]]
## 1. What is this task for?
Calculate key performance indicators (KPIs) with SQL and answer a business question.

## 2. What should you know first?
Your data repository from Task 1, basic SELECT, WHERE, GROUP BY, JOIN, and aggregate functions. Use synthetic data only.

## 3. Step-by-step instructions
1. Continue your own data repository; do not submit the intern.az repository.
2. Create a synthetic table with at least 100 rows for a topic such as projects/applications.
3. Define three to five KPIs and explain their business meaning.
4. Calculate KPIs with SQL and check NULL/duplicate cases.
5. Present results in a table and verify calculations with a manual sample.
6. Document queries and the data dictionary in the README.

## 4. What to submit
Your own GitHub repository link, schema/seed data, SQL files, KPI table, and explanation. KPIs must be reproducible with clear formulas.$d2$ WHERE id='b3000000-0000-4000-8000-000000000002'::uuid AND task_number=2 AND status='published';

UPDATE public.internship_tasks SET instructions = $d3$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
KPI-ları istifadəçinin tez anlaya biləcəyi dashboard-a çevirəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz KPI sorğuların, cədvəl/chart əsasları və dashboard aləti (Excel, Google Sheets, Python və ya başqa pulsuz alət).

## 3. Addım-addım təlimat
1. Öz data repo-nu davam etdir.
2. Task 2-də hesabladığın KPI-lardan 3–5-ni seç.
3. Hər KPI üçün uyğun vizual seç; müqayisə üçün bar chart, zaman üzrə dəyişiklik üçün line chart istifadə edə bilərsən.
4. Filtr və tarix aralığı varsa, onun nəticəyə təsirini aydın göstər.
5. Başlıq, vahid, mənbə və yenilənmə vaxtını qeyd et.
6. Chart-ların rəqəmlərini SQL nəticəsi ilə müqayisə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, dashboard faylı/linki, screenshot və KPI izahları. Qrafiklər düzgün etiketlənməli və rəqəmlər sorğu nəticələri ilə uyğun olmalıdır.
[[EN]]
## 1. What is this task for?
Turn your KPIs into a dashboard that users can understand quickly.

## 2. What should you know first?
Your KPI queries, basic tables/charts, and a dashboard tool such as Excel, Google Sheets, Python, or another free tool.

## 3. Step-by-step instructions
1. Continue your own data repository.
2. Choose three to five KPIs from Task 2.
3. Select suitable visuals; for example, bars for comparisons and lines for trends over time.
4. If you add filters/date ranges, show how they affect the results.
5. Label titles, units, data source, and refresh time.
6. Compare chart values with the SQL results.

## 4. What to submit
Your own GitHub repository link, dashboard file/link, screenshot, and KPI explanations. Charts must be clearly labelled and match the query results.$d3$ WHERE id='b3000000-0000-4000-8000-000000000003'::uuid AND task_number=3 AND status='published';

UPDATE public.internship_tasks SET instructions = $d4$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Məlumatdan biznes sualına cavab verən tam case study hazırlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz Task 1–3 data layihən, SQL/Python və dashboard nəticələri. Analiz üçün uydurma məlumatdan istifadə edə bilərsən.

## 3. Addım-addım təlimat
1. Əvvəlki tapşırıqları öz repo-n və ya notebook-da davam etdir.
2. Bir konkret biznes sualı və 2–3 yoxlanıla bilən hipotez yaz.
3. Data quality yoxlaması və exploratory analysis apar.
4. KPI və dashboard qur, tapıntıların datadan necə çıxdığını göstər.
5. Məhdudiyyətləri və səbəb-nəticə iddiasının mümkün olub-olmadığını qeyd et.
6. Nəticələri qeyri-texniki oxucu üçün qısa hesabat kimi yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, təkrar icra edilən notebook/SQL, dashboard, əsas tapıntılar və məhdudiyyətləri göstərən case-study hesabatı. Dəstəklənməyən nəticə çıxarma.
[[EN]]
## 1. What is this task for?
Create a complete case study that answers a business question using data.

## 2. What should you know first?
Your data project from Tasks 1–3, SQL/Python, and dashboard results. Fictional data is acceptable.

## 3. Step-by-step instructions
1. Continue earlier work in your own repository or notebook.
2. State one business question and two or three testable hypotheses.
3. Check data quality and perform exploratory analysis.
4. Build KPIs and a dashboard, showing how findings follow from the data.
5. State limitations and whether causal claims can be justified.
6. Write a concise report for a non-technical reader.

## 4. What to submit
Your own GitHub repository link, reproducible notebook/SQL, dashboard, key findings, and case-study report with limitations. Do not make unsupported claims.$d4$ WHERE id='b3000000-0000-4000-8000-000000000004'::uuid AND task_number=4 AND status='published';

UPDATE public.internship_tasks SET instructions = $d5$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Analizdən əvvəl məlumatın formatını və keyfiyyətini yoxlayıb etibarlı dataset hazırlayacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz data repo-n, CSV, data types, missing value və duplicate anlayışları. Sintetik və ya açıq lisenziyalı data istifadə et.

## 3. Addım-addım təlimat
1. Öz data layihəni davam etdir.
2. Ən azı 100 sətirlik CSV seç və sütunları izah edən data dictionary yaz.
3. Missing, duplicate, invalid date və yanlış formatları yoxla.
4. Hər problem üçün qayda müəyyən et və niyə seçdiyini yaz.
5. Orijinal faylı saxla, təmizlənmiş faylı ayrıca yarat.
6. Əvvəl/sonra row count və quality summary müqayisə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, orijinal və təmiz data, data dictionary, validation qaydaları və əvvəl/sonra hesabatı. Orijinal məlumat səssizcə dəyişdirilməməlidir.
[[EN]]
## 1. What is this task for?
Check data formats and quality before analysis and create a reliable dataset.

## 2. What should you know first?
Your data repository, CSV files, data types, missing values, and duplicates. Use synthetic or openly licensed data.

## 3. Step-by-step instructions
1. Continue your own data project.
2. Choose a CSV with at least 100 rows and write a data dictionary.
3. Check missing values, duplicates, invalid dates, and inconsistent formats.
4. Define a rule for each issue and explain why you chose it.
5. Preserve the original file and create a separate cleaned version.
6. Compare row counts and quality summaries before/after.

## 4. What to submit
Your own GitHub repository link, original and cleaned data, data dictionary, validation rules, and before/after report. Never silently overwrite the original data.$d5$ WHERE id='9e091eb6-fdad-43ca-9b22-91e5d0e8a480'::uuid AND task_number=5 AND status='published';

UPDATE public.internship_tasks SET instructions = $d6$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Dataset-in əsas paylanmalarını və qeyri-adi dəyərlərini araşdırıb yoxlanıla bilən insight-lar tapacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz təmiz data faylın, Python/pandas və ya spreadsheet, orta/median və chart əsasları.

## 3. Addım-addım təlimat
1. Öz data repo-nu davam etdir.
2. Əsas sütunlar üçün summary statistics hesabla.
3. Kateqoriyalar və zaman üzrə paylanmanı qrafiklə göstər.
4. Outlier və missing value-ları araşdır; onları avtomatik silmə.
5. Ən azı 3 tapıntı yaz və hər birini cədvəl/qrafiklə əsaslandır.
6. Hər tapıntının məhdudiyyətini qeyd et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, təkrar icra edilən notebook/script, ən azı 3 vizual, tapıntı izahları və məhdudiyyətlər. Qrafiklər düzgün etiketlənməlidir.
[[EN]]
## 1. What is this task for?
Explore distributions and unusual values in a dataset to find verifiable insights.

## 2. What should you know first?
Your cleaned data, Python/pandas or a spreadsheet, summary statistics, and basic charts.

## 3. Step-by-step instructions
1. Continue your own data repository.
2. Calculate summary statistics for key columns.
3. Visualize distributions by category and over time.
4. Investigate outliers and missing values; do not automatically delete them.
5. Write at least three findings and support each with a table/chart.
6. State limitations for each finding.

## 4. What to submit
Your own GitHub repository link, reproducible notebook/script, at least three visuals, findings, and limitations. Charts must be clearly labelled.$d6$ WHERE id='b70342a3-3eff-4019-879e-68c44422ec75'::uuid AND task_number=6 AND status='published';

UPDATE public.internship_tasks SET instructions = $d7$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
İstifadəçi qruplarının zamanla necə dəyişdiyini müqayisə edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz data repo-n, tarix sahələri, qruplaşdırma və faiz hesablamaları. Cohort tərifini əvvəlcədən müəyyən et.

## 3. Addım-addım təlimat
1. Öz data layihəni davam etdir.
2. Cohort-u necə müəyyən etdiyini yaz, məsələn, ilk aktivlik ayı.
3. Hər cohort üçün sonrakı dövrlərdə aktivlik/retention göstəricisi hesabla.
4. Kiçik sample və çatışmayan tarixlərin təsirini yoxla.
5. Cohort cədvəli və ən azı bir heatmap/line chart hazırla.
6. Nəticəni ehtiyatla izah et; müşahidə olunan fərqi səbəb kimi təqdim etmə.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, cohort SQL/notebook, nəticə cədvəli, vizual və metod izahı. Cohort tərifi və denominator aydın göstərilməlidir.
[[EN]]
## 1. What is this task for?
Compare how groups of users change over time.

## 2. What should you know first?
Your data repository, date fields, grouping, and percentage calculations. Define the cohort before analysing.

## 3. Step-by-step instructions
1. Continue your own data project.
2. Define the cohort, such as the month of first activity.
3. Calculate later activity/retention for each cohort.
4. Check the effect of small samples and missing dates.
5. Create a cohort table and at least one heatmap/line chart.
6. Interpret results carefully; do not claim observed differences prove causation.

## 4. What to submit
Your own GitHub repository link, cohort SQL/notebook, results table, visualization, and method explanation. Clearly define the cohort and denominator.$d7$ WHERE id='2a2f742e-2d51-4846-82e4-82d0739d4ba1'::uuid AND task_number=7 AND status='published';

UPDATE public.internship_tasks SET instructions = $d8$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Dashboard-u düzgünlük, oxunaqlıq və istifadəçi ehtiyacları baxımından audit edib yaxşılaşdıracaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz dashboard-un, KPI tərifləri, chart seçimi və accessibility əsasları.

## 3. Addım-addım təlimat
1. Öz dashboard layihəni davam etdir.
2. Hər KPI-nın formulunu, vahidini, mənbəsini və yenilənmə tarixini yoxla.
3. Yanlış vizual, kəsilmiş label, yanlış scale və confusing color istifadəsini axtar.
4. Keyboard/contrast və mobil ölçülərdə oxunaqlığı yoxla.
5. Ən azı 5 finding-i təsir və düzəlişlə qeyd et.
6. Ən vacib 2 düzəlişi tətbiq edib əvvəl/sonra screenshot əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin/dashboard faylı, 5+ finding, iki düzəliş və əvvəl/sonra screenshot-lar. Rəqəmlər source data ilə uyğun olmalıdır.
[[EN]]
## 1. What is this task for?
Audit and improve a dashboard for accuracy, readability, and user needs.

## 2. What should you know first?
Your dashboard, KPI definitions, chart selection, and accessibility basics.

## 3. Step-by-step instructions
1. Continue your own dashboard project.
2. Check each KPI's formula, unit, source, and refresh date.
3. Look for misleading visuals, clipped labels, incorrect scales, and confusing color use.
4. Check keyboard/contrast and readability on mobile.
5. Record at least five findings with impact and proposed fixes.
6. Apply the two most important fixes and add before/after screenshots.

## 4. What to submit
Your own GitHub repository/dashboard file, five or more findings, two fixes, and before/after screenshots. Values must match the source data.$d8$ WHERE id='e4b0ca78-a322-4d10-b55a-c473c6dbeaba'::uuid AND task_number=8 AND status='published';

UPDATE public.internship_tasks SET instructions = $d9$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Analiz nəticələrini texniki olmayan auditoriya üçün aydın hekayəyə çevirəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz analiz nəticələrin, qrafiklər və əsas tapıntılar. Səbəb-nəticə barədə sübut yoxdursa, əlaqəni səbəb kimi təqdim etmə.

## 3. Addım-addım təlimat
1. Öz data repo-nu davam etdir.
2. Auditoriyanı və onların qərar ehtiyacını müəyyən et.
3. Əsas sualı, 3 tapıntını və tövsiyəni seç.
4. Hər tapıntı üçün data sübutu və məhdudiyyət göstər.
5. Qısa report/slayd və ya notebook narrative hazırla.
6. Başqa birinə oxut və anlaşılmayan terminləri sadələşdir.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, 1–3 səhifəlik report/slayd, vizuallar və tövsiyələr. Hər iddia konkret nəticə ilə dəstəklənməlidir.
[[EN]]
## 1. What is this task for?
Turn analysis results into a clear story for a non-technical audience.

## 2. What should you know first?
Your analysis, charts, and main findings. Do not describe correlation as causation without evidence.

## 3. Step-by-step instructions
1. Continue your own data repository.
2. Define the audience and the decision they need to make.
3. Choose the main question, three findings, and a recommendation.
4. Support each finding with data evidence and a limitation.
5. Prepare a short report/slides or a narrative notebook.
6. Ask someone to read it and simplify unclear terminology.

## 4. What to submit
Your own GitHub repository link, a one-to-three-page report/slides, visuals, and recommendations. Every claim must be supported by a concrete result.$d9$ WHERE id='196695ad-b5bb-4e68-be12-e17d9433051b'::uuid AND task_number=9 AND status='published';

UPDATE public.internship_tasks SET instructions = $d10$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Analizi başqa şəxsin də eyni nəticəni ala biləcəyi şəkildə təşkil edib sənədləşdirəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz Task 1–9 data layihən, notebook/SQL, dependency və data-source sənədləşdirməsi.

## 3. Addım-addım təlimat
1. Əvvəlki analizləri öz repo-n və ya notebook-da davam etdir.
2. Qovluq quruluşunu, data source-u və quraşdırma addımlarını README-də yaz.
3. Orijinal data və transform edilmiş data fərqini saxla; şəxsi/həssas məlumatı repo-ya yükləmə.
4. Notebook-u təmiz kernel-dən başdan sona işə sal.
5. SQL, data cleaning, chart və nəticələrin eyni qaydada yarandığını yoxla.
6. Məlum limitlər və növbəti 3 təkmilləşdirməni qeyd et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, təkrar icra edilən notebook/SQL, README, data dictionary, nəticə faylları və clean-run sübutu. Başqa şəxs quraşdırma addımları ilə nəticəni təkrar yarada bilməlidir.
[[EN]]
## 1. What is this task for?
Organize and document the analysis so another person can reproduce the same results.

## 2. What should you know first?
Your data project from Tasks 1–9, notebooks/SQL, dependencies, and data-source documentation.

## 3. Step-by-step instructions
1. Continue earlier analysis in your own repository or notebook.
2. Document folder structure, data source, and setup in the README.
3. Keep original and transformed data distinct; never commit personal/sensitive data.
4. Run the notebook from top to bottom in a clean kernel.
5. Verify SQL, cleaning, charts, and results are reproduced consistently.
6. Record known limitations and the next three improvements.

## 4. What to submit
Your own GitHub repository link, reproducible notebook/SQL, README, data dictionary, output files, and clean-run evidence. Another person must be able to reproduce the results by following the setup steps.$d10$ WHERE id='fe38e38c-fbaa-4800-8756-0e25d1306ab8'::uuid AND task_number=10 AND status='published';

COMMIT;
