BEGIN;

UPDATE public.internship_tasks SET instructions = $m2$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Mobil tətbiqdə ekranlar arasında aydın naviqasiya quracaqsan ki, istifadəçi tapşırıq siyahısından detal və təqdimetmə ekranına keçə bilsin.

## 2. Başlamazdan əvvəl nə bilməlisən?
Task 1-dəki öz Expo layihən, React Native View/Text/Button əsasları və sadə state. Expo Go və ya emulator istifadə et.

## 3. Addım-addım təlimat
1. Öz Task 1 mobil repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Home, task list, task detail və submit ekranları yarat.
3. React Navigation və ya Expo Router-dan layihənə uyğun olanı seç; quraşdırma təlimatını izlə.
4. Hər ekrana aydın başlıq və geri qayıtma yolu əlavə et.
5. Tab/stack keçidlərini cihazda və ya emulatorda yoxla.
6. README-də run addımlarını və naviqasiya qərarlarını yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işləyən ekran keçidləri, ən azı 4 ekran screenshot-u və README. Geri düyməsi və əsas keçidlər ilişmədən işləməlidir.
[[EN]]
## 1. What is this task for?
Build clear navigation so a user can move from a task list to details and submission screens.

## 2. What should you know first?
Your own Expo project from Task 1, React Native View/Text/Button basics, and simple state. Use Expo Go or an emulator.

## 3. Step-by-step instructions
1. Continue your own mobile repository from Task 1; do not submit the intern.az repository.
2. Create Home, task-list, task-detail, and submission screens.
3. Choose React Navigation or Expo Router to fit your project and follow its setup instructions.
4. Add a clear title and a way to go back on each screen.
5. Test stack/tab navigation on a device or emulator.
6. Document startup steps and navigation decisions in the README.

## 4. What to submit
Your own GitHub repository link, working screen navigation, screenshots of at least four screens, and README. Back navigation and primary transitions must work reliably.$m2$ WHERE id='49d8bece-08d4-4b26-938a-6f48608f6e2b'::uuid AND task_number=2 AND status='published';

UPDATE public.internship_tasks SET instructions = $m3$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Mobil tətbiqdə təkrar istifadə edilən komponentlər yaradaraq ekranların eyni üslubda görünməsini təmin edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz mobil repo-n, React Native component və props anlayışları. Mövcud dizaynına uyğun düymə, status nişanı və boş vəziyyət komponentləri hazırla.

## 3. Addım-addım təlimat
1. Öz Task 1–2 layihəni davam etdir.
2. Button, StatusBadge və EmptyState komponentləri yarat.
3. Props ilə mətn, status, disabled və variantları idarə et.
4. Rəng və spacing dəyərlərini mərkəzləşdir.
5. Komponentləri ən azı iki ekranda istifadə et.
6. Normal/disabled/empty variantlarının screenshot-larını çək və README-ni yenilə.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, 3 reusable component, ən azı iki ekran istifadəsi və screenshot-lar. Komponentlərin görünüşü və davranışı ardıcıl olmalıdır.
[[EN]]
## 1. What is this task for?
Create reusable mobile components so screens share a consistent style.

## 2. What should you know first?
Your own mobile repository and React Native components/props. Build button, status badge, and empty-state components that fit your design.

## 3. Step-by-step instructions
1. Continue your own project from Tasks 1–2.
2. Create Button, StatusBadge, and EmptyState components.
3. Use props to control text, status, disabled state, and variants.
4. Centralize color and spacing values.
5. Reuse the components on at least two screens.
6. Capture screenshots of normal/disabled/empty variants and update the README.

## 4. What to submit
Your own GitHub repository link, three reusable components, use on at least two screens, and screenshots. Components must behave and look consistently.$m3$ WHERE id='54474fdc-9ea7-4b4a-8acf-c42f7d8b1144'::uuid AND task_number=3 AND status='published';

UPDATE public.internship_tasks SET instructions = $m4$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Tapşırıq siyahısını mock API-dən yükləyəcək və loading, empty, success və error vəziyyətlərini mobil ekranda göstərəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz mobil layihən, async/await, JSON və React Native list komponentləri. Real API açarı tələb olunmayan mock data ilə başla.

