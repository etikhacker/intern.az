import nodemailer, { type Transporter } from 'nodemailer';
import {
  getGmailSettings,
  sendGmailBatch,
  sendGmailMessage,
  type EmailMessage,
} from './gmail-helpers';

let cachedTransport: { cacheKey: string; transport: Transporter } | null = null;

function getTransporter(settings: NonNullable<ReturnType<typeof getGmailSettings>>): Transporter {
  const cacheKey = `${settings.user}:${settings.password}`;
  if (cachedTransport?.cacheKey === cacheKey) return cachedTransport.transport;

  const transport = nodemailer.createTransport({
    host: settings.host,
    port: settings.port,
    secure: settings.secure,
    pool: true,
    maxConnections: 1,
    maxMessages: 100,
    auth: {
      user: settings.user,
      pass: settings.password,
    },
    connectionTimeout: 10_000,
    greetingTimeout: 10_000,
    socketTimeout: 20_000,
  });

  cachedTransport = { cacheKey, transport };
  return transport;
}

export function isGmailConfigured(): boolean {
  return getGmailSettings(process.env) !== null;
}

export async function sendGmailEmail(recipient: string, message: EmailMessage): Promise<void> {
  const settings = getGmailSettings(process.env);
  if (!settings) {
    throw new Error('GMAIL_NOT_CONFIGURED');
  }

  await sendGmailMessage(getTransporter(settings), settings, recipient, message);
}

export async function sendGmailBatchEmail(recipients: string[], message: EmailMessage): Promise<void> {
  if (recipients.length === 0) return;

  const settings = getGmailSettings(process.env);
  if (!settings) {
    throw new Error('GMAIL_NOT_CONFIGURED');
  }

  await sendGmailBatch(getTransporter(settings), settings, recipients, message);
}
