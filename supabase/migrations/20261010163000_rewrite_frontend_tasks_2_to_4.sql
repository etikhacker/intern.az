BEGIN;

UPDATE public.internship_tasks SET instructions = $task2$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Dörd təkrar istifadə edilən UI komponenti hazırlayacaqsan: Button, TextField, StatusBadge və EmptyState. Məqsəd görünüşü, davranışı və əlçatanlığı ardıcıl saxlamaqdır.

## 2. Başlamazdan əvvəl nə bilməlisən?
Task 1-dəki öz frontend repo-n, HTML/CSS, React komponentləri və TypeScript-in əsasları. VS Code-da layihəni aç və layihənin lock faylına uyğun package manager-dən istifadə et.

## 3. Addım-addım təlimat
1. Task 1-də yaratdığın öz repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Hər komponentin props və variantlarını yaz. Məsələn, Button üçün primary/secondary, loading və disabled.
3. Rəng, aralıq və şrift dəyərlərini təkrar istifadə edilən token-larda saxla.
4. TextField üçün görünən label, köməkçi mətn və xətanı düzgün əlaqələndir.
5. Bütün variantları göstərən demo səhifəsi yarat və ən azı 6 UI testi yaz.
6. Mövcud test/lint/build əmrlərini yoxla və varsa işlət. README-də quraşdırma və istifadə qaydasını yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, 4 komponent və TypeScript props-ları, demo screenshot-u, ən azı 6 test və qısa istifadə təlimatı. Xəta təkcə rənglə göstərilməməli, variantlar isə aydın props/token-larla idarə olunmalıdır.
[[EN]]
## 1. What is this task for?
Build four reusable UI components: Button, TextField, StatusBadge, and EmptyState. Keep their appearance, behavior, and accessibility consistent.

## 2. What should you know first?
Your own frontend repository from Task 1, basic HTML/CSS, React components, and introductory TypeScript. Open it in VS Code and use the package manager indicated by the lockfile.

## 3. Step-by-step instructions
1. Continue your own repository from Task 1; do not submit the intern.az repository.
2. Define each component's props and variants, such as primary/secondary, loading, and disabled for Button.
3. Store reusable colors, spacing, and typography as tokens.
4. Associate TextField labels, helper text, and errors correctly.
5. Create a demo page showing every variant and write at least six UI tests.
6. Check available test/lint/build scripts and run them when present. Document setup and usage in the README.

## 4. What to submit
Your own GitHub repository link, four components with TypeScript props, a demo screenshot, at least six tests, and a short usage guide. Errors must not be conveyed by color alone, and variants should use clear props/tokens.$task2$ WHERE id = 'b1000000-0000-4000-8000-000000000002'::uuid AND task_number = 2 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task3$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Koordinator panelində müraciət sayını və son müraciətləri göstərəcək dashboard-u mock API-yə bağlayacaqsan. Uğurlu cavab, boş siyahı, giriş xətası və server xətası fərqli göstərilməlidir.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz frontend repo-n, React state/effect, TypeScript tipləri, API sorğuları və komponent testlərinin əsasları. Real tələbə məlumatı yox, sintetik test məlumatı işlət.

## 3. Addım-addım təlimat
1. Task 2-dəki öz repo-nu davam etdir; intern.az repo-sunu təqdim etmə.
2. Müraciət üçün TypeScript data tipi və mock API cavab formatı yarat.
3. Dörd ssenari hazırla: 200 və məlumat var, 200 və boş siyahı, 401, 500. Real API açarı tələb olunmayan lokal mock istifadə et.
4. Loading, success, empty və recoverable error vəziyyətlərini qur.
5. Refresh/retry düyməsi əlavə et; retry eyni vaxtda təkrarlanan sorğular yaratmasın.
6. Bu vəziyyətləri test et, screenshot-lar çək və README-ni yenilə.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işləyən dashboard, mock API adapter-i, dörd vəziyyətin screenshot-u və state/API davranışını yoxlayan testlər. Boş nəticə ilə server xətası ayrı mesajlar göstərməlidir.
[[EN]]
## 1. What is this task for?
Connect a coordinator dashboard showing application counts and recent applications to a mock API. Success, empty results, authentication failure, and server failure must look different.

