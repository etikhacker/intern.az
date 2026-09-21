import { z } from 'zod';

export const submissionSchema = z.object({
  text_answer: z.string().trim().optional().or(z.literal('')),
  submission_url: z.string().trim().optional().or(z.literal('')),
  github_url: z.string().trim().optional().or(z.literal('')),
  file_path: z.string().trim().optional().or(z.literal('')),
  file_name: z.string().trim().optional().or(z.literal('')),
  comment: z.string().trim().max(1000, { message: 'Şərh 1000 simvoldan çox ola bilməz' }).optional().or(z.literal('')),
});

export type SubmissionFormData = z.infer<typeof submissionSchema>;

export const adminReviewSchema = z.object({
  action: z.enum(['approve', 'revision_requested', 'reject'], {
    message: 'Qərar növü seçilməlidir',
  }),
  admin_feedback: z.string().trim().optional().or(z.literal('')),
}).refine(
  (data) => {
    if (data.action === 'revision_requested' || data.action === 'reject') {
      return !!data.admin_feedback && data.admin_feedback.length >= 5;
    }
    return true;
  },
  {
    message: 'Düzəliş tələb edildikdə və ya rədd edildikdə səbəb və rəy mütləq qeyd edilməlidir (ən azı 5 simvol).',
    path: ['admin_feedback'],
  }
);

export type AdminReviewFormData = z.infer<typeof adminReviewSchema>;
