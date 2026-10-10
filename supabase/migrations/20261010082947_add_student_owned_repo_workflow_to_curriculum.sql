-- Adds the student-owned GitHub repository workflow to all 80 published curriculum tasks.
-- Task 1 creates the repository; tasks 2-10 continue in that same repository.
-- Guarded and transactional: refuses missing, already-patched, or unexpected rows.
BEGIN;

DO $curriculum_repository_workflow$
DECLARE
  candidate_count INTEGER;
  updated_count INTEGER;
BEGIN
  LOCK TABLE public.internship_tasks IN SHARE ROW EXCLUSIVE MODE;

  SELECT COUNT(*) INTO candidate_count
  FROM public.internship_tasks AS task
  JOIN public.internships AS internship ON internship.id = task.internship_id
  WHERE internship.slug IN ('applied-ai-engineering', 'automation-engineering', 'backend-engineering', 'cybersecurity', 'data-analytics', 'frontend-engineering', 'mobile-development', 'ui-ux-design')
    AND task.status = 'published'
    AND task.instructions IS NOT NULL
    AND task.instructions LIKE '%[[AZ]]%'
    AND task.instructions LIKE '%[[EN]]%'
    AND task.instructions LIKE '%## Addım-addım icra%'
    AND task.instructions LIKE '%## Step-by-step%'
    AND task.instructions NOT LIKE '%## GitHub repozitoriyası və davamlılıq%'
    AND task.instructions NOT LIKE '%## GitHub repository and continuity%';

  IF candidate_count <> 80 THEN
    RAISE EXCEPTION 'Curriculum repository workflow preflight failed: expected 80 clean bilingual tasks, found %', candidate_count;
  END IF;

  UPDATE public.internship_tasks AS task
  SET instructions = replace(
    replace(
      task.instructions,
      '## Addım-addım icra',
      (CASE WHEN task.task_number = 1 THEN $repo_workflow_az_first$## GitHub repozitoriyası və davamlılıq
### İlk tapşırıq — öz repozitoriyanı yarat
Bu istiqamətdə işləyəcəyin kod/dizayn layihəsi sənə məxsus repozitoriyada olmalıdır. Öz GitHub repozitoriyanı yarat; intern.az platformasının kod reposunu təqdim etmə.
1. GitHub-da **New repository** seç və məsələn backend-internship-<username> adlı yeni repo yarat. Public edə bilərsən; Private seçsən, mentorun oxuma icazəsini əlavə et.
2. Reponu boş yarat (README, license və gitignore seçmədən), sonra HTTPS ünvanını öz hesabına uyğun doldur:

```
git clone https://github.com/<USERNAME>/<REPOSITORY>.git
cd <REPOSITORY>
code .
```

3. Tapşırığın fayllarını və layihəni bu qovluğun içində yarat. Aşağıdakı addımda göstərilən stack/vasitələrdən istifadə et; ikinci repo yaratma.
4. İşləyən nəticəni və README-ni əlavə et, git status ilə yoxla. .env, parol və API açarlarını Git-ə əlavə etmə.
5. İlk commit-i et və GitHub-a göndər:

```
git add .
git commit -m "task-01: initialize project"
git push -u origin main
```

6. **Təqdimat formasına öz repozitoriyanın linkini** yaz: https://github.com/<USERNAME>/<REPOSITORY>. Private repo-dursa, əvvəlcə mentorun hesabına read access ver.$repo_workflow_az_first$ ELSE replace($repo_workflow_az_continued$## GitHub repozitoriyası və davamlılıq
### Əvvəlki tapşırığın davamı — eyni repoda işlə
Bu tapşırıq əvvəlki tapşırığın davamıdır: əvvəlki tapşırıqda yaratdığın eyni repozitoriyada davam et. Tapşırıq 1-dəki layihəni aç; yeni repo/app yaratma, əvvəlki faylları silmə.
1. VS Code-da əvvəlki tapşırıqda istifadə etdiyin repo qovluğunu aç. Başlamazdan əvvəl vəziyyəti yoxla və GitHub-dakı dəyişiklikləri al:

```
git status
git pull origin main
```

2. Yeni işi mövcud qovluq və quruluşun içində et. Əvvəlki tapşırıqların nəticələrini saxla; yalnız bu tapşırığa aid faylları dəyiş.
3. Test/yoxlamaları işlət, sonra dəyişiklikləri commit edib eyni GitHub repo-ya göndər:

```
git add .
git commit -m "task-02: continue project"
git push origin main
```

4. Təqdimat formasında yenə **həmin öz repo linkini** göndər. Platformanın etikhacker/intern.az reposunu təqdim etmə; private repo-dursa, mentorun oxu icazəsi qalmalıdır.$repo_workflow_az_continued$, 'task-02: continue project', 'task-' || lpad(task.task_number::TEXT, 2, '0') || ': continue project') END)
        || E'\n\n## Addım-addım icra'
    ),
    '## Step-by-step',
    (CASE WHEN task.task_number = 1 THEN $repo_workflow_en_first$## GitHub repository and continuity
### Task 1 — create your own repository
Your code/design work for this track must live in a repository you own. Do not submit the intern.az platform source repository.
1. On GitHub, choose **New repository** and create one such as backend-internship-<username>. Public is fine; if you choose Private, grant your mentor read access.
2. Create an empty repository (leave README, license, and gitignore unchecked), then replace the placeholders with your account and repository name:

```
git clone https://github.com/<USERNAME>/<REPOSITORY>.git
cd <REPOSITORY>
code .
```

3. Create the task files and project inside this cloned folder. Use the stack/tools in the following task steps; do not create a second repository.
4. Add a working result and README; verify with git status. Never commit .env, passwords, or API keys.
5. Make the first commit and push it to GitHub:

```
git add .
git commit -m "task-01: initialize project"
git push -u origin main
```

6. Submit **your own repository URL**: https://github.com/<USERNAME>/<REPOSITORY>. If it is private, give your mentor read access first.$repo_workflow_en_first$ ELSE replace($repo_workflow_en_continued$## GitHub repository and continuity
### Continuation — keep working in the same repository
This task continues the project for this track. Start from the **same repository and project you created for task 1**; do not create a new repo/app or remove previous files.
1. Open the repository folder you used for the previous task in VS Code. Check its state and pull the latest GitHub changes before editing:

```
git status
git pull origin main
```

2. Add this task's work within the existing folder and structure. Keep previous task results; change only files needed for this task.
3. Run the checks, then commit and push the changes to the same GitHub repository:

```
git add .
git commit -m "task-02: continue project"
git push origin main
```

4. Submit the **same repository URL you own** again. Do not submit the platform's etikhacker/intern.az repository; keep mentor read access if your repo is private.$repo_workflow_en_continued$, 'task-02: continue project', 'task-' || lpad(task.task_number::TEXT, 2, '0') || ': continue project') END)
      || E'\n\n## Step-by-step'
  )
  FROM public.internships AS internship
  WHERE internship.id = task.internship_id
    AND internship.slug IN ('applied-ai-engineering', 'automation-engineering', 'backend-engineering', 'cybersecurity', 'data-analytics', 'frontend-engineering', 'mobile-development', 'ui-ux-design')
    AND task.status = 'published'
    AND task.instructions IS NOT NULL
    AND task.instructions LIKE '%[[AZ]]%'
    AND task.instructions LIKE '%[[EN]]%'
    AND task.instructions LIKE '%## Addım-addım icra%'
    AND task.instructions LIKE '%## Step-by-step%'
    AND task.instructions NOT LIKE '%## GitHub repozitoriyası və davamlılıq%'
    AND task.instructions NOT LIKE '%## GitHub repository and continuity%';

  GET DIAGNOSTICS updated_count = ROW_COUNT;
  IF updated_count <> 80 THEN
    RAISE EXCEPTION 'Curriculum repository workflow update failed: expected 80 rows, updated %', updated_count;
  END IF;
END;
$curriculum_repository_workflow$;

COMMIT;
