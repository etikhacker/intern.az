export function formatDate(value: string | Date | null | undefined): string {
  if (!value) return '—';

  const date = value instanceof Date ? value : new Date(value);
  if (Number.isNaN(date.getTime())) return '—';

  return new Intl.DateTimeFormat('az-AZ', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
  }).format(date);
}

export function formatDateTime(value: string | Date | null | undefined): string {
  if (!value) return '—';

  const date = value instanceof Date ? value : new Date(value);
  if (Number.isNaN(date.getTime())) return '—';

  return `${formatDate(date)} ${new Intl.DateTimeFormat('az-AZ', {
    hour: '2-digit',
    minute: '2-digit',
  }).format(date)}`;
}
