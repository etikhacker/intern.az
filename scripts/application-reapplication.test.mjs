import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, readdirSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const migrationsDir = fileURLToPath(new URL('../supabase/migrations/', import.meta.url));
const migrationSuffix = '_allow_rejected_reapplications.sql';

test('a rejected application does not prevent a new application for the same internship', () => {
  const migrationName = readdirSync(migrationsDir).find((name) => name.endsWith(migrationSuffix));
  assert.ok(migrationName, `expected a migration ending in ${migrationSuffix}`);

  const sql = readFileSync(join(migrationsDir, migrationName), 'utf8');
  const dropConstraintPosition = sql.search(
    /alter\s+table\s+public\.applications\s+drop\s+constraint\s+if\s+exists\s+applications_internship_id_student_id_key/i
  );
  const dropIndexPosition = sql.search(
    /drop\s+index\s+if\s+exists\s+public\.idx_unique_active_student_application/i
  );
  const createIndexPosition = sql.search(
    /create\s+unique\s+index\s+idx_unique_active_student_application\s+on\s+public\.applications\s*\(\s*internship_id\s*,\s*student_id\s*\)/i
  );

  assert.notEqual(dropConstraintPosition, -1, 'the production global unique constraint must be removed');
  assert.notEqual(dropIndexPosition, -1, 'the potentially stale partial-index definition must be removed explicitly');
  assert.ok(
    createIndexPosition > Math.max(dropConstraintPosition, dropIndexPosition),
    'the corrected active-only index must be created after removing conflicting uniqueness'
  );
  assert.match(sql, /where\s+status\s+in\s*\(\s*'pending'\s*,\s*'accepted'\s*\)/i);
});
