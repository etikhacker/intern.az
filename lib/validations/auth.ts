import { z } from 'zod';

export const registerSchema = z.object({
  fullName: z
    .string()
    .trim()
    .min(2, { message: 'Full name must be at least 2 characters long' })
    .max(100, { message: 'Full name cannot exceed 100 characters' }),
  email: z
    .string()
    .trim()
    .email({ message: 'Please enter a valid email address' })
    .toLowerCase(),
  password: z
    .string()
    .min(6, { message: 'Password must be at least 6 characters long' })
    .max(72, { message: 'Password cannot exceed 72 characters' }),
  university: z
    .string()
    .trim()
    .min(2, { message: 'Please enter your university name (e.g. ADA, BSU, ASOIU, BEU)' })
    .max(120, { message: 'University name cannot exceed 120 characters' }),
});

export type RegisterFormData = z.infer<typeof registerSchema>;

export const loginSchema = z.object({
  email: z
    .string()
    .trim()
    .email({ message: 'Please enter a valid email address' })
    .toLowerCase(),
  password: z
    .string()
    .min(1, { message: 'Password is required' }),
});

export type LoginFormData = z.infer<typeof loginSchema>;
