export const SOLE_ADMIN_EMAIL = 'babayev.omr.23@gmail.com';

export function isSoleAdminEmail(email: string | null | undefined): boolean {
  return (email || '').trim().toLowerCase() === SOLE_ADMIN_EMAIL;
}
