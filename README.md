# 🇦🇿 Intern.az

**Intern.az** — Azərbaycanda tələbə və gənclərin təcrübə proqramlarına müraciət etməsini, qəbuldan sonra verilən tapşırıqları yerinə yetirməsini və proqramın sonunda sertifikat əldə etməsini təmin edən müasir internship management platformasıdır.

Platformanın əsas məqsədi internship prosesini **müraciətdən sertifikata qədər vahid rəqəmsal sistemdə** idarə etməkdir.

---

## 📌 Layihənin məqsədi

Ənənəvi internship prosesində müraciətlər, tələbələrlə əlaqə, tapşırıqlar, nəticələrin yoxlanılması və sertifikatların hazırlanması müxtəlif platformalarda aparılır.

Intern.az bu prosesi bir sistemdə birləşdirir:

```text
Tələbə
   ↓
Internship seçir
   ↓
Müraciət edir
   ↓
Admin müraciəti yoxlayır
   ↓
Qəbul edilir
   ↓
Internship başlayır
   ↓
Tapşırıqlar yerinə yetirilir
   ↓
Admin yoxlayır
   ↓
Revision / Approval
   ↓
Final Project
   ↓
Internship tamamlanır
   ↓
Sertifikat üçün ödəniş
   ↓
Ödəniş qəbzi yüklənir
   ↓
Admin təsdiqləyir
   ↓
Sertifikat hazırlanır
   ↓
Sertifikat sistemə yüklənir
   ↓
Public Certificate Verification
```

---

# 🎯 Əsas imkanlar

## 👨‍🎓 Tələbə sistemi

Tələbə platformada hesab yarada və internship proqramlarına müraciət edə bilər.

Tələbənin əsas imkanları:

* Hesab yaratmaq
* Login / Logout
* Profil məlumatlarını idarə etmək
* Internship-lərə baxmaq
* Internship haqqında ətraflı məlumat görmək
* Internship-ə müraciət etmək
* Müraciətin statusunu izləmək
* Qəbul edildikdən sonra internship dashboard-a daxil olmaq
* Tapşırıqları görmək
* Tapşırıqları yerinə yetirmək
* Mətn cavabı göndərmək
* Link göndərmək
* GitHub repository göndərmək
* Fayl yükləmək
* Submission statusunu izləmək
* Admin feedback-lərinə baxmaq
* Revision tələb olunarsa tapşırığı yenidən göndərmək
* Final project təqdim etmək
* Internship completion statusunu görmək
* Sertifikat üçün ödəniş məlumatlarını görmək
* Ödəniş qəbzini yükləmək
* Ödəniş statusunu izləmək
* Verilmiş sertifikatı dashboard-dan görmək
* Certificate ID vasitəsilə sertifikatı yoxlamaq

---

# 🛠️ Admin sistemi

Admin platformanın əsas idarəedicisidir.

Admin:

* Internship yarada bilər
* Internship məlumatlarını redaktə edə bilər
* Internship-i publish edə bilər
* Internship-i bağlaya bilər
* Internship-ləri arxivləşdirə bilər
* Müraciətlərə baxa bilər
* Tələbəni qəbul edə bilər
* Tələbəni rədd edə bilər
* Internship-ə qəbul edilmiş tələbələri görə bilər
* Tapşırıqlar yarada bilər
* Tapşırıqları publish edə bilər
* Tapşırıqların deadline-ını təyin edə bilər
* Tələbə submission-larına baxa bilər
* Submission-u approve edə bilər
* Revision tələb edə bilər
* Submission-u reject edə bilər
* Feedback yaza bilər
* Tələbənin internship progress-ini izləyə bilər
* Internship completion statusunu idarə edə bilər
* Sertifikat qiymətini təyin edə bilər
* Ödəniş üçün kart məlumatını göstərə bilər
* Ödəniş qəbzlərini yoxlaya bilər
* Ödənişi approve/reject edə bilər
* Sertifikat yarada bilər
* Sertifikatı sistemə yükləyə bilər
* Sertifikatı revoke edə bilər

