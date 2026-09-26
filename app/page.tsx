'use client';

import Link from 'next/link';
import { Navbar } from '@/components/layout/navbar';
import { Footer } from '@/components/layout/footer';
import { Button } from '@/components/ui/button';
import { useLanguage } from '@/lib/i18n/language-context';
import {
  ArrowRight,
  ArrowUpRight,
  Award,
  BarChart3,
  Briefcase,
  Check,
  Code2,
  Database,
  GraduationCap,
  Layers3,
  Sparkles,
  Users,
} from 'lucide-react';

const tracks = [
  {
    number: '01',
    icon: Code2,
    tone: 'violet',
    azTitle: 'Frontend & Web Engineering',
    enTitle: 'Frontend & Web Engineering',
    azText: 'Next.js, TypeScript, UI sistemləri və real məhsul interfeysləri.',
    enText: 'Next.js, TypeScript, UI systems, and real product interfaces.',
  },
  {
    number: '02',
    icon: Database,
    tone: 'green',
    azTitle: 'Backend & Data Systems',
    enTitle: 'Backend & Data Systems',
    azText: 'API-lər, PostgreSQL, verilənlər bazası dizaynı və təhlükəsiz serverlər.',
    enText: 'APIs, PostgreSQL, database design, and secure server systems.',
  },
  {
    number: '03',
    icon: BarChart3,
    tone: 'orange',
    azTitle: 'AI, Analytics & Automation',
    enTitle: 'AI, Analytics & Automation',
    azText: 'AI alətləri, data düşüncəsi və iş axınlarını avtomatlaşdıran layihələr.',
    enText: 'AI tools, data thinking, and projects that automate real workflows.',
  },
];

const steps = [
  ['01', 'Qeydiyyat', 'Profilini yarat, universitet və maraq sahələrini əlavə et.'],
  ['02', 'İstiqamət seçimi', 'Sənə uyğun təcrübə proqramına müraciət et.'],
  ['03', 'Real tapşırıqlar', 'Mentor dəstəyi ilə həftəlik layihələr üzərində işləyin.'],
  ['04', 'Sertifikat', 'Nəticəni göstərən təsdiqlənə bilən sertifikat əldə et.'],
];

