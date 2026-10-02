import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';

const read = (path) => readFile(new URL(`../${path}`, import.meta.url), 'utf8');

const [config, middleware, adminLayout, adminLogin, admin, students, migration, certificates, submissions, tasks, loginPage] = await Promise.all([
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

console.log('security regression checks: passed');
