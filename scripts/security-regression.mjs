import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { readdirSync } from 'node:fs';
import { join, isAbsolute } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = new URL('../', import.meta.url);
const read = (path) => readFile(new URL(path, root), 'utf8');

const [config, middleware, adminLayout, adminLogin, admin, students, migration, certificates, submissions, tasks, loginPage, registerPage, adminLoginLayout, dashboardLayout, adminSidebar, studentSidebar, globals, internshipsPage, selectComponent] = await Promise.all([
  read('lib/supabase/config.ts'),
  read('lib/supabase/middleware.ts'),
  read('app/admin/layout.tsx'),
  read('app/admin/login/page.tsx'),
  read('app/admin/page.tsx'),
  read('app/admin/students/page.tsx'),
  read('supabase/migrations/20260922000006_harden_storage_ownership.sql'),
  read('lib/certificates/service.ts'),
  read('lib/submissions/service.ts'),
  read('lib/tasks/service.ts'),
  read('app/(auth)/login/page.tsx'),
  read('app/(auth)/register/page.tsx'),
  read('app/admin/layout.tsx'),
  read('app/dashboard/layout.tsx'),
  read('components/admin/admin-sidebar.tsx'),
  read('components/dashboard/student-sidebar.tsx'),
  read('app/globals.css'),
  read('app/internships/page.tsx'),
  read('components/ui/select.tsx'),
]);

assert.match(config, /process\.env\.SUPABASE_URL/);
assert.match(config, /process\.env\.SUPABASE_PUBLISHABLE_KEY/);
assert.match(middleware, /getSupabasePublicKey\(\)/);
assert.match(middleware, /getSupabaseUrl\(\)/);
assert.match(middleware, /isSoleAdminEmail\(user\?\.email\)/);
assert.match(adminLayout, /isSoleAdminEmail\(user\?\.email\)/);
assert.match(adminLogin, /SOLE_ADMIN_EMAIL/);
assert.doesNotMatch(adminLogin, /admin@intern\.az|Quick Fill Demo Admin/);

