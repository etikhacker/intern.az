import { z } from 'zod';

export const profileUpdateSchema = z.object({
  fullName: z
    .string()
    .trim()
    .min(2, { message: 'Full name must be at least 2 characters long' })
    .max(100, { message: 'Full name cannot exceed 100 characters' }),
  phone: z
    .string()
    .trim()
    .max(30, { message: 'Phone number cannot exceed 30 characters' })
    .optional()
    .or(z.literal('')),
  university: z
    .string()
    .trim()
    .max(120, { message: 'University cannot exceed 120 characters' })
    .optional()
    .or(z.literal('')),
  avatarUrl: z
    .string()
    .trim()
    .url({ message: 'Please enter a valid image URL' })
    .optional()
    .or(z.literal('')),
});

export type ProfileUpdateFormData = z.infer<typeof profileUpdateSchema>;
