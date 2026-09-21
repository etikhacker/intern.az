import { InternshipTask, TaskSubmission } from '@/types/database';

export interface ProgressResult {
  totalTasks: number;
  requiredTasks: number;
  approvedCount: number;
  pendingCount: number;
  revisionCount: number;
  rejectedCount: number;
  percentage: number;
  isAllRequiredCompleted: boolean;
}

export function calculateInternshipProgress(
  tasks: InternshipTask[],
  submissions: TaskSubmission[]
): ProgressResult {
  // Only consider published tasks
  const publishedTasks = tasks.filter((t) => t.status === 'published');
  const requiredTasks = publishedTasks.filter((t) => t.is_required);

  const subMap = new Map<string, TaskSubmission>();
  for (const s of submissions) {
    // latest submission per task
    if (!subMap.has(s.task_id)) {
      subMap.set(s.task_id, s);
    }
  }

  let approvedCount = 0;
  let pendingCount = 0;
  let revisionCount = 0;
  let rejectedCount = 0;

  for (const task of publishedTasks) {
    const sub = subMap.get(task.id);
    if (!sub) continue;

    if (sub.status === 'approved') {
      approvedCount++;
    } else if (sub.status === 'pending') {
      pendingCount++;
    } else if (sub.status === 'revision_requested') {
      revisionCount++;
    } else if (sub.status === 'rejected') {
      rejectedCount++;
    }
  }

  const denominator = requiredTasks.length > 0 ? requiredTasks.length : publishedTasks.length;
  const percentage = denominator > 0 ? Math.min(100, Math.round((approvedCount / denominator) * 100)) : 0;
  const isAllRequiredCompleted =
    requiredTasks.length > 0 &&
    requiredTasks.every((task) => {
      const sub = subMap.get(task.id);
      return sub && sub.status === 'approved';
    });

  return {
    totalTasks: publishedTasks.length,
    requiredTasks: requiredTasks.length,
    approvedCount,
    pendingCount,
    revisionCount,
    rejectedCount,
    percentage,
    isAllRequiredCompleted,
  };
}