## 3. Addım-addım təlimat
1. Öz əvvəlki mobil repo-nu davam etdir.
2. Task üçün TypeScript type və sintetik JSON data hazırla.
3. Siyahını FlatList ilə göstər.
4. Loading, empty, error və retry vəziyyətləri əlavə et.
5. Yavaş cavab və şəbəkə xətasını mock et; retry dublikat sorğu yaratmasın.
6. Hər vəziyyət üçün test və screenshot əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işləyən API list ekranı, mock adapter, dörd vəziyyətin screenshot-u və testlər. Boş nəticə ilə xəta fərqli izah olunmalıdır.
[[EN]]
## 1. What is this task for?
Load a task list from a mock API and show loading, empty, success, and error states on mobile.

## 2. What should you know first?
Your own mobile project, async/await, JSON, and React Native list components. Start with mock data that needs no real API key.

## 3. Step-by-step instructions
1. Continue your own mobile repository.
2. Define a TypeScript task type and synthetic JSON data.
3. Render the list with FlatList.
4. Add loading, empty, error, and retry states.
5. Mock slow responses and network failures; retry must not create duplicate requests.
6. Add tests and screenshots for each state.

## 4. What to submit
Your own GitHub repository link, working API-list screen, mock adapter, screenshots of four states, and tests. Empty results and errors must be explained differently.$m4$ WHERE id='cdc3d1f1-d11b-4e4f-9b01-1b8942f6323f'::uuid AND task_number=4 AND status='published';

UPDATE public.internship_tasks SET instructions = $m5$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Mobil task siyahısına axtarış və status filter-i əlavə edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz əvvəlki mobil layihən, React state, input və list filter əsasları.

## 3. Addım-addım təlimat
1. Öz mobil repo-nu davam etdir.
2. Search input və status filter əlavə et.
3. Filter-ləri birlikdə tətbiq et və nəticə yoxdursa empty state göstər.
4. Klaviatura açıq olanda nəticə siyahısının istifadəsini yoxla.
5. Böyük sintetik siyahı ilə performansı yoxla.
6. Axtarış, filter və boş nəticə üçün test yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, axtarış/filter funksiyası, testlər və screenshot-lar. Filter dəyişdikdə nəticələr düzgün yenilənməlidir.
[[EN]]
## 1. What is this task for?
Add search and status filtering to the mobile task list.

## 2. What should you know first?
Your existing mobile project, React state, inputs, and basic list filtering.

## 3. Step-by-step instructions
1. Continue your own mobile repository.
2. Add a search input and status filter.
3. Combine filters and show an empty state when nothing matches.
4. Check that the list remains usable while the keyboard is open.
5. Check performance with a larger synthetic list.
6. Test search, filtering, and empty results.

## 4. What to submit
Your own GitHub repository link, search/filter feature, tests, and screenshots. Results must update correctly when filters change.$m5$ WHERE id='414e19fd-55bf-4f5e-946b-58963f84756c'::uuid AND task_number=5 AND status='published';

UPDATE public.internship_tasks SET instructions = $m6$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
İstifadəçinin seçdiyi sadə parametri tətbiq bağlanıb açılandan sonra da saxlamağı öyrənəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz mobil layihən, async storage anlayışı və state lifecycle. Token, parol və digər həssas məlumatı sadə local storage-da saxlama.

## 3. Addım-addım təlimat
1. Öz mobil repo-nu davam etdir.
2. Saxlanacaq həssas olmayan seçim seç, məsələn, tema və ya son filter.
3. AsyncStorage və ya layihənin uyğun storage həllindən istifadə et.
4. İlk açılışda default dəyər, saxlanmış dəyər və storage xətası hallarını idarə et.
5. Tətbiqi bağlayıb açaraq dəyərin bərpa olunduğunu yoxla.
6. Storage davranışı üçün test və README qeydi əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, persistence implementasiyası, testlər və screenshot/demo. Həssas məlumat saxlanmamalı, storage xətası tətbiqi çökdürməməlidir.
[[EN]]
## 1. What is this task for?
Persist a simple user preference after the app closes and reopens.

