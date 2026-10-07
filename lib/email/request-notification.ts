export type EmailNotificationEvent = 'application-status' | 'new-internship';

interface NotificationResponse {
  error?: unknown;
  failed?: unknown;
  capped?: unknown;
}

export async function requestEmailNotification(
  event: EmailNotificationEvent,
  id: string,
  fetcher: typeof fetch = fetch
): Promise<string | undefined> {
  try {
    const response = await fetcher('/api/notifications/send', {
      method: 'POST',
      credentials: 'same-origin',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ event, id }),
    });

    const payload = (await response.json().catch(() => null)) as NotificationResponse | null;
    if (!response.ok) {
      return typeof payload?.error === 'string'
        ? payload.error
        : 'Bildiriş e-poçtunu göndərmək mümkün olmadı.';
    }

    if (typeof payload?.failed === 'number' && payload.failed > 0) {
      return `${payload.failed} e-poçt göndərilə bilmədi.`;
    }
    if (payload?.capped === true) {
      return 'Gmail gündəlik limitinə görə bütün istifadəçilərə e-poçt çatdırılmadı.';
    }

    return undefined;
  } catch {
    return 'Bildiriş e-poçtunu göndərmək mümkün olmadı.';
  }
}
