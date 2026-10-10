import test from 'node:test';
import assert from 'node:assert/strict';
import React from 'react';
import { renderToStaticMarkup } from 'react-dom/server';

const articleModule = await import('../components/tasks/instruction-article.mjs').catch(() => null);

const brief = `## Məqsəd
API-nin davranışını sənədləşdir.

1. Endpoint-i təsvir et.
2. Sorğunu sına.

- README əlavə et.
- Uğursuz ssenarini qeyd et.`;

test('renders task brief headings and steps as readable semantic HTML', () => {
  assert.ok(articleModule, 'task instruction article component should exist');
  const html = renderToStaticMarkup(
    React.createElement(articleModule.TaskInstructionArticle, { content: brief }),
  );
  assert.match(html, /<h3[^>]*>Məqsəd<\/h3>/);
  assert.match(html, /<p[^>]*>API-nin davranışını sənədləşdir\.<\/p>/);
  assert.match(html, /<ol[^>]*><li[^>]*>Endpoint-i təsvir et\.<\/li><li[^>]*>Sorğunu sına\.<\/li><\/ol>/);
  assert.match(html, /<ul[^>]*><li[^>]*>README əlavə et\.<\/li><li[^>]*>Uğursuz ssenarini qeyd et\.<\/li><\/ul>/);
});

test('escapes HTML inside task content instead of injecting markup', () => {
  assert.ok(articleModule, 'task instruction article component should exist');
  const html = renderToStaticMarkup(
    React.createElement(articleModule.TaskInstructionArticle, { content: '<script>alert(1)</script>' }),
  );
  assert.doesNotMatch(html, /<script>/i);
  assert.match(html, /&lt;script&gt;alert\(1\)&lt;\/script&gt;/i);
});
