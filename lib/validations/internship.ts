import { z } from 'zod';

export const internshipSchema = z.object({
  title: z
    .string()
    .trim()
    .min(3, { message: 'Başlıq ən azı 3 simvol olmalıdır' })
    .max(150, { message: 'Başlıq 150 simvoldan çox ola bilməz' }),
  slug: z
    .string()
    .trim()
    .min(3, { message: 'Slug ən azı 3 simvol olmalıdır' })
    .max(150, { message: 'Slug 150 simvoldan çox ola bilməz' })
    .regex(/^[a-z0-9]+(?:-[a-z0-9]+)*$/, {
      message: 'Slug yalnız kiçik hərflər, rəqəmlər və tire (-) ehtiva edə bilər (məs: frontend-developer)',
    }),
  short_description: z
    .string()
    .trim()
    .min(10, { message: 'Qısa təsvir ən azı 10 simvol olmalıdır' })
    .max(300, { message: 'Qısa təsvir 300 simvoldan çox ola bilməz' }),
  description: z
    .string()
    .trim()
    .min(30, { message: 'Ətraflı təsvir ən azı 30 simvol olmalıdır' }),
  category: z
    .string()
    .trim()
    .min(2, { message: 'İstiqamət qeyd olunmalıdır' }),
  duration_weeks: z.coerce
    .number()
    .int()
    .min(1, { message: 'Müddət ən azı 1 həftə olmalıdır' })
    .max(52, { message: 'Müddət 52 həftədən çox ola bilməz' }),
  difficulty: z.enum(['beginner', 'intermediate', 'advanced'], {
    message: 'Çətinlik səviyyəsi seçilməlidir',
  }),
  skills: z
    .array(z.string().trim())
    .min(1, { message: 'Ən azı 1 bacarıq əlavə edilməlidir' }),
  requirements: z
    .array(z.string().trim())
    .min(1, { message: 'Ən azı 1 tələb qeyd olunmalıdır' }),
  responsibilities: z
    .array(z.string().trim())
    .min(1, { message: 'Ən azı 1 vəzifə/öhdəlik qeyd olunmalıdır' }),
  benefits: z
    .array(z.string().trim())
    .min(1, { message: 'Ən azı 1 üstünlük qeyd olunmalıdır' }),
  max_students: z.coerce
    .number()
    .int()
    .positive({ message: 'Tələbə sayı müsbət rəqəm olmalıdır' })
    .nullable()
    .optional(),
  status: z.enum(['draft', 'published', 'closed', 'archived']),
  application_deadline: z
    .string()
    .nullable()
    .optional(),
  start_date: z
    .string()
    .nullable()
    .optional(),
});

export type InternshipFormData = z.infer<typeof internshipSchema>;
