import test from 'node:test';
import assert from 'node:assert/strict';

const taskContentModule = await import('../lib/tasks/content.mjs').catch(() => null);

const bilingual = `[[AZ]]
## Məqsəd
Tələbə təhlükəsiz API qurur.

1. Endpoint-i təsvir et.
2. Girişləri yoxla.

[[EN]]
## Objective
Build a secure API.

1. Describe the endpoint.
2. Validate inputs.`;

test('selects the requested Azerbaijani or English task brief', () => {
  assert.ok(taskContentModule, 'task content utility should exist');
  assert.equal(
    taskContentModule.extractLocalizedTaskText(bilingual, 'az'),
    '## Məqsəd\nTələbə təhlükəsiz API qurur.\n\n1. Endpoint-i təsvir et.\n2. Girişləri yoxla.',
  );
  assert.equal(
    taskContentModule.extractLocalizedTaskText(bilingual, 'en'),
    '## Objective\nBuild a secure API.\n\n1. Describe the endpoint.\n2. Validate inputs.',
  );
});

test('keeps existing plain-text task instructions readable for both locales', () => {
  assert.ok(taskContentModule, 'task content utility should exist');
  const legacy = 'Submit your work as a GitHub repository with a README.';
  assert.equal(taskContentModule.extractLocalizedTaskText(legacy, 'az'), legacy);
  assert.equal(taskContentModule.extractLocalizedTaskText(legacy, 'en'), legacy);
});

test('turns headings, paragraphs, ordered and unordered lists into safe render blocks', () => {
  assert.ok(taskContentModule, 'task content utility should exist');
  assert.deepEqual(taskContentModule.parseTaskMarkdown(
    '## Objective\nBuild a secure API.\n\n1. Describe the endpoint.\n2. Validate inputs.\n\n- Add a README.\n- Include a test.\n\n> Use only synthetic data.',
  ), [
    { type: 'heading', level: 2, text: 'Objective' },
    { type: 'paragraph', text: 'Build a secure API.' },
    { type: 'ordered-list', items: ['Describe the endpoint.', 'Validate inputs.'] },
    { type: 'unordered-list', items: ['Add a README.', 'Include a test.'] },
    { type: 'blockquote', text: 'Use only synthetic data.' },
  ]);
});

test('falls back to the original content if localization markers are malformed', () => {
  assert.ok(taskContentModule, 'task content utility should exist');
  const malformed = '[[AZ]]\nAzerbaijani only, no English marker';
  assert.equal(taskContentModule.extractLocalizedTaskText(malformed, 'en'), malformed);
});
