import { z } from 'zod';

export const applicationSchema = z.object({
  motivation: z
    .string()
    .trim()
    .min(50, { message: 'Motivasiya məktubu ən azı 50 simvoldan ibarət olmalıdır' })
    .max(3000, { message: 'Motivasiya məktubu 3000 simvoldan çox ola bilməz' }),
  experience: z
    .string()
    .trim()
    .max(2000, { message: 'Təcrübə təsviri 2000 simvoldan çox ola bilməz' })
    .optional()
    .or(z.literal('')),
  portfolio_url: z
    .string()
    .trim()
    .url({ message: 'Düzgün veb URL daxil edin (məs: https://portfolio.az)' })
    .optional()
    .or(z.literal('')),
  github_url: z
    .string()
    .trim()
    .url({ message: 'Düzgün GitHub profili daxil edin (məs: https://github.com/username)' })
    .optional()
    .or(z.literal('')),
  linkedin_url: z
    .string()
    .trim()
    .url({ message: 'Düzgün LinkedIn profili daxil edin (məs: https://linkedin.com/in/username)' })
    .optional()
    .or(z.literal('')),
});

export type ApplicationFormData = z.infer<typeof applicationSchema>;