---

# 🔐 Admin təhlükəsizliyi

Platformada admin hüququ sadəcə frontend-dəki `role` məlumatına əsaslanmır.

Admin authorization backend/database səviyyəsində qorunur.

Hazırkı sistemdə platformanın əsas admin hesabı:

```text
babayev.omr.23@gmail.com
```

Admin hüququ database səviyyəsində müəyyən edilir.

Adi istifadəçi öz profilində:

```text
role = admin
```

yazaraq admin ola bilməz.

Profil məlumatlarının dəyişdirilməsi üçün əlavə database security mexanizmləri mövcuddur.

---

# 🌐 Dil sistemi

Intern.az iki dilli platforma kimi nəzərdə tutulub:

* 🇦🇿 Azərbaycan dili
* 🇬🇧 English

Default dil:

```text
Azərbaycan dili
```

İstifadəçi language switcher vasitəsilə dili dəyişə bilər.

Bütün əsas UI elementləri və platforma mətnləri hər iki dili dəstəkləməlidir.

---

# 🏗️ Texnologiyalar

Frontend:

* Next.js
* React
* TypeScript
* Tailwind CSS
* shadcn/ui

Backend / Database:

* Supabase
* PostgreSQL
* Supabase Auth
* Supabase Storage
* Row Level Security (RLS)
* PostgreSQL Functions / RPC

Deployment:

* Vercel

Development:

* GitHub
* VS Code
* AI-assisted development

---

# 🗄️ Database Architecture

Platformanın əsas məlumatları Supabase PostgreSQL-də saxlanılır.

Əsas cədvəllər:

```text
profiles
internships
applications
enrollments
internship_tasks
task_submissions
certificate_settings
certificate_payments
certificates
```

---

# 👤 profiles

İstifadəçilərin profil məlumatlarını saxlayır.

Əsas məlumatlar:

```text
id
user_id
full_name
email
role
avatar_url
phone
university
created_at
updated_at
```

Role:

```text
student
admin
```

`profiles` cədvəli RLS ilə qorunur.

İstifadəçi öz profilini idarə edə bilər, lakin kritik authorization məlumatlarını özbaşına dəyişə bilməz.

---

# 💼 internships

Platformadakı internship proqramlarını saxlayır.

Əsas field-lər:

```text
id
title
slug
short_description
description
category
duration_weeks
difficulty
skills
requirements
responsibilities
benefits
max_students
status
application_deadline
start_date
created_by
created_at
updated_at
```

Internship statusları:

```text
draft
published
closed
archived
```

### Draft

Internship hazırlanır, lakin tələbələr üçün görünmür.

### Published

Internship tələbələr üçün aktivdir.

### Closed

Yeni müraciətlər qəbul edilmir.

### Archived

Köhnə internship proqramıdır və artıq aktiv deyil.

---

# 📝 applications

Tələbələrin internship müraciətlərini saxlayır.

Əsas məlumatlar:

```text
id
internship_id
student_id
motivation
experience
portfolio_url
github_url
linkedin_url
status
admin_note
reviewed_by
reviewed_at
created_at
updated_at
```

Müraciət statusları:

```text
pending
accepted
rejected
withdrawn
```

Flow:

```text
Student applies
       ↓
Pending
       ↓
Admin review
    ↙       ↘
Accepted   Rejected
```

Tələbə yalnız pending vəziyyətində olan müraciətini geri çəkə bilər.

---

# 🎓 enrollments

Tələbənin internship-ə qəbul edilməsindən sonrakı iştirakını saxlayır.

Əsas məlumatlar:

```text
id
internship_id
student_id
application_id
status
enrolled_at
completed_at
created_at
updated_at
```

Statuslar:

```text
active
completed
cancelled
```

