import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { test } from 'node:test';

const migrationPath = new URL('../supabase/migrations/20261010082947_add_student_owned_repo_workflow_to_curriculum.sql', import.meta.url);
const sql = await readFile(migrationPath, 'utf8');

test('curriculum repo workflow migration is bilingual, guarded, and updates the existing 80 tasks only once', () => {
  assert.match(sql, /BEGIN;[\s\S]*LOCK TABLE public\.internship_tasks IN SHARE ROW EXCLUSIVE MODE/i);
  assert.match(sql, /candidate_count <> 80/i);
  assert.match(sql, /updated_count <> 80/i);
  assert.match(sql, /task\.instructions NOT LIKE '%## GitHub repozitoriyası və davamlılıq%'/i);
  assert.match(sql, /task\.instructions NOT LIKE '%## GitHub repository and continuity%'/i);
  assert.match(sql, /CASE WHEN task\.task_number = 1 THEN \$repo_workflow_az_first\$/i);
  assert.match(sql, /CASE WHEN task\.task_number = 1 THEN \$repo_workflow_en_first\$/i);
  assert.match(sql, /### İlk tapşırıq — öz repozitoriyanı yarat/);
  assert.match(sql, /### Task 1 — create your own repository/);
  assert.match(sql, /### Əvvəlki tapşırığın davamı — eyni repoda işlə/);
  assert.match(sql, /### Continuation — keep working in the same repository/);
  assert.match(sql, /lpad\(task\.task_number::TEXT, 2, '0'\)/i);
  assert.match(sql, /COMMIT;\s*$/i);
});
