import * as React from 'react';
import { cn } from '@/lib/utils';

/**
 * Renders task instructions written in a tiny Markdown subset:
 *   ## Heading
 *   - bullet            (indent with spaces for a sub-item)
 *   1. numbered step    (indent with spaces for a sub-item)
 *   **bold**   `code`   ``` fenced code ```
 * Everything is rendered as React text nodes (no HTML injection), so admin-entered
 * text cannot inject markup. Plain text without any markers still renders fine.
 */

type Variant = 'light' | 'dark';

type Block =
  | { type: 'heading'; text: string }
  | { type: 'paragraph'; text: string }
  | { type: 'list'; marker: string; text: string; indent: number }
  | { type: 'code'; text: string };

function parseBlocks(source: string): Block[] {
  const blocks: Block[] = [];
  const lines = source.replace(/\r\n/g, '\n').split('\n');
  let i = 0;

  while (i < lines.length) {
    const line = lines[i];

    if (line.trim().startsWith('```')) {
      const code: string[] = [];
      i++;
      while (i < lines.length && !lines[i].trim().startsWith('```')) {
        code.push(lines[i]);
        i++;
      }
      i++; // closing fence
      blocks.push({ type: 'code', text: code.join('\n') });
      continue;
    }

    if (!line.trim()) {
      i++;
      continue;
    }

    const heading = line.match(/^#{1,3}\s+(.*)$/);
    if (heading) {
      blocks.push({ type: 'heading', text: heading[1].trim() });
      i++;
      continue;
    }

    const bullet = line.match(/^(\s*)[-*]\s+(.*)$/);
    if (bullet) {
      blocks.push({ type: 'list', marker: '•', text: bullet[2], indent: Math.min(Math.floor(bullet[1].length / 2), 3) });
      i++;
      continue;
    }

    const numbered = line.match(/^(\s*)(\d+)[.)]\s+(.*)$/);
    if (numbered) {
      blocks.push({
        type: 'list',
        marker: `${numbered[2]}.`,
        text: numbered[3],
        indent: Math.min(Math.floor(numbered[1].length / 2), 3),
      });
      i++;
      continue;
    }

    blocks.push({ type: 'paragraph', text: line.trim() });
    i++;
  }

  return blocks;
}

function renderInline(text: string, variant: Variant): React.ReactNode[] {
  const codeClass =
    variant === 'dark'
      ? 'rounded bg-slate-800 px-1 py-0.5 font-mono text-[0.92em] text-amber-300'
      : 'rounded bg-slate-100 px-1 py-0.5 font-mono text-[0.92em] text-slate-800';

  return text.split(/(\*\*[^*]+\*\*|`[^`]+`)/g).filter(Boolean).map((part, idx) => {
    if (part.startsWith('**') && part.endsWith('**') && part.length > 4) {
      return (
        <strong key={idx} className="font-semibold">
          {part.slice(2, -2)}
        </strong>
      );
    }
    if (part.startsWith('`') && part.endsWith('`') && part.length > 2) {
      return (
        <code key={idx} className={codeClass}>
          {part.slice(1, -1)}
        </code>
      );
    }
    return <React.Fragment key={idx}>{part}</React.Fragment>;
  });
}

const INDENT_CLASS = ['', 'pl-5', 'pl-10', 'pl-14'];

export function TaskInstructions({
  text,
  variant = 'light',
  className,
}: {
  text: string;
  variant?: Variant;
  className?: string;
}) {
  const blocks = React.useMemo(() => parseBlocks(text || ''), [text]);
  const dark = variant === 'dark';

  const bodyText = dark ? 'text-slate-300' : 'text-slate-700';
  const headingText = dark ? 'text-white' : 'text-slate-900';
  const markerText = dark ? 'text-amber-400' : 'text-emerald-600';

  return (
    <div className={cn('space-y-2 text-sm leading-relaxed', bodyText, className)}>
      {blocks.map((block, idx) => {
        switch (block.type) {
          case 'heading':
            return (
              <h4
                key={idx}
                className={cn(
                  'pt-3 text-xs font-bold uppercase tracking-wider first:pt-0',
                  headingText
                )}
              >
                {block.text}
              </h4>
            );
          case 'list':
            return (
              <div key={idx} className={cn('flex gap-2', INDENT_CLASS[block.indent])}>
                <span className={cn('w-5 shrink-0 text-right font-semibold', markerText)}>
                  {block.marker}
                </span>
                <span className="min-w-0 flex-1">{renderInline(block.text, variant)}</span>
              </div>
            );
          case 'code':
            return (
              <pre
                key={idx}
                className={cn(
                  'overflow-x-auto rounded-lg border p-3 font-mono text-xs',
                  dark
                    ? 'border-slate-800 bg-slate-900 text-slate-300'
                    : 'border-slate-200 bg-slate-50 text-slate-800'
                )}
              >
                {block.text}
              </pre>
            );
          default:
            return <p key={idx}>{renderInline(block.text, variant)}</p>;
        }
      })}
    </div>
  );
}