Müraciət qəbul edildikdən sonra tələbə üçün enrollment yaradılır.

```text
Application
     ↓
Accepted
     ↓
Enrollment
     ↓
Active
     ↓
Completed
```

---

# 📚 internship_tasks

Internship proqramının tapşırıqlarını saxlayır.

Əsas field-lər:

```text
id
internship_id
title
description
instructions
week_number
task_number
difficulty
submission_type
deadline
is_required
status
created_at
updated_at
```

Difficulty:

```text
beginner
intermediate
advanced
```

Submission type:

```text
text
link
github
file
multiple
```

Task status:

```text
draft
published
archived
```

Tapşırıqlar həftələr üzrə təşkil edilə bilər:

```text
Week 1
 ├── Task 1
 ├── Task 2
 └── Task 3

Week 2
 ├── Task 1
 └── Task 2

Week 3
 └── Final Project
```

---

# 📤 task_submissions

Tələbənin tapşırığa verdiyi cavabı saxlayır.

Əsas field-lər:

```text
id
task_id
student_id
enrollment_id
text_answer
submission_url
github_url
file_path
comment
status
admin_feedback
reviewed_by
reviewed_at
submitted_at
updated_at
```

Submission statusları:

```text
pending
revision_requested
approved
rejected
```

Flow:

```text
Student submits
       ↓
Pending
       ↓
Admin reviews
   ↙       ↓       ↘
Approved Revision  Rejected
          ↓
       Resubmit
```

---

# 💳 Certificate Payment System

Intern.az avtomatik payment gateway istifadə etmir.

Məsələn:

```text
Certificate Price: 10 AZN
```

Tələbəyə admin tərəfindən müəyyən edilmiş bank kartı göstərilir.

Tələbə ödənişi bank tətbiqindən manual şəkildə edir.

Daha sonra:

```text
Payment
   ↓
Receipt screenshot/PDF
   ↓
Upload
   ↓
Admin review
```

---

# ⚙️ certificate_settings

Hər internship üçün sertifikat parametrlərini saxlayır.

Əsas məlumatlar:

```text
internship_id
price
currency
card_number
is_enabled
created_at
updated_at
```

Məsələn:

```text
Certificate:
10 AZN

Currency:
AZN

Payment Card:
**** **** **** 1234
```

Admin qiyməti dəyişə bilər.

---

# 🧾 certificate_payments

Tələbənin sertifikat üçün etdiyi ödəniş müraciətini saxlayır.

Əsas məlumatlar:

```text
id
student_id
internship_id
enrollment_id
amount
currency
receipt_path
status
admin_note
reviewed_by
reviewed_at
created_at
updated_at
```

Status:

```text
pending
approved
rejected
```

Flow:

```text
Student uploads receipt
          ↓
       Pending
          ↓
     Admin review
       ↙      ↘
 Approved    Rejected
```

---

# 🏆 Certificates

Verilmiş sertifikatların məlumatlarını saxlayır.

Əsas field-lər:

```text
id
certificate_id
student_id
internship_id
enrollment_id
student_name
internship_title
issued_at
certificate_file_path
status
created_at
updated_at
```

Certificate status:

```text
pending
issued
revoked
```

Certificate ID nümunəsi:

```text
AZ-INT-2026-A7F3
```

Bu ID hər sertifikat üçün unique olur.

---

# 🔎 Public Certificate Verification

Sistemin əsas xüsusiyyətlərindən biri sertifikatın public şəkildə yoxlanılmasıdır.

İstifadəçi login olmadan Certificate ID daxil edə bilər.

Məsələn:

```text
AZ-INT-2026-A7F3
```

Sistem yalnız sertifikatın public verification üçün nəzərdə tutulmuş məlumatlarını qaytarır:

```text
Certificate ID
Student Name
Internship Title
Issued Date
Status
```

Şəxsi məlumatlar və daxili database məlumatları public endpoint vasitəsilə açılmır.