export default function HomePage() {
  const { language } = useLanguage();
  const isAz = language === 'az';

  return (
    <div className="portfolio-page flex min-h-screen flex-col">
      <Navbar />

      <main className="flex-1">
        <section className="portfolio-hero relative overflow-hidden">
          <div className="portfolio-noise" aria-hidden="true" />
          <div className="portfolio-hero-glow portfolio-hero-glow-one" aria-hidden="true" />
          <div className="portfolio-hero-glow portfolio-hero-glow-two" aria-hidden="true" />
          <div className="mx-auto grid max-w-7xl items-center gap-14 px-5 pb-24 pt-20 sm:px-8 lg:grid-cols-[1.05fr_0.95fr] lg:gap-20 lg:px-10 lg:pb-32 lg:pt-28">
            <div className="relative z-10">
              <div className="reveal-up reveal-delay-1 mb-7 inline-flex items-center gap-2 rounded-full border border-emerald-300/25 bg-emerald-300/10 px-3.5 py-2 text-[11px] font-bold uppercase tracking-[0.16em] text-emerald-200">
                <Sparkles className="h-3.5 w-3.5" aria-hidden="true" />
                {isAz ? 'Azərbaycan tələbələri üçün' : 'For university students in Azerbaijan'}
              </div>
              <h1 className="reveal-up reveal-delay-2 max-w-4xl text-[3.25rem] font-black leading-[0.98] tracking-[-0.065em] text-white sm:text-6xl lg:text-[6.5rem]">
                {isAz ? (
                  <>Gələcəyini <span className="portfolio-gradient-text">bu gün</span> qur.</>
                ) : (
                  <>Build your <span className="portfolio-gradient-text">future</span> today.</>
                )}
              </h1>
              <p className="reveal-up reveal-delay-3 mt-8 max-w-xl text-base leading-7 text-slate-300 sm:text-lg">
                {isAz
                  ? 'Intern.az universitetdə öyrəndiklərini real layihələrə, mentor rəyinə və karyeran üçün görünən nəticələrə çevirir.'
                  : 'Intern.az turns what you learn at university into real projects, mentor feedback, and visible career proof.'}
              </p>
              <div className="reveal-up reveal-delay-4 mt-9 flex flex-col gap-3 sm:flex-row">
                <Link href="/register">
                  <Button size="lg" className="portfolio-primary-button h-13 w-full gap-2 rounded-full px-7 sm:w-auto">
                    {isAz ? 'Səyahətə başla' : 'Start your journey'}
                    <ArrowRight className="h-4 w-4" aria-hidden="true" />
                  </Button>
                </Link>
                <Link href="/internships">
                  <Button variant="outline" size="lg" className="portfolio-outline-button h-13 w-full gap-2 rounded-full px-7 sm:w-auto">
                    {isAz ? 'Proqramları kəşf et' : 'Explore programs'}
                    <ArrowUpRight className="h-4 w-4" aria-hidden="true" />
                  </Button>
                </Link>
              </div>
              <div className="reveal-up reveal-delay-4 mt-12 flex flex-wrap gap-x-8 gap-y-4 border-t border-white/10 pt-6 text-xs text-slate-400">
                <span className="flex items-center gap-2"><Check className="h-3.5 w-3.5 text-emerald-300" /> Real layihələr</span>
                <span className="flex items-center gap-2"><Check className="h-3.5 w-3.5 text-emerald-300" /> Mentor rəyi</span>
                <span className="flex items-center gap-2"><Check className="h-3.5 w-3.5 text-emerald-300" /> Verifiable sertifikat</span>
              </div>
            </div>

            <div className="portfolio-hero-art reveal-up reveal-delay-3 relative mx-auto h-[27rem] w-full max-w-[30rem] lg:h-[34rem]" aria-label="Intern.az tələbə inkişaf platformasının vizual önizləməsi">
              <div className="portfolio-orbit portfolio-orbit-one" aria-hidden="true" />
              <div className="portfolio-orbit portfolio-orbit-two" aria-hidden="true" />
              <div className="portfolio-main-card">
                <div className="flex items-start justify-between">
                  <div className="flex items-center gap-3">
                    <div className="flex h-11 w-11 items-center justify-center rounded-2xl bg-emerald-300 text-slate-950 shadow-[0_0_30px_rgba(110,231,183,0.35)]">
                      <GraduationCap className="h-5 w-5" aria-hidden="true" />
                    </div>
                    <div>
                      <p className="text-xs font-bold uppercase tracking-[0.14em] text-emerald-200">Intern.az</p>
                      <p className="mt-1 text-sm text-slate-400">Student workspace</p>
                    </div>
                  </div>
                  <span className="rounded-full border border-emerald-300/25 bg-emerald-300/10 px-2.5 py-1 text-[10px] font-bold text-emerald-200">ACTIVE</span>
                </div>
                <div className="mt-12">
                  <p className="text-xs uppercase tracking-[0.18em] text-slate-500">Current focus</p>
                  <h2 className="mt-3 max-w-xs text-4xl font-black tracking-[-0.05em] text-white">Build. Learn. Show it.</h2>
                </div>
                <div className="mt-10 rounded-2xl border border-white/10 bg-white/[0.04] p-4">
                  <div className="mb-4 flex items-center justify-between text-xs text-slate-400"><span>Weekly progress</span><span className="font-bold text-emerald-200">72%</span></div>
                  <div className="h-2 overflow-hidden rounded-full bg-white/10"><div className="h-full w-[72%] rounded-full bg-gradient-to-r from-emerald-400 to-cyan-300" /></div>
                  <div className="mt-4 flex items-center gap-2 text-xs text-slate-400"><span className="h-2 w-2 rounded-full bg-emerald-300" /> 3 tasks completed this week</div>
                </div>
                <div className="mt-6 grid grid-cols-3 gap-2">
                  <div className="rounded-2xl border border-white/10 bg-white/[0.035] p-3"><Layers3 className="h-4 w-4 text-violet-300" /><p className="mt-3 text-lg font-black text-white">04</p><p className="text-[10px] text-slate-500">Projects</p></div>
                  <div className="rounded-2xl border border-white/10 bg-white/[0.035] p-3"><Users className="h-4 w-4 text-emerald-300" /><p className="mt-3 text-lg font-black text-white">1:1</p><p className="text-[10px] text-slate-500">Mentoring</p></div>
                  <div className="rounded-2xl border border-white/10 bg-white/[0.035] p-3"><Award className="h-4 w-4 text-orange-300" /><p className="mt-3 text-lg font-black text-white">01</p><p className="text-[10px] text-slate-500">Credential</p></div>
                </div>
              </div>
              <div className="portfolio-floating-tag portfolio-floating-tag-top"><Briefcase className="h-4 w-4 text-orange-300" /> Real work</div>
              <div className="portfolio-floating-tag portfolio-floating-tag-bottom"><span className="h-2 w-2 rounded-full bg-emerald-300" /> Mentor feedback</div>
            </div>
          </div>
        </section>

        <div className="portfolio-marquee border-y border-white/10 bg-white/[0.025] py-5">
          <div className="mx-auto flex max-w-7xl flex-wrap items-center justify-center gap-x-8 gap-y-3 px-5 text-xs font-bold uppercase tracking-[0.18em] text-slate-500 sm:justify-between sm:px-8 lg:px-10">
            <span>Frontend</span><span>Backend</span><span>Data</span><span>AI & Automation</span><span>Cybersecurity</span><span>Product thinking</span>
          </div>
        </div>

        <section className="portfolio-section mx-auto max-w-7xl px-5 py-24 sm:px-8 lg:px-10 lg:py-32">
          <div className="mb-12 flex flex-col justify-between gap-6 md:flex-row md:items-end">
            <div className="max-w-2xl"><p className="portfolio-kicker">01 / Tracks</p><h2 className="portfolio-heading">{isAz ? 'Sənə uyğun istiqaməti seç.' : 'Choose your direction.'}</h2></div>
            <Link href="/internships" className="portfolio-text-link">{isAz ? 'Bütün proqramlara bax' : 'View all programs'} <ArrowUpRight className="h-4 w-4" /></Link>
          </div>
          <div className="grid gap-5 lg:grid-cols-3">
            {tracks.map((track) => {
              const Icon = track.icon;
              return <Link href="/internships" key={track.number} className={`portfolio-track-card portfolio-track-${track.tone}`}>
                <div className="flex items-start justify-between"><span className="text-xs font-bold tracking-[0.18em] text-slate-500">{track.number}</span><span className="portfolio-track-icon"><Icon className="h-5 w-5" aria-hidden="true" /></span></div>
                <h3 className="mt-16 text-2xl font-black tracking-[-0.04em] text-white">{isAz ? track.azTitle : track.enTitle}</h3>
                <p className="mt-4 min-h-14 text-sm leading-6 text-slate-400">{isAz ? track.azText : track.enText}</p>
                <span className="mt-8 inline-flex items-center gap-2 text-sm font-bold text-white">{isAz ? 'İstiqaməti aç' : 'Open track'} <ArrowUpRight className="h-4 w-4" /></span>
              </Link>;
            })}
          </div>
        </section>

        <section className="border-y border-white/10 bg-[#0b1016]">
          <div className="mx-auto grid max-w-7xl gap-14 px-5 py-24 sm:px-8 lg:grid-cols-[0.8fr_1.2fr] lg:px-10 lg:py-32">
            <div><p className="portfolio-kicker">02 / Process</p><h2 className="portfolio-heading">{isAz ? 'Bir addım. Sonra bir addım da.' : 'One step. Then another.'}</h2><p className="mt-6 max-w-md text-base leading-7 text-slate-400">{isAz ? 'Mürəkkəb karyera yolunu aydın və ölçülə bilən mərhələlərə bölürük.' : 'We turn an overwhelming career start into a clear, measurable sequence of steps.'}</p></div>
            <div className="grid gap-0">
              {steps.map(([number, title, text], index) => <div key={number} className="portfolio-step-row"><span className="portfolio-step-number">{number}</span><div><h3 className="text-xl font-bold text-white">{isAz ? title : ['Registration', 'Direction', 'Real tasks', 'Certificate'][index]}</h3><p className="mt-2 max-w-lg text-sm leading-6 text-slate-400">{isAz ? text : ['Create your profile and add your university details.', 'Choose a program that fits your interests.', 'Work on practical projects with mentor guidance.', 'Earn a credential you can verify and share.'][index]}</p></div><ArrowUpRight className="ml-auto hidden h-5 w-5 text-emerald-300 sm:block" aria-hidden="true" /></div>)}
            </div>
          </div>
        </section>

        <section className="portfolio-cta mx-auto max-w-7xl px-5 py-24 sm:px-8 lg:px-10 lg:py-32">
          <div className="relative overflow-hidden rounded-[2rem] border border-emerald-300/20 bg-gradient-to-br from-emerald-400 via-emerald-500 to-cyan-500 px-7 py-14 text-center shadow-[0_30px_100px_rgba(16,185,129,0.2)] sm:px-12">
            <div className="absolute -right-16 -top-24 h-72 w-72 rounded-full border-[40px] border-white/10" aria-hidden="true" /><div className="absolute -bottom-32 -left-10 h-72 w-72 rounded-full border-[45px] border-white/10" aria-hidden="true" />
            <p className="relative text-xs font-black uppercase tracking-[0.2em] text-emerald-950/70">Intern.az / 2026</p>
            <h2 className="relative mx-auto mt-5 max-w-3xl text-4xl font-black tracking-[-0.055em] text-slate-950 sm:text-6xl">{isAz ? 'Öyrəndiklərini göstərməyə başla.' : 'Start showing what you can do.'}</h2>
            <p className="relative mx-auto mt-5 max-w-xl text-sm leading-6 text-emerald-950/75">{isAz ? 'İlk real layihənə bir klik məsafədəsən.' : 'Your first real project is one click away.'}</p>
            <Link href="/register" className="relative mt-8 inline-block"><Button size="lg" className="h-13 rounded-full bg-slate-950 px-8 text-white shadow-xl hover:bg-slate-800">{isAz ? 'Qeydiyyatdan keç' : 'Create your profile'} <ArrowRight className="ml-2 h-4 w-4" /></Button></Link>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}
