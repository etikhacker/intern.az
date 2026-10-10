/**
 * @typedef {{ type: 'heading', level: 1|2|3, text: string }} HeadingBlock
 * @typedef {{ type: 'paragraph', text: string }} ParagraphBlock
 * @typedef {{ type: 'ordered-list'|'unordered-list', items: string[] }} ListBlock
 * @typedef {{ type: 'blockquote', text: string }} QuoteBlock
 * @typedef {{ type: 'code-block', text: string }} CodeBlock
 * @typedef {HeadingBlock|ParagraphBlock|ListBlock|QuoteBlock|CodeBlock} TaskMarkdownBlock
 */

/**
 * Pick a locale section from a value wrapped in [[AZ]] and [[EN]] markers.
 * Plain legacy content is returned unchanged for backward compatibility.
 *
 * @param {unknown} value
 * @param {'az'|'en'} locale
 * @returns {string}
 */
export function extractLocalizedTaskText(value, locale) {
  if (typeof value !== 'string') return '';

  const source = value.trim();
  const markers = [...source.matchAll(/^\[\[(AZ|EN)\]\]\s*$/gim)];
  if (markers.length !== 2 || markers[0][1].toUpperCase() !== 'AZ' || markers[1][1].toUpperCase() !== 'EN') {
    return source;
  }

  const azStart = markers[0].index + markers[0][0].length;
  const enStart = markers[1].index;
  const enContentStart = markers[1].index + markers[1][0].length;
  const sections = {
    az: source.slice(azStart, enStart).trim(),
    en: source.slice(enContentStart).trim(),
  };

  if (!sections.az || !sections.en) return source;
  return sections[locale] || sections[locale === 'az' ? 'en' : 'az'];
}

/**
 * Parse the small, safe Markdown subset used in task briefs into render blocks.
 * No HTML is interpreted; all block values are plain text.
 *
 * @param {string} markdown
 * @returns {TaskMarkdownBlock[]}
 */
export function parseTaskMarkdown(markdown) {
  const lines = String(markdown ?? '').replace(/\r\n?/g, '\n').split('\n');
  /** @type {TaskMarkdownBlock[]} */
  const blocks = [];
  let index = 0;

  const isListLine = (line) => /^(\s*[-*+]\s+|\s*\d+[.)]\s+)/.test(line);
  const isBlockStart = (line) => /^(#{1,3})\s+/.test(line) || /^\s*```/.test(line) || /^\s*>/.test(line) || isListLine(line);

  while (index < lines.length) {
    const line = lines[index];
    if (!line.trim()) {
      index += 1;
      continue;
    }

    const heading = line.match(/^(#{1,3})\s+(.+?)\s*#*\s*$/);
    if (heading) {
      blocks.push({ type: 'heading', level: /** @type {1|2|3} */ (heading[1].length), text: heading[2].trim() });
      index += 1;
      continue;
    }

    if (/^\s*```/.test(line)) {
      index += 1;
      const codeLines = [];
      while (index < lines.length && !/^\s*```/.test(lines[index])) {
        codeLines.push(lines[index]);
        index += 1;
      }
      if (index < lines.length) index += 1;
      blocks.push({ type: 'code-block', text: codeLines.join('\n') });
      continue;
    }

    if (/^\s*>/.test(line)) {
      const quoteLines = [];
      while (index < lines.length && /^\s*>/.test(lines[index])) {
        quoteLines.push(lines[index].replace(/^\s*>\s?/, ''));
        index += 1;
      }
      blocks.push({ type: 'blockquote', text: quoteLines.join('\n') });
      continue;
    }

    if (isListLine(line)) {
      const ordered = /^\s*\d+[.)]\s+/.test(line);
      const items = [];
      while (index < lines.length && isListLine(lines[index]) && /^\s*\d+[.)]\s+/.test(lines[index]) === ordered) {
        items.push(lines[index].replace(/^\s*(?:[-*+]\s+|\d+[.)]\s+)/, '').trim());
        index += 1;
      }
      blocks.push({ type: ordered ? 'ordered-list' : 'unordered-list', items });
      continue;
    }

    const paragraphLines = [];
    while (index < lines.length && lines[index].trim() && !isBlockStart(lines[index])) {
      paragraphLines.push(lines[index].trim());
      index += 1;
    }
    if (paragraphLines.length) blocks.push({ type: 'paragraph', text: paragraphLines.join(' ') });
  }

  return blocks;
}