Yalnız:

```text
status = issued
```

olan sertifikatlar public verification nəticəsində göstərilir.

---

# 🔒 Supabase Row Level Security

Platformanın təhlükəsizlik modelində Supabase RLS mühüm rol oynayır.

Əsas cədvəllər RLS ilə qorunur:

```text
profiles
internships
applications
enrollments
internship_tasks
task_submissions
certificate_settings
certificate_payments
certificates
```

Məqsəd:

> Frontend-dən gələn request-ə güvənmək əvəzinə database özü istifadəçinin həmin məlumatı oxumaq və ya dəyişmək hüququnun olub-olmadığını yoxlayır.

Məsələn tələbə başqa tələbənin submission məlumatını görə bilməməlidir.

---

# 🔐 Secure Database Functions

Bəzi kritik əməliyyatlar birbaşa frontend-dən database update etməklə həyata keçirilmir.

Bunun əvəzinə PostgreSQL SECURITY DEFINER functions istifadə olunur.

Məsələn:

```text
issue_certificate_secure()
```

Sertifikatın verilməsini server/database səviyyəsində yoxlayır.

Sertifikat verilərkən sistem yoxlayır:

```text
Admin?
   ↓
Enrollment mövcuddur?
   ↓
Student uyğun gəlir?
   ↓
Internship uyğun gəlir?
   ↓
Enrollment completed?
   ↓
Payment approved?
   ↓
Certificate issue
```

Beləliklə frontend request-i manipulyasiya etməklə sertifikat əldə etmək mümkün olmamalıdır.

---

# ✅ Internship Completion

Tələbənin internship-i tamamlaması bütün required task-ların approved olmasına əsaslanır.

Məsələn:

```text
Required Tasks: 5
Approved Tasks: 5
```

olduqda enrollment:

```text
active
```

vəziyyətindən:

```text
completed
```

vəziyyətinə keçirilə bilər.

Sistemdə bunu yoxlayan secure database function mövcuddur:

```text
check_and_complete_enrollment()
```

---

# 📁 Storage

Fayllar Supabase Storage-da saxlanılır.

Storage bucket-ləri:

```text
task-submissions
certificate-payments
certificates
```

Bütün bucket-lər private nəzərdə tutulub.

### task-submissions

Tələbələrin tapşırıq faylları.

### certificate-payments

Ödəniş qəbzləri.

### certificates

Hazırlanmış sertifikat PDF-ləri.

Private storage istifadə olunmasının səbəbi:

* Faylların public URL ilə açılmasının qarşısını almaq
* Student məlumatlarını qorumaq
* Receipt-lərin public olmamasını təmin etmək
* Certificate fayllarına nəzarətli giriş yaratmaq

---

# 👨‍💻 Authentication

Authentication Supabase Auth vasitəsilə həyata keçirilir.

Əsas flow:

```text
Register
   ↓
Supabase Auth
   ↓
User created
   ↓
Profile created
   ↓
Student account
```

Admin hesabı isə xüsusi email əsasında database səviyyəsində müəyyən edilir.

Adi istifadəçilər avtomatik olaraq:

```text
student
```

role-u alırlar.

---

# 🔄 Tam sistem axını

## 1. Student Registration

```text
Student
 ↓
Register
 ↓
Supabase Auth
 ↓
Profile
 ↓
Student Dashboard
```

---

## 2. Internship Application

```text
Browse Internships
       ↓
Internship Details
       ↓
Apply
       ↓
Application = pending
```

---

## 3. Admin Review

```text
Admin Dashboard
       ↓
Applications
       ↓
Review
    ↙     ↘
Accept   Reject
```

Accept olduqda:

```text
Application
     ↓
Accepted
     ↓
Enrollment created
     ↓
Student gets internship dashboard
```

---

# 4. Internship Tasks

Student:

