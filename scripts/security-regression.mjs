import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';

const read = (path) => readFile(new URL(`../${path}`, import.meta.url), 'utf8');

const [config, middleware, admin, students, migration, certificates, submissions, tasks] = await Promise.all([
  read('lib/supabase/config.ts'),
  read('lib/supabase/middleware.ts'),
  read('app/admin/page.tsx'),
  read('app/admin/students/page.tsx'),
  read('supabase/migrations/20260922000006_harden_storage_ownership.sql'),
  read('lib/certificates/service.ts'),
  read('lib/submissions/service.ts'),
  read('lib/tasks/service.ts'),
]);

assert.match(config, /process\.env\.SUPABASE_URL/);
assert.match(config, /process\.env\.SUPABASE_PUBLISHABLE_KEY/);
assert.match(middleware, /getSupabasePublicKey\(\)/);
assert.match(middleware, /getSupabaseUrl\(\)/);
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
