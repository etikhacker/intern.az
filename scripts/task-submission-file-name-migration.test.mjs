import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { test } from 'node:test';

const migrationPath = new URL('../supabase/migrations/20261010080934_add_file_name_to_task_submissions.sql', import.meta.url);

test('task submission schema migration adds nullable file_name and refreshes PostgREST metadata', async () => {
  const sql = await readFile(migrationPath, 'utf8');

  assert.match(
    sql,
    /ALTER\s+TABLE\s+public\.task_submissions\s+ADD\s+COLUMN\s+IF\s+NOT\s+EXISTS\s+file_name\s+text\s*;/i,
  );
  assert.match(sql, /NOTIFY\s+pgrst\s*,\s*'reload schema'\s*;/i);
  assert.doesNotMatch(sql, /file_name\s+text\s+NOT\s+NULL/i);
});