```text
Dashboard
   ↓
My Internship
   ↓
Tasks
   ↓
Open Task
   ↓
Submit
```

Admin:

```text
Submission
    ↓
Review
 ↙       ↘
Approve  Revision
           ↓
        Resubmit
```

---

# 5. Internship Completion

```text
All required tasks
       ↓
Approved
       ↓
Completion check
       ↓
Enrollment = completed
```

---

# 6. Certificate Payment

Əgər internship üçün certificate payment aktivdirsə:

```text
Completed
   ↓
Certificate available
   ↓
Payment instructions
   ↓
Manual bank transfer
   ↓
Receipt upload
```

---

# 7. Payment Review

```text
Receipt
   ↓
Pending
   ↓
Admin Review
   ↙       ↘
Approved  Rejected
```

---

# 8. Certificate

Approved payment olduqdan sonra admin secure function vasitəsilə sertifikatı issue edir.

```text
Completed Enrollment
        +
Approved Payment
        ↓
Certificate Issue
        ↓
Certificate ID
        ↓
PDF Upload
        ↓
Student Dashboard
```

---

# 🔎 9. Certificate Verification

İstənilən şəxs Certificate ID vasitəsilə sertifikatı yoxlaya bilər.

```text
Certificate ID
      ↓
Public Verification
      ↓
Database RPC
      ↓
Certificate exists?
      ↓
Issued?
      ↓
Verification result
```

---

# 🖥️ Dashboard strukturu

## Student Dashboard

Tələbə üçün əsas bölmələr:

```text
Dashboard
├── Overview
├── My Applications
├── My Internships
├── Tasks
├── Submissions
├── Certificate
└── Profile
```

---

## Admin Dashboard

```text
Admin Dashboard
├── Overview
├── Internships
├── Applications
├── Students
├── Enrollments
├── Tasks
├── Submissions
├── Certificate Payments
├── Certificates
└── Settings
```

---

# 📊 Admin üçün əsas workflow

Admin üçün tipik proses:

```text
Create Internship
        ↓
Add Tasks
        ↓
Publish Internship
        ↓
Receive Applications
        ↓
Review Applications
        ↓
Accept Students
        ↓
Monitor Submissions
        ↓
Review Tasks
        ↓
Approve / Request Revision
        ↓
Student Completes Internship
        ↓
Review Certificate Payment
        ↓
Issue Certificate
```

---

# 💡 Layihənin əsas üstünlüyü

Intern.az yalnız internship elanlarının göstərildiyi sayt deyil.

Bu platforma internship-in bütün lifecycle-ını idarə etmək üçün hazırlanır:

```text
Discovery
   ↓
Application
   ↓
Selection
   ↓
Enrollment
   ↓
Learning
   ↓
Task Submission
   ↓
Review
   ↓
Completion
   ↓
Payment
   ↓
Certification
   ↓
Verification
```

Beləliklə internship provider üçün ayrıca:

* Google Forms
* Google Drive
* WhatsApp
* Email
* Excel
* Manual task tracking
* Manual payment tracking

kimi çoxsaylı sistemlərə olan ehtiyac azalır.

---

# 🧱 Layihə arxitekturası

Ümumi struktur:

```text
                    ┌─────────────────┐
                    │    Intern.az    │
                    └────────┬────────┘
                             │
                ┌────────────┴────────────┐
                │                         │
          Student UI                Admin UI
                │                         │
                └────────────┬────────────┘
                             │
                        Next.js App
                             │
                    ┌────────┴────────┐
                    │                 │
              Supabase Auth      Application Logic
                    │                 │
                    └────────┬────────┘
                             │
                       PostgreSQL
                             │
                    ┌────────┴────────┐
                    │                 │
                   RLS          Secure RPCs
                    │                 │
                    └────────┬────────┘
                             │
                    Supabase Storage
```

---

# 📦 Environment Variables

Frontend üçün əsas environment variables:

```env
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=
```

Legacy compatibility üçün:

```env
NEXT_PUBLIC_SUPABASE_ANON_KEY=
```

istifadəsi də dəstəklənə bilər.

Server-side üçün service role key istifadə edilirsə, bu dəyişən:

```env
SUPABASE_SERVICE_ROLE_KEY=
```

yalnız server mühitində saxlanmalıdır.

**Service role key heç vaxt frontend koduna expose edilməməlidir.**

---

# 🚀 Deployment

Platforma Vercel üzərində deploy edilir.

Repository:

```text
GitHub
    ↓
Push
    ↓
Vercel
    ↓
Build
    ↓
Production
```

Deployment zamanı environment variables Vercel Project Settings-də konfiqurasiya edilir.

---

# 🧪 Development

Local development:

```bash
npm install
```

və ya layihənin istifadə etdiyi package manager-ə uyğun:

```bash
bun install
```

Development server:

```bash
npm run dev
```

və ya:

```bash
bun run dev
```

Sonra:

```text
http://localhost:3000
```

ünvanından açılır.

---

# 📂 Tövsiyə olunan project structure

```text
intern-az/
│
├── app/
│   ├── (auth)/
│   ├── admin/
│   ├── dashboard/
│   ├── internships/
│   ├── certificate/
│   └── verify/
│
├── components/
│   ├── ui/
│   ├── auth/
│   ├── internship/
│   ├── dashboard/
│   ├── admin/
│   └── certificate/
│
├── lib/
│   ├── auth/
│   ├── supabase/
│   └── utils/
│
├── supabase/
│   └── migrations/
│
├── public/
│
├── .env.local
├── .env.example
├── package.json
└── README.md
```

---

# 🔒 Security Principles

Intern.az üçün əsas security prinsipləri:

### 1. RLS

Bütün əsas exposed tables RLS ilə qorunur.

### 2. Authorization database səviyyəsindədir

Frontend-də:

```text
if (user.role === "admin")
```

yazılması təkbaşına security mexanizmi hesab edilmir.

Database özü authorization yoxlamalıdır.

### 3. Service Role qorunur

Service role key browser/client-side koduna göndərilmir.

### 4. Private Storage

Submission və payment receipt faylları private bucket-lərdə saxlanılır.

### 5. Secure RPC

Certificate issue/revoke kimi kritik əməliyyatlar secure database function vasitəsilə həyata keçirilir.

### 6. Public Verification məhduddur

Public certificate verification yalnız lazımi məlumatları qaytarır.

---

# 💰 Payment Model

Platforma payment gateway inteqrasiyası tələb etmir.

Hazırkı model:

```text
Admin sets price
       ↓
Student sees payment instructions
       ↓
Bank transfer
       ↓
Receipt upload
       ↓
Admin verifies
```

Bu yanaşma ilkin mərhələdə əlavə payment provider xərclərini və inteqrasiya mürəkkəbliyini azaldır.

---

# 📜 Certificate Model

Sertifikat avtomatik dizayn edilmir.

Hazırkı proses:

```text
Student completes internship
          ↓
Payment approved
          ↓
Admin prepares certificate
          ↓
Certificate PDF created manually
          ↓
PDF uploaded
          ↓
Certificate linked to student
```

Sertifikat dizaynı üçün Canva kimi alətlərdən istifadə edilə bilər.

---

# 🧑‍💼 Real-world istifadə ssenarisi

Məsələn, Intern.az-da:

```text
Python Backend Internship
```

adlı proqram yaradılır.

Admin:

```text
Duration: 8 weeks
Difficulty: Intermediate
Certificate: 10 AZN
```

təyin edir.

### Student A

