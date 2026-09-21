'use client';

import React, { createContext, useContext, useState } from 'react';

export type Language = 'az' | 'en';

interface Translations {
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
