'use client';

import React, { createContext, useContext, useState } from 'react';

export type Language = 'az' | 'en';

export interface Translations {
  navHome: string;
  navInternships: string;
  navHowItWorks: string;
  navAbout: string;
  navContact: string;
  navLogin: string;
  navRegister: string;
  navDashboard: string;
  navLogout: string;
  
  // Footer
  footerDesc: string;
  footerPlatform: string;
  footerRights: string;
  footerBaku: string;
  privacy: string;
  terms: string;

  // Generic
  emptyInternships: string;
  emptyApplications: string;
  emptyTasks: string;
  emptySubmissions: string;
  emptyNotifications: string;
  generalError: string;
  retry: string;

  // Internships Public
  internshipsTitle: string;
  internshipsSubtitle: string;
  searchPlaceholder: string;
  allCategories: string;
  allDifficulties: string;
  filterResults: string;
  clearFilters: string;
  durationWeeks: string;
  skills: string;
  requirements: string;
  responsibilities: string;
  benefits: string;
  maxStudents: string;
  placesAvailable: string;
  placesFull: string;
  applicationDeadline: string;
  startDate: string;
  viewDetails: string;
  applyNow: string;
  loginToApply: string;
  alreadyApplied: string;
  alreadyParticipating: string;
  applicationsClosed: string;
  deadlinePassed: string;
  backToInternships: string;
  difficultyBeginner: string;
  difficultyIntermediate: string;
  difficultyAdvanced: string;

  // Applications
  applyTitle: string;
  applySubtitle: string;
  studentInfo: string;
  motivationLabel: string;
  motivationPlaceholder: string;
  experienceLabel: string;
  experiencePlaceholder: string;
  portfolioLabel: string;
  githubLabel: string;
  linkedinLabel: string;
  submitApplication: string;
  submitting: string;
  applicationSuccess: string;
  applicationSuccessDesc: string;

  // Student Applications & Status
  myApplicationsTitle: string;
  myApplicationsSubtitle: string;
  noApplications: string;
  statusPending: string;
  statusAccepted: string;
  statusRejected: string;
  statusWithdrawn: string;
  withdrawApplication: string;
  withdrawConfirm: string;
  appliedOn: string;
  lastUpdated: string;
  adminNoteLabel: string;

  // Student Active Internship
  activeInternshipTitle: string;
  activeInternshipSubtitle: string;
  noActiveInternship: string;
  noActiveInternshipDesc: string;
  tasksPlaceholder: string;
  programOverview: string;
  programDetails: string;

  // Admin
  adminInternshipsTitle: string;
  adminInternshipsSubtitle: string;
  createNewInternship: string;
  editInternship: string;
  adminApplicationsTitle: string;
  adminApplicationsSubtitle: string;
  reviewApplicationTitle: string;
  accept: string;
  reject: string;
  acceptConfirm: string;
  rejectConfirm: string;
  capacityReached: string;
  manageProgram: string;
}

