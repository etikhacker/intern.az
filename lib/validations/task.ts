import { z } from 'zod';

export const taskSchema = z.object({
  title: z
    .string()
    .trim()
    .min(3, { message: 'Tapşırıq başlığı ən azı 3 simvol olmalıdır' })
    .max(200, { message: 'Tapşırıq başlığı 200 simvoldan çox ola bilməz' }),
  description: z
    .string()
    .trim()
    .min(10, { message: 'Qısa təsvir ən azı 10 simvol olmalıdır' })
    .max(2000, { message: 'Qısa təsvir 2000 simvoldan çox ola bilməz' }),
  instructions: z
    .string()
    .trim()
    .min(10, { message: 'İcra təlimatları ən azı 10 simvol olmalıdır' })
    .max(10000, { message: 'İcra təlimatları 10000 simvoldan çox ola bilməz' }),
  week_number: z.coerce
    .number()
    .int()
    .min(1, { message: 'Həftə nömrəsi ən azı 1 olmalıdır' })
    .max(52, { message: 'Həftə nömrəsi 52-dən çox ola bilməz' }),
  task_number: z.coerce
    .number()
    .int()
    .min(1, { message: 'Tapşırıq nömrəsi ən azı 1 olmalıdır' })
    .max(100, { message: 'Tapşırıq nömrəsi 100-dən çox ola bilməz' }),
  difficulty: z.enum(['beginner', 'intermediate', 'advanced'], {
    message: 'Çətinlik səviyyəsi seçilməlidir',
  }),
  submission_type: z.enum(['text', 'link', 'file', 'github', 'multiple'], {
    message: 'Təqdimat növü seçilməlidir',
  }),
  deadline: z
    .string()
    .optional()
    .nullable()
    .or(z.literal('')),
  is_required: z.boolean().default(true),
  status: z.enum(['draft', 'published', 'archived'], {
    message: 'Status seçilməlidir',
  }),
});

export type TaskFormData = z.infer<typeof taskSchema>;
