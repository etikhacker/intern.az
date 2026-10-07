import test from 'node:test';
import assert from 'node:assert/strict';

async function loadRequestHelper() {
  try {
    return await import('../lib/email/request-notification.ts');
  } catch {
    return {};
  }
}

test('notification request posts the selected event and record ID to the same-origin API', async () => {
  const { requestEmailNotification } = await loadRequestHelper();
  assert.equal(typeof requestEmailNotification, 'function', 'notification request helper must be implemented');

  let captured;
  const warning = await requestEmailNotification(
    'application-status',
    '123e4567-e89b-12d3-a456-426614174000',
    async (url, options) => {
      captured = { url, options };
      return { ok: true, json: async () => ({ sent: 1, skipped: 0, failed: 0 }) };
    }
  );

  assert.equal(warning, undefined);
  assert.equal(captured.url, '/api/notifications/send');
  assert.equal(captured.options.method, 'POST');
  assert.equal(captured.options.credentials, 'same-origin');
  assert.deepEqual(JSON.parse(captured.options.body), {
    event: 'application-status',
    id: '123e4567-e89b-12d3-a456-426614174000',
  });
});

test('a failed send is surfaced as a warning without reversing the saved admin action', async () => {
  const { requestEmailNotification } = await loadRequestHelper();
  assert.equal(typeof requestEmailNotification, 'function', 'notification request helper must be implemented');

  const warning = await requestEmailNotification('new-internship', '123e4567-e89b-12d3-a456-426614174001', async () => ({
    ok: false,
    json: async () => ({ error: 'Gmail göndərişi hələ konfiqurasiya edilməyib.' }),
  }));

  assert.equal(warning, 'Gmail göndərişi hələ konfiqurasiya edilməyib.');
});