## 2. What should you know first?
Your own mobile project, async storage, and state lifecycle. Do not store passwords, tokens, or other sensitive data in simple local storage.

## 3. Step-by-step instructions
1. Continue your own mobile repository.
2. Choose a non-sensitive preference such as theme or last-used filter.
3. Use AsyncStorage or an appropriate storage solution for the project.
4. Handle first launch, saved values, and storage errors.
5. Close and reopen the app to confirm the value is restored.
6. Add a test and document storage behavior in the README.

## 4. What to submit
Your own GitHub repository link, persistence implementation, tests, and screenshot/demo. Do not store sensitive data, and storage errors must not crash the app.$m6$ WHERE id='e60b4449-61e9-4623-8d12-ac52e077f312'::uuid AND task_number=6 AND status='published';

UPDATE public.internship_tasks SET instructions = $m7$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Mobil müraciət formuna aydın validation və istifadəçiyə kömək edən xəta mesajları əlavə edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz mobil repo-n, form input-ları, validation və async submit anlayışları.

## 3. Addım-addım təlimat
1. Öz layihəni davam etdir.
2. Məcburi sahələri və uzunluq/format qaydalarını müəyyən et.
3. Xətanı sahənin yanında göstər və focus-u uyğun sahəyə yönəlt.
4. Submit zamanı loading/disabled və success/error vəziyyətlərini qur.
5. Uğursuz submit-dən sonra daxil edilmiş məlumatı saxla.
6. Valid, invalid, server error və double-submit ssenarilərini test et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, form və validation qaydaları, ən azı 4 test ssenarisi və mobil screenshot. Xəta səbəbi aydın olmalı və double-submit dublikat yaratmamalıdır.
[[EN]]
## 1. What is this task for?
Add clear validation and helpful error messages to a mobile application form.

## 2. What should you know first?
Your own mobile repository, form inputs, validation, and asynchronous submission.

## 3. Step-by-step instructions
1. Continue your own project.
2. Define required fields and length/format rules.
3. Show errors next to fields and move focus to the relevant field when appropriate.
4. Add loading/disabled and success/error states during submission.
5. Preserve entered values after a failed submission.
6. Test valid input, invalid input, server errors, and double submission.

## 4. What to submit
Your own GitHub repository link, form and validation rules, at least four test scenarios, and a mobile screenshot. Errors must be clear and double submission must not create duplicates.$m7$ WHERE id='b55d72e1-d106-4dd1-9324-f2642b03cdba'::uuid AND task_number=7 AND status='published';

UPDATE public.internship_tasks SET instructions = $m8$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Şəbəkə olmayanda tətbiqin davranışını aydın edəcək və son məlum məlumatı təhlükəsiz göstərəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz mobil layihən, API loading/error state-ləri və lokal cache əsasları. Həssas məlumatı cache etmə.

## 3. Addım-addım təlimat
1. Öz mobil repo-nu davam etdir.
2. Şəbəkə statusunu və request xətasını ayırd et.
3. Offline banner və retry action əlavə et.
4. Əvvəldən yüklənmiş sintetik task siyahısını son məlum data kimi göstərə bilərsən; köhnə olduğunu işarələ.
5. Offline → online keçidi, request timeout və cache boş vəziyyətini test et.
6. README-də offline məhdudiyyətləri və data yenilənmə qaydasını yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, offline state UI, retry/cache davranışı, testlər və screenshot-lar. İstifadəçi şəbəkə olmayanda niyə məlumatın yenilənmədiyini anlamalıdır.
[[EN]]
## 1. What is this task for?
Make the app's behavior clear when there is no network and safely show the last known data when available.

## 2. What should you know first?
Your own mobile project, API loading/error states, and basic local caching. Do not cache sensitive data.

## 3. Step-by-step instructions
1. Continue your own mobile repository.
2. Distinguish offline status from a request error.
3. Add an offline banner and retry action.
4. You may show a previously loaded synthetic task list as last-known data, clearly marked as potentially stale.
5. Test offline-to-online recovery, request timeout, and an empty cache.
6. Document offline limitations and refresh behavior in the README.

