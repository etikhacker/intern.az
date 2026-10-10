import test from 'node:test';
import assert from 'node:assert/strict';
import { readdirSync, readFileSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const migrationsDir = fileURLToPath(new URL('../supabase/migrations/', import.meta.url));
const insertMigrationSuffix = '_fix_applications_student_insert_profile_ownership.sql';
const accessMigrationSuffix = '_fix_applications_profile_access_policies.sql';
const profileRelationsMigrationSuffix = '_align_student_profile_foreign_keys.sql';

test('application inserts are owned by the authenticated profile and cannot self-approve', () => {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(insertMigrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${insertMigrationSuffix}`);

  const sql = readFileSync(join(migrationsDir, migrationName), 'utf8');
  assert.match(sql, /drop\s+policy\s+if\s+exists\s+"applications_student_insert"\s+on\s+public\.applications/i);
  assert.match(sql, /drop\s+policy\s+if\s+exists\s+"Students can submit application"\s+on\s+public\.applications/i);
  assert.match(sql, /create\s+policy\s+"applications_student_insert"[\s\S]*?on\s+public\.applications[\s\S]*?for\s+insert\s+to\s+authenticated/i);
  assert.match(sql, /student_id\s+in\s*\(\s*select\s+p\.id\s+from\s+public\.profiles\s+as\s+p\s+where\s+p\.user_id\s*=\s*\(select\s+auth\.uid\(\)\)\s*\)/i);
  assert.match(sql, /status\s*=\s*'pending'/i);
  assert.match(sql, /admin_note\s+is\s+null/i);
  assert.match(sql, /reviewed_by\s+is\s+null/i);
  assert.match(sql, /reviewed_at\s+is\s+null/i);
  assert.match(sql, /not\s*\(select\s+private\.is_admin\(\)\)/i);
  assert.doesNotMatch(sql, /student_id\s*=\s*\(?select\s+auth\.uid\(/i);
});

test('application SELECT policy uses profile ownership and retains administrator visibility', () => {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(accessMigrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${accessMigrationSuffix}`);

  const sql = readFileSync(join(migrationsDir, migrationName), 'utf8');
  assert.match(sql, /create\s+policy\s+"applications_student_select"[\s\S]*?for\s+select\s+to\s+authenticated/i);
  assert.match(sql, /student_id\s+in\s*\(\s*select\s+p\.id\s+from\s+public\.profiles\s+as\s+p\s+where\s+p\.user_id\s*=\s*\(select\s+auth\.uid\(\)\)\s*\)\s+or\s+\(select\s+private\.is_admin\(\)\)/i);
  assert.doesNotMatch(sql, /auth\.uid\(\)\s*=\s*student_id/i);
});

test('student withdrawal policy preserves ownership in both update checks', () => {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(accessMigrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${accessMigrationSuffix}`);

  const sql = readFileSync(join(migrationsDir, migrationName), 'utf8');
  const updatePolicy = sql.match(/create\s+policy\s+"applications_student_update"[\s\S]*?;/i)?.[0];
  assert.ok(updatePolicy, 'expected a student update policy');
  assert.match(updatePolicy, /for\s+update\s+to\s+authenticated/i);
  assert.equal((updatePolicy.match(/student_id\s+in\s*\(/gi) ?? []).length, 2);
  assert.match(updatePolicy, /using\s*\([\s\S]*status\s*=\s*'pending'[\s\S]*\)\s*with\s+check\s*\([\s\S]*status\s*=\s*'withdrawn'[\s\S]*\)/i);
  assert.match(updatePolicy, /admin_note\s+is\s+null/i);
  assert.match(updatePolicy, /reviewed_by\s+is\s+null/i);
  assert.match(updatePolicy, /reviewed_at\s+is\s+null/i);
  assert.doesNotMatch(updatePolicy, /auth\.uid\(\)\s*=\s*student_id/i);
});

test('administrator review has a dedicated policy restricted to the trusted admin helper', () => {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(accessMigrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${accessMigrationSuffix}`);

  const sql = readFileSync(join(migrationsDir, migrationName), 'utf8');
  const adminPolicy = sql.match(/create\s+policy\s+"applications_admin_update"[\s\S]*?;/i)?.[0];
  assert.ok(adminPolicy, 'expected an administrator update policy');
  assert.match(adminPolicy, /for\s+update\s+to\s+authenticated/i);
  assert.match(adminPolicy, /using\s*\(\s*\(select\s+private\.is_admin\(\)\)\s*\)\s*with\s+check\s*\(\s*\(select\s+private\.is_admin\(\)\)\s*\)/i);
  assert.doesNotMatch(adminPolicy, /for\s+all/i);
});

test('application student foreign key references profiles.id rather than auth.users.id', () => {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(profileRelationsMigrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${profileRelationsMigrationSuffix}`);

  const sql = readFileSync(join(migrationsDir, migrationName), 'utf8');
  assert.match(sql, /alter\s+table\s+public\.applications\s+drop\s+constraint\s+if\s+exists\s+applications_student_id_fkey/i);
  assert.match(sql, /add\s+constraint\s+applications_student_id_fkey\s+foreign\s+key\s*\(\s*student_id\s*\)\s+references\s+public\.profiles\s*\(\s*id\s*\)\s+on\s+delete\s+cascade/i);
  assert.doesNotMatch(sql, /references\s+auth\.users\s*\(\s*id\s*\)/i);
});

test('enrollment student foreign key also references profiles.id', () => {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(profileRelationsMigrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${profileRelationsMigrationSuffix}`);

  const sql = readFileSync(join(migrationsDir, migrationName), 'utf8');
  assert.match(sql, /alter\s+table\s+public\.enrollments\s+drop\s+constraint\s+if\s+exists\s+enrollments_student_id_fkey/i);
  assert.match(sql, /add\s+constraint\s+enrollments_student_id_fkey\s+foreign\s+key\s*\(\s*student_id\s*\)\s+references\s+public\.profiles\s*\(\s*id\s*\)\s+on\s+delete\s+cascade/i);
});

test('student enrollment SELECT policy maps auth.uid() to profile.id', () => {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(profileRelationsMigrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${profileRelationsMigrationSuffix}`);

  const sql = readFileSync(join(migrationsDir, migrationName), 'utf8');
  const selectPolicy = sql.match(/create\s+policy\s+"enrollments_student_select"[\s\S]*?;/i)?.[0];
  assert.ok(selectPolicy, 'expected a student enrollment SELECT policy');
  assert.match(selectPolicy, /for\s+select\s+to\s+authenticated/i);
  assert.match(selectPolicy, /student_id\s+in\s*\(\s*select\s+p\.id\s+from\s+public\.profiles\s+as\s+p\s+where\s+p\.user_id\s*=\s*\(select\s+auth\.uid\(\)\)\s*\)\s+or\s+\(select\s+private\.is_admin\(\)\)/i);
  assert.doesNotMatch(selectPolicy, /auth\.uid\(\)\s*=\s*student_id/i);
});
