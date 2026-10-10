import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, readdirSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const migrationsDir = fileURLToPath(new URL('../supabase/migrations/', import.meta.url));
const migrationSuffix = '_fix_internship_task_visibility_profile_ids.sql';

function readVisibilityMigration() {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(migrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${migrationSuffix}`);
  return readFileSync(join(migrationsDir, migrationName), 'utf8');
}

test('active students can read published tasks through their profile ID mapping', () => {
  const sql = readVisibilityMigration();
  const studentPolicy = sql.match(/create\s+policy\s+tasks_student_select[\s\S]*?;/i)?.[0];

  assert.ok(studentPolicy, 'the migration must create a student task SELECT policy');
  assert.match(studentPolicy, /status\s*=\s*'published'/i);
  assert.match(studentPolicy, /e\.status\s*=\s*'active'/i);
  assert.match(studentPolicy, /join\s+public\.profiles\s+(?:as\s+)?p\s+on\s+p\.id\s*=\s*e\.student_id/i);
  assert.match(studentPolicy, /p\.user_id\s*=\s*\(\s*select\s+auth\.uid\s*\(\s*\)\s*\)/i);
  assert.doesNotMatch(studentPolicy, /e\.student_id\s*=\s*\(\s*select\s+auth\.uid/i);
});

test('the corrected student policy does not remove administrators task visibility', () => {
  const sql = readVisibilityMigration();
  const adminPolicy = sql.match(/create\s+policy\s+tasks_admin_select[\s\S]*?;/i)?.[0];

  assert.ok(adminPolicy, 'the migration must retain a separate administrator SELECT policy');
  assert.match(adminPolicy, /for\s+select\s+to\s+authenticated/i);
  assert.match(adminPolicy, /using\s*\(\s*\(?\s*select\s+private\.is_admin\s*\(\s*\)/i);
});