## 2. What should you know first?
Your own frontend repository, React state/effects, TypeScript types, basic API requests, and component testing. Use synthetic test data, not real student information.

## 3. Step-by-step instructions
1. Continue your own repository from Task 2; do not submit the intern.az repository.
2. Define a TypeScript application type and the mock API response format.
3. Create four scenarios: 200 with data, 200 with an empty list, 401, and 500. Use a local mock that needs no real API key.
4. Build loading, success, empty, and recoverable-error states.
5. Add refresh/retry behavior without allowing duplicate concurrent requests.
6. Test the states, capture screenshots, and update the README.

## 4. What to submit
Your own GitHub repository link, working dashboard, mock API adapter, screenshots of all four states, and tests for API/state behavior. Empty results and server errors must show different messages.$task3$ WHERE id = 'b1000000-0000-4000-8000-000000000003'::uuid AND task_number = 3 AND status = 'published';

UPDATE public.internship_tasks SET instructions = $task4$[[AZ]]
## 1. Bu tapşırıq nə üçündür?
Tələbə müraciət formu və koordinatorun müraciət siyahısını bir-biri ilə uyğun işləyən frontend funksiyası kimi birləşdirəcəksən. Real backend əvəzinə mock API istifadə et.

## 2. Başlamazdan əvvəl nə bilməlisən?
Öz əvvəlki tapşırıqlarındakı komponentlər, form validation, filter/pagination, API state-ləri, responsive dizayn və testlərin əsasları. Real şəxsi məlumat və production açarları istifadə etmə.

## 3. Addım-addım təlimat
1. Task 1–3-dəki öz repo-nu davam etdir. Ayrı repo-lardadırsa, birini əsas layihə seç və digər kodu necə birləşdirdiyini README-də qeyd et; intern.az repo-sunu təqdim etmə.
2. İki axın qur: tələbə müraciət formu və koordinatorun müraciət siyahısı/detail görünüşü.
3. Form validation; siyahı üçün filter, pagination, loading, empty və error state-ləri əlavə et.
4. Submit iki dəfə basıldıqda dublikat yaratma. Siyahı/detail məlumatları uyğun qalsın.
5. Mobil görünüşü, keyboard navigation və error state-ləri yoxla. Unit/UI testləri əlavə et.
6. Mövcud lint/test/build əmrlərini yoxla, təmiz quraşdırma sınağı et və məlum məhdudiyyətləri yaz.

## 4. Təhvil veriləcək nəticə
Öz GitHub repo linkin, işlək frontend feature, mock API, testlər, mobil/desktop screenshot-lar və README. Təkrar submit dublikat yaratmamalı, siyahı ilə detail uyğun qalmalı, empty/error/mobile hallar yoxlanılmalıdır.
[[EN]]
## 1. What is this task for?
Combine a student application form and a coordinator application list into one consistent frontend feature. Use a mock API instead of a real backend.

## 2. What should you know first?
Your own components from earlier tasks, form validation, filtering/pagination, API states, responsive design, and basic testing. Do not use real personal data or production credentials.

## 3. Step-by-step instructions
1. Continue your own repository from Tasks 1–3. If those tasks are in separate repositories, choose one as the main project and document how you combine the code; do not submit the intern.az repository.
2. Build two flows: a student application form and a coordinator application list/detail view.
3. Add form validation and filter, pagination, loading, empty, and error states to the list.
4. Prevent duplicate submissions and keep list/detail data consistent.
5. Check mobile layout, keyboard navigation, and error states. Add unit/UI tests.
6. Check available lint/test/build commands, test a clean setup, and document known limitations.

## 4. What to submit
Your own GitHub repository link, working frontend feature, mock API, tests, mobile/desktop screenshots, and README. Repeated submission must not create duplicates, list/detail must stay consistent, and empty/error/mobile cases must be tested.$task4$ WHERE id = 'b1000000-0000-4000-8000-000000000004'::uuid AND task_number = 4 AND status = 'published';

COMMIT;