// The admin address must never be rendered into the page (placeholder,
// aria-label, or any user-visible string) — that hands every visitor the one
// account worth attacking.
const adminLoginRendersEmail = /placeholder=\{?["'`]?[^"'`]*babayev\.omr\.23/i;
assert.doesNotMatch(adminLogin, adminLoginRendersEmail);
assert.doesNotMatch(adminLogin, /value=["']\{?SOLE_ADMIN_EMAIL/);

// Route protection must fail CLOSED. A previous version returned the response
// untouched whenever Supabase was unconfigured, which served /admin to anyone
// who typed the URL.
assert.match(middleware, /if \(!isSupabaseConfigured\(\)\)/);
assert.doesNotMatch(
  middleware,
  /let requests pass through[\s\S]{0,200}return supabaseResponse;/
);
assert.match(middleware, /isArea\(pathname, '\/admin'\)/);
assert.match(middleware, /toLowerCase\(\)/);

// The email must never be echoed back in an auth error message (enumeration).
assert.doesNotMatch(adminLogin, /res\.error/);
assert.doesNotMatch(loginPage, /res\.error/);

// ?redirect= must not be usable as an open redirect.
assert.match(loginPage, /safeRedirectPath/);
assert.match(loginPage, /startsWith\('\/dashboard'\)/);

assert.doesNotMatch(admin, /localStorage\.getItem\(['"]internship_az_demo_profiles/);
assert.doesNotMatch(students, /localStorage\.getItem\(['"]internship_az_demo_profiles/);
assert.match(migration, /storage\.foldername\(name\)\)\[1\]/);
assert.match(migration, /certificate-payments/);
assert.match(migration, /task-submissions/);
assert.match(migration, /certificates/);
assert.match(certificates, /enrollmentData\.student_id !== studentId/);
assert.match(certificates, /enrollmentData\.internship_id !== internshipId/);
assert.match(submissions, /enrollment\.student_id !== studentId/);
assert.match(submissions, /enrollment\.internship_id !== task\.internship_id/);
assert.match(tasks, /\.eq\('internship_id', internshipId\)/);
assert.match(tasks, /if \(error\)/);

/* ---------------------------------------------------------------------------
 * Layout regressions.
 *
 * These are not security checks, but they guard bugs that kept coming back:
 * the split-screen auth layout used a flex row whose form column could exceed
 * 50% (min-width:auto), leaving a dead band on the right and pushing the page
 * sideways; the admin/dashboard shells subtracted a hardcoded 36px from the
 * viewport, so a strip of page background showed under the console.
 *
 * Checks run against code with comments stripped, otherwise merely *documenting*
 * the old pattern in a comment would fail the guard.
 * ------------------------------------------------------------------------ */
const code = (src) => src.replace(/\/\*[\s\S]*?\*\//g, '').replace(/^[ \t]*\/\/.*$/gm, '');

for (const [name, page] of [
  ['login', code(loginPage)],
  ['register', code(registerPage)],
  ['admin login', code(adminLogin)],
]) {
  // Column sizing belongs to the grid rule in globals.css, not to per-page
  // width utilities that can drift apart again.
  assert.doesNotMatch(page, /flex-\[0_0_50%\]/, `${name}: 50% flex basis`);
  assert.doesNotMatch(page, /lg:max-w-(xl|2xl)/, `${name}: hard-coded panel max-width`);
  assert.doesNotMatch(page, /lg:flex-row/, `${name}: flex row overrides the grid`);
  assert.match(page, /auth-login-page/, `${name}: missing auth page hook`);
  assert.match(page, /min-w-0/, `${name}: panel can exceed its grid track`);
}

// The grid itself: two minmax(0,1fr) tracks at one viewport height.
assert.match(
  globals,
  /\.auth-login-page \{[\s\S]{0,400}grid-template-columns: minmax\(0, 1fr\) minmax\(0, 1fr\);/
);
assert.match(globals, /grid-template-rows: 100dvh;/);
assert.match(globals, /overflow-x: clip;/);

// Exactly one viewport, no magic offset, for both shells.
for (const [name, shell] of [
  ['admin', code(adminLoginLayout)],
  ['dashboard', code(dashboardLayout)],
]) {
  assert.doesNotMatch(shell, /calc\(100vh\s*-\s*\d+px\)/, `${name}: hard-coded height offset`);
  assert.doesNotMatch(shell, /100vh/, `${name}: 100vh ignores mobile browser chrome`);
  assert.match(shell, /md:h-\[100dvh\]/, `${name}: shell is not one viewport tall`);
}
for (const [name, sidebar] of [
  ['admin', code(adminSidebar)],
  ['student', code(studentSidebar)],
]) {
  assert.doesNotMatch(sidebar, /h-screen/, `${name} sidebar: h-screen taller than the shell`);
  assert.match(sidebar, /h-\[100dvh\]/, `${name} sidebar: height does not match the shell`);
}

// Native dropdowns must go through the themed component, never a raw <select>
// (which rendered a white popup with grey text in the dark theme).
assert.doesNotMatch(internshipsPage, /<select/);
assert.match(internshipsPage, /from '@\/components\/ui\/select'/);
assert.match(selectComponent, /appearance-none/);
assert.match(selectComponent, /colorScheme: 'inherit'/);
assert.match(globals, /select option,\s*\n?select optgroup \{/);
assert.match(globals, /select \{\s*\n?\s*color-scheme: inherit;/);

/* ---------------------------------------------------------------------------
 * Translucent-surface theme coverage.
 *
 * The palette flips through the `--c-*` tokens, but Tailwind's own
 * `bg-slate-50/50` / `bg-emerald-50/20` utilities resolve to a LIGHT literal.
 * Without a remap they keep that value and render as a stray grey/white box in
 * the middle of the dark theme — the "boz rəng" panels on /dashboard/profile and
 * /dashboard/certificate. Any translucent surface utility of a tokenised family
 * must therefore be derived from its token in globals.css.
 *
 * `white`/`black`/`cyan`/`orange` and the `*-300/*` glow orbs are intentionally
 * literal: they are decorative overlays that must stay light on dark panels.
 * ------------------------------------------------------------------------ */
const sourceFiles = (dir, acc = []) => {
  const abs = isAbsolute(dir) ? dir : join(fileURLToPath(root), dir);
  for (const entry of readdirSync(abs, { withFileTypes: true })) {
    const p = join(abs, entry.name);
    if (entry.isDirectory()) sourceFiles(p, acc);
    else if (/\.(tsx|ts)$/.test(entry.name)) acc.push(p);
  }
  return acc;
};

const unmapped = [];
for (const file of [...sourceFiles('app'), ...sourceFiles('components')]) {
  const src = await readFile(file, 'utf8');
  for (const m of src.matchAll(
    /\b(bg|border)-((?:slate|emerald|blue|purple|amber|red|rose)-(?:50|100|200))\/(\d{1,3})\b/g
  )) {
    const rule = new RegExp(`\\.${m[1]}-${m[2]}\\\\/${m[3]}\\s*\\{`);
    if (!rule.test(globals)) unmapped.push(`${m[1]}-${m[2]}/${m[3]} (${file})`);
  }
}
assert.equal(
  unmapped.length,
  0,
  `translucent surface utility without a theme remap (renders light on the dark theme): ${[
    ...new Set(unmapped),
  ].join(', ')}`
);

// The theme remap block must stay in globals.css (single source of truth).
assert.match(globals, /TRANSLUCENT SURFACE VARIANTS/);
assert.match(globals, /\.bg-slate-50\\\/50 \{ background-color: color-mix/);

/* ---------------------------------------------------------------------------
 * The dashboard/admin shell must not let the *page* scroll: the sidebar is one
 * viewport tall and sticky, and `main` is the only scroll container. When the
 * document itself scrolled, the sidebar travelled with it and left a half-height
 * ("yarımqıq") bar behind.
 * ------------------------------------------------------------------------ */
for (const [name, shell] of [
  ['admin', code(adminLoginLayout)],
  ['dashboard', code(dashboardLayout)],
]) {
  assert.match(shell, /md:overflow-hidden/, `${name}: shell must clip, not scroll`);
  assert.match(shell, /<main[^>]*overflow-y-auto/, `${name}: main is not the scroll container`);
  // `flex-1` on the shell would set flex-basis, which beats `height` inside the
  // column-flex <body>: the shell grew to the content height, the document
  // scrolled and the sidebar was left as a half-height bar.
  assert.doesNotMatch(
    shell,
    /className="flex flex-1 flex-col/,
    `${name}: flex-1 on the shell overrides the 100dvh height`
  );
}
for (const [name, sidebar] of [
  ['admin', code(adminSidebar)],
  ['student', code(studentSidebar)],
]) {
  assert.match(sidebar, /sticky top-0/, `${name} sidebar: not pinned inside the shell`);
}

console.log('security regression checks: passed');
console.log('layout regression checks: passed');
console.log('theme regression checks: passed');