1. Internship-i tapır
2. Müraciət edir
3. Admin qəbul edir
4. Enrollment yaranır
5. Week 1 Task-ları açılır
6. Task-ları göndərir
7. Admin approve edir
8. Week 2 açılır
9. Eyni proses davam edir
10. Bütün required task-lar tamamlanır
11. Enrollment `completed` olur
12. Certificate üçün ödəniş edir
13. Qəbzi upload edir
14. Admin təsdiqləyir
15. Certificate issue edilir
16. PDF dashboard-a əlavə edilir
17. Student Certificate ID əldə edir

Daha sonra işəgötürən və ya başqa şəxs:

```text
AZ-INT-2026-A7F3
```

ID-si ilə sertifikatı yoxlaya bilər.

---

# 🚧 Gələcək inkişaf planı

Platformanın gələcək versiyalarında aşağıdakı funksiyalar əlavə edilə bilər:

## Email Notifications

Məsələn:

```text
Application accepted
Task approved
Revision requested
Internship completed
Payment approved
Certificate issued
```

Email notification sistemi əlavə edilə bilər.

---

## Automated Certificate Generation

Gələcəkdə admin tərəfindən məlumat daxil edildikdə PDF avtomatik yaradıla bilər:

```text
Student Name
Internship Name
Issue Date
Certificate ID
```

və hazır template üzərində sertifikat generasiya edilə bilər.

---

## Advanced Analytics

Admin üçün:

```text
Applications
Acceptance rate
Completion rate
Task approval rate
Average completion time
Certificate count
```

kimi statistikalar göstərilə bilər.

---

## Notifications

Platformadaxili notification sistemi:

```text
🔔 New task available
🔔 Submission approved
🔔 Revision requested
🔔 Payment approved
🔔 Certificate issued
```

---

## Internship Progress

Student dashboard-da:

```text
████████████░░░░ 75%
```

kimi progress göstəricisi əlavə edilə bilər.

---

# 🧭 Layihənin vizyonu

Intern.az-ın uzunmüddətli məqsədi sadəcə internship elanları paylaşan platforma olmaq deyil.

Məqsəd:

> **Azərbaycan tələbələri və internship provider-ləri arasında internship prosesini başdan sona rəqəmsallaşdıran platforma yaratmaqdır.**

Platformanın gələcəkdə:

* Internship management
* Student management
* Task management
* Assessment
* Certification
* Verification
* Analytics
* Communication

funksiyalarını vahid sistemdə birləşdirməsi nəzərdə tutulur.

---

# 📌 Project Status

**Current stage: MVP / Active Development**

Hazırda platformanın əsas backend strukturu, authentication, internship management, application system, enrollment, task/submission sistemi və certificate/payment strukturu qurulub.

Növbəti mərhələlər əsasən:

```text
UI/UX refinement
        ↓
Student Dashboard
        ↓
Admin Dashboard
        ↓
Task workflow
        ↓
Payment workflow
        ↓
Certificate workflow
        ↓
Testing
        ↓
Production
```

üzərində cəmlənə bilər.

---

# 👨‍💻 Tech Stack Summary

| Layer             | Technology                                  |
| ----------------- | ------------------------------------------- |
| Frontend          | Next.js                                     |
| UI                | React + Tailwind CSS                        |
| Components        | shadcn/ui                                   |
| Language          | TypeScript                                  |
| Authentication    | Supabase Auth                               |
| Database          | PostgreSQL                                  |
| Backend           | Supabase                                    |
| Authorization     | PostgreSQL RLS                              |
| Storage           | Supabase Storage                            |
| Secure Operations | PostgreSQL RPC                              |
| Repository        | GitHub                                      |
| Deployment        | Vercel                                      |
| Design            | Canva                                       |
| AI Development    | Google AI Studio / Claude / AI coding tools |

---

# 📄 License

Layihənin lisenziyası ayrıca müəyyən ediləcək.

---

## 🇦🇿 Intern.az

**From application to certification — all in one platform.**

Internship prosesini sadələşdir, tələbələrin inkişafını izləyin və nəticəni sertifikatla təsdiqləyin.