const translations: Record<Language, Translations> = {
  az: {
    navHome: 'Ana səhifə',
    navInternships: 'Təcrübələr',
    navHowItWorks: 'Necə işləyir?',
    navAbout: 'Haqqımızda',
    navContact: 'Əlaqə',
    navLogin: 'Daxil ol',
    navRegister: 'Qeydiyyat',
    navDashboard: 'Dashboard',
    navLogout: 'Çıxış',

    footerDesc: 'Azərbaycan tələbələri üçün praktiki təcrübə proqramları, real layihələr və rəsmi sertifikatlaşdırma platforması.',
    footerPlatform: 'Platforma',
    footerRights: 'Bütün hüquqlar qorunur.',
    footerBaku: 'Bakı, Azərbaycan',
    privacy: 'Məxfilik siyasəti',
    terms: 'İstifadə qaydaları',

    emptyInternships: 'Hazırda aktiv təcrübə proqramı yoxdur.',
    emptyApplications: 'Hazırda aktiv müraciətiniz yoxdur.',
    emptyTasks: 'Təyin olunmuş aktiv tapşırıq yoxdur.',
    emptySubmissions: 'Hələ heç bir təqdimat göndərilməyib.',
    emptyNotifications: 'Yeni bildiriş yoxdur.',
    generalError: 'Xəta baş verdi. Zəhmət olmasa yenidən cəhd edin.',
    retry: 'Yenidən cəhd edin',

    internshipsTitle: 'Təcrübə Proqramları',
    internshipsSubtitle: 'Azərbaycanın aparıcı şirkət və sənaye standartlarına uyğun açıq təcrübə vakansiyaları.',
    searchPlaceholder: 'Vakansiya, texnologiya və ya bacarıq axtarın...',
    allCategories: 'Bütün istiqamətlər',
    allDifficulties: 'Bütün çətinliklər',
    filterResults: 'Filter nəticələri',
    clearFilters: 'Filterləri sıfırla',
    durationWeeks: 'həftə',
    skills: 'Tələb olunan bacarıqlar',
    requirements: 'Qəbul tələbləri',
    responsibilities: 'Öhdəliklər və fəaliyyət',
    benefits: 'Təcrübənin üstünlükləri',
    maxStudents: 'Maksimum yer',
    placesAvailable: 'yer mövcuddur',
    placesFull: 'Bu təcrübə proqramında boş yer qalmayıb',
    applicationDeadline: 'Son müraciət tarixi',
    startDate: 'Başlama tarixi',
    viewDetails: 'Ətraflı bax',
    applyNow: 'Müraciət et',
    loginToApply: 'Müraciət etmək üçün daxil olun',
    alreadyApplied: 'Bu proqrama artıq müraciət etmisiniz',
    alreadyParticipating: 'Bu proqramda iştirak edirsiniz',
    applicationsClosed: 'Müraciətlər bağlıdır',
    deadlinePassed: 'Müraciət müddəti başa çatıb',
    backToInternships: 'Bütün təcrübə proqramlarına qayıt',
    difficultyBeginner: 'Başlanğıc',
    difficultyIntermediate: 'Orta',
    difficultyAdvanced: 'İrəli səviyyə',

    applyTitle: 'Təcrübəyə Müraciət',
    applySubtitle: 'Tələbə məlumatlarınızı təsdiqləyin və motivasiya məktubunuzu təqdim edin.',
    studentInfo: 'Tələbə Məlumatları',
    motivationLabel: 'Motivasiya Məktubu',
    motivationPlaceholder: 'Niyə bu təcrübə proqramına qoşulmaq istədiyinizi, karyera məqsədlərinizi və öyrənmək istədiyiniz sahələri qeyd edin (minimum 50 simvol)...',
    experienceLabel: 'Əvvəlki Təcrübə və Layihələr (Könüllü)',
    experiencePlaceholder: 'Əvvəl iştirak etdiyiniz layihələr, təhsil işləri və ya təlimlər barədə qısa məlumat verin...',
    portfolioLabel: 'Şəxsi Vebsayt / Portfel URL (Könüllü)',
    githubLabel: 'GitHub Profili (Könüllü)',
    linkedinLabel: 'LinkedIn Profili (Könüllü)',
    submitApplication: 'Müraciəti təsdiqlə və göndər',
    submitting: 'Göndərilir...',
    applicationSuccess: 'Müraciətiniz uğurla göndərildi!',
    applicationSuccessDesc: 'Müraciətiniz inzibatçı tərəfindən nəzərdən keçiriləcək. Statusu şəxsi kabinetinizdən izləyə bilərsiniz.',

    myApplicationsTitle: 'Müraciətlərim',
    myApplicationsSubtitle: 'Göndərdiyiniz təcrübə müraciətlərinin cari vəziyyəti və qərarlar.',
    noApplications: 'Hələ heç bir təcrübə proqramına müraciət etməmisiniz.',
    statusPending: 'Gözləmədə',
    statusAccepted: 'Qəbul edildi',
    statusRejected: 'Rədd edildi',
    statusWithdrawn: 'Geri çəkildi',
    withdrawApplication: 'Müraciəti geri çək',
    withdrawConfirm: 'Bu müraciəti geri çəkmək istədiyinizə əminsiniz?',
    appliedOn: 'Müraciət tarixi',
    lastUpdated: 'Son yenilənmə',
    adminNoteLabel: 'İnzibatçı rəyi / Qeyd',

    activeInternshipTitle: 'Mənim Təcrübəm',
    activeInternshipSubtitle: 'Qoşulduğunuz aktiv təcrübə proqramı, plan və gedişat.',
    noActiveInternship: 'Hazırda aktiv təcrübə proqramınız yoxdur.',
    noActiveInternshipDesc: 'Təcrübə proqramına qəbul edildikdən sonra proqram planı, modullar və tapşırıqlar burada aktivləşəcəkdir.',
    tasksPlaceholder: 'Tapşırıqlarınız burada görünəcək.',
    programOverview: 'Proqram Haqqında',
    programDetails: 'Təfərrüatlar',

    adminInternshipsTitle: 'Təcrübə Proqramları İdarəetməsi',
    adminInternshipsSubtitle: 'Yeni təcrübə proqramları yaradın, redaktə edin və statuslarını dəyişin.',
    createNewInternship: 'Yeni Təcrübə Yarat',
    editInternship: 'Proqramı Redaktə Et',
    adminApplicationsTitle: 'Tələbə Müraciətləri',
    adminApplicationsSubtitle: 'Daxil olan tələbə müraciətlərini nəzərdən keçirin, qəbul və ya rədd edin.',
    reviewApplicationTitle: 'Müraciətin İcmalı',
    accept: 'Qəbul et',
    reject: 'Rədd et',
    acceptConfirm: 'Bu tələbəni təcrübə proqramına qəbul etmək istəyirsiniz?',
    rejectConfirm: 'Bu müraciəti rədd etmək istəyirsiniz?',
    capacityReached: 'Bu təcrübə proqramında boş yer qalmayıb.',
    manageProgram: 'Bu proqramı idarə et',
  },
  en: {
    navHome: 'Home',
    navInternships: 'Internships',
    navHowItWorks: 'How it Works',
    navAbout: 'About Us',
    navContact: 'Contact',
    navLogin: 'Sign In',
    navRegister: 'Register',
    navDashboard: 'Dashboard',
    navLogout: 'Sign Out',

    footerDesc: 'Empowering university students in Azerbaijan with hands-on industry internships, workplace projects, and verified career credentials.',
    footerPlatform: 'Platform',
    footerRights: 'All rights reserved.',
    footerBaku: 'Baku, Azerbaijan',
    privacy: 'Privacy Policy',
    terms: 'Terms of Service',

    emptyInternships: 'No active internship programs are available at the moment.',
    emptyApplications: 'You have no active applications at the moment.',
    emptyTasks: 'No assigned tasks currently pending.',
    emptySubmissions: 'No project submissions recorded yet.',
    emptyNotifications: 'No new notifications.',
    generalError: 'Something went wrong. Please try again.',
    retry: 'Please try again',

    internshipsTitle: 'Internship Programs',
    internshipsSubtitle: 'Explore industry-aligned internship openings curated for ambitious university students across Azerbaijan.',
    searchPlaceholder: 'Search by title, technology or skill...',
    allCategories: 'All Tracks',
    allDifficulties: 'All Difficulty Levels',
    filterResults: 'Filter Results',
    clearFilters: 'Clear Filters',
    durationWeeks: 'weeks',
    skills: 'Required Skills',
    requirements: 'Eligibility & Requirements',
    responsibilities: 'Key Responsibilities',
    benefits: 'Program Benefits',
    maxStudents: 'Cohort Capacity',
    placesAvailable: 'spots left',
    placesFull: 'This internship program is at full capacity',
    applicationDeadline: 'Application Deadline',
    startDate: 'Start Date',
    viewDetails: 'View Details',
    applyNow: 'Apply Now',
    loginToApply: 'Sign in to Apply',
    alreadyApplied: 'You have already applied to this program',
    alreadyParticipating: 'You are enrolled in this program',
    applicationsClosed: 'Applications are closed',
    deadlinePassed: 'Application deadline has passed',
    backToInternships: 'Back to all internships',
    difficultyBeginner: 'Beginner',
    difficultyIntermediate: 'Intermediate',
    difficultyAdvanced: 'Advanced',

    applyTitle: 'Apply for Internship',
    applySubtitle: 'Confirm your student profile and submit your motivation letter.',
    studentInfo: 'Student Information',
    motivationLabel: 'Statement of Motivation',
    motivationPlaceholder: 'Describe why you want to join this program, your career aspirations, and what you aim to achieve (minimum 50 characters)...',
    experienceLabel: 'Relevant Experience & Projects (Optional)',
    experiencePlaceholder: 'Briefly summarize relevant academic coursework, prior team projects, or extracurriculars...',
    portfolioLabel: 'Portfolio / Personal Website URL (Optional)',
    githubLabel: 'GitHub Profile (Optional)',
    linkedinLabel: 'LinkedIn Profile (Optional)',
    submitApplication: 'Submit Application',
    submitting: 'Submitting...',
    applicationSuccess: 'Your application has been submitted successfully!',
    applicationSuccessDesc: 'Your application will be carefully reviewed by the platform administrator. You can monitor its status from your dashboard.',

    myApplicationsTitle: 'My Applications',
    myApplicationsSubtitle: 'Track your submitted internship applications and decisions.',
    noApplications: "You haven't applied to any internship programs yet.",
    statusPending: 'Pending',
    statusAccepted: 'Accepted',
    statusRejected: 'Rejected',
    statusWithdrawn: 'Withdrawn',
    withdrawApplication: 'Withdraw Application',
    withdrawConfirm: 'Are you sure you want to withdraw this application?',
    appliedOn: 'Applied on',
    lastUpdated: 'Last updated',
    adminNoteLabel: 'Admin Feedback / Note',

    activeInternshipTitle: 'My Internship',
    activeInternshipSubtitle: 'Your active internship enrollment, curriculum, and schedule.',
    noActiveInternship: 'You do not have an active internship program at the moment.',
    noActiveInternshipDesc: 'Once accepted into an internship program, your roadmap, syllabus, and assignments will appear here.',
    tasksPlaceholder: 'Your tasks will appear here.',
    programOverview: 'Program Overview',
    programDetails: 'Program Details',

    adminInternshipsTitle: 'Internship Programs Management',
    adminInternshipsSubtitle: 'Create, update, publish and manage corporate internship cohorts.',
    createNewInternship: 'Create New Internship',
    editInternship: 'Edit Internship',
    adminApplicationsTitle: 'Student Applications',
    adminApplicationsSubtitle: 'Review incoming applicant dossiers, accept qualified candidates or provide feedback.',
    reviewApplicationTitle: 'Application Review',
    accept: 'Accept Candidate',
    reject: 'Reject Application',
    acceptConfirm: 'Are you sure you want to accept this candidate into the program?',
    rejectConfirm: 'Are you sure you want to reject this application?',
    capacityReached: 'This internship program is at full capacity.',
    manageProgram: 'Manage this program',
  },
};

interface LanguageContextType {
  language: Language;
  setLanguage: (lang: Language) => void;
  t: (key: keyof Translations) => string;
}

const LanguageContext = createContext<LanguageContextType | undefined>(undefined);

export function LanguageProvider({ children }: { children: React.ReactNode }) {
  const [language, setLangState] = useState<Language>(() => {
    if (typeof window !== 'undefined') {
      try {
        const saved = localStorage.getItem('intern_az_lang') as Language;
        if (saved === 'az' || saved === 'en') {
          return saved;
        }
      } catch {
        // ignore
      }
    }
    return 'az';
  });

  const setLanguage = (lang: Language) => {
    setLangState(lang);
    if (typeof window !== 'undefined') {
      try {
        localStorage.setItem('intern_az_lang', lang);
      } catch {
        // ignore
      }
    }
  };

  const t = (key: keyof Translations): string => {
    return translations[language]?.[key] || translations.az[key] || '';
  };

  return (
    <LanguageContext.Provider value={{ language, setLanguage, t }}>
      {children}
    </LanguageContext.Provider>
  );
}

export function useLanguage() {
  const context = useContext(LanguageContext);
  if (!context) {
    throw new Error('useLanguage must be used within a LanguageProvider');
  }
  return context;
}