## 4. What to submit
Your own GitHub repository link, offline UI, retry/cache behavior, tests, and screenshots. Users must understand why data cannot be refreshed offline.$m8$ WHERE id='baadc0db-a3ee-4669-9d65-1f95de737d14'::uuid AND task_number=8 AND status='published';

UPDATE public.internship_tasks SET instructions = $m9$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Mobil tətbiqin əsas axınını real istifadəçilərlə yoxlayıb anlaşılmayan addımları tapacaqsan.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz işlək prototip/tətbiqin, neytral test tapşırıqları və razılıq alma qaydası. Mümkünsə 3–5 iştirakçı ilə sına.

## 3. Addım-addım təlimat
1. Öz mobil layihəni davam etdir.
2. Task tapmaq, detallara baxmaq və həll təqdim etmək üçün 3 test ssenarisi yaz.
3. İştirakçıdan tətbiqi özünün istifadə etməsini istə; addımları izah edib cavabı yönləndirmə.
4. Vaxt, səhv klik və kömək ehtiyacını anonim qeyd et.
5. Ən azı 5 tapıntını təsirə görə sırala.
6. Bir düzəliş et və retest nəticəsini qeyd et.

## 4. Təhvil veriləcək nəticə
Test planı, iştirakçı sayı, anonim müşahidələr, 5+ tapıntı, düzəliş və retest sübutu. Razılıq olmadan qeyd aparma və lazımsız şəxsi məlumat toplama.
[[EN]]
## 1. What is this task for?
Test the mobile app's main flow with users and identify confusing steps.

## 2. What should you know first?
Your working prototype/app, neutral test tasks, and consent basics. Aim for three to five participants when possible.

## 3. Step-by-step instructions
1. Continue your own mobile project.
2. Write three test scenarios: find a task, view details, and submit a solution.
3. Ask participants to use the app themselves; do not guide their answers.
4. Record time, misclicks, and requests for help anonymously.
5. Rank at least five findings by impact.
6. Make one improvement and record the retest result.

## 4. What to submit
A test plan, participant count, anonymized observations, five or more findings, a fix, and retest evidence. Do not record without consent or collect unnecessary personal data.$m9$ WHERE id='c3bdab9b-0a94-40da-891d-246116d15418'::uuid AND task_number=9 AND status='published';

UPDATE public.internship_tasks SET instructions = $m10$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Əvvəlki tapşırıqları birləşdirib quraşdırıla bilən, test edilmiş və sənədləşdirilmiş mobil tətbiq təqdim edəcəksən.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz Task 1–9 layihən, navigation, reusable components, API states, storage, form validation və testlər.

## 3. Addım-addım təlimat
1. Əvvəlki mobil tapşırıqlarındakı öz repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Naviqasiya, task list/detail, search/filter və submission axınını birləşdir.
3. Loading, empty, error və offline vəziyyətlərini əlavə et.
4. Həssas olmayan seçimi saxla və form validation-u yoxla.
5. Ən azı 8 uyğun test yaz və cihaz/emulatorda əsas axını yoxla.
6. Fresh setup addımları, screenshot-lar, məlum məhdudiyyətlər və qısa demo əlavə et.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işləyən Expo tətbiqi, test nəticələri, ekran görüntüləri və README. Quraşdırma təlimatı təkrarlana bilməli, secret-lər repo-da olmamalıdır.
[[EN]]
## 1. What is this task for?
Combine earlier work into a runnable, tested, and documented mobile application.

## 2. What should you know first?
Your own project from Tasks 1–9: navigation, reusable components, API states, storage, form validation, and tests.

## 3. Step-by-step instructions
1. Continue your own repository from earlier mobile tasks; do not submit the intern.az repository.
2. Combine navigation, task list/detail, search/filter, and submission.
3. Include loading, empty, error, and offline states.
4. Persist a non-sensitive preference and verify form validation.
5. Write at least eight relevant tests and check the main flow on a device/emulator.
6. Add fresh-setup instructions, screenshots, known limitations, and a short demo.

## 4. What to submit
Your own GitHub repository link, working Expo app, test results, screenshots, and README. Setup must be repeatable and the repository must contain no secrets.$m10$ WHERE id='5beeee94-15be-4ded-a073-2460ed601d0e'::uuid AND task_number=10 AND status='published';

COMMIT;
