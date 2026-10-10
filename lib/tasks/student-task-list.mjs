/**
 * Group a student's assigned tasks by curriculum week, ordered by task number.
 * The task list is independent of submissions so new work remains visible.
 * @param {import('../../types/database').InternshipTask[]} tasks
 * @param {import('../../types/database').TaskSubmission[]} submissions
 * @returns {Array<{weekNumber: number, tasks: Array<{task: import('../../types/database').InternshipTask, submission: import('../../types/database').TaskSubmission|null, status: import('../../types/database').SubmissionStatus|'not_submitted'}>} >}
 */
export function groupStudentTasks(tasks = [], submissions = []) {
  const submissionByTask = new Map();
  for (const submission of submissions) {
    if (!submissionByTask.has(submission.task_id)) {
      submissionByTask.set(submission.task_id, submission);
    }
  }

  const sortedTasks = [...tasks].sort((a, b) =>
    a.week_number - b.week_number || a.task_number - b.task_number,
  );
  const weeks = new Map();

  for (const task of sortedTasks) {
    if (!weeks.has(task.week_number)) weeks.set(task.week_number, []);
    const submission = submissionByTask.get(task.id) ?? null;
    weeks.get(task.week_number).push({
      task,
      submission,
      status: submission?.status ?? 'not_submitted',
    });
  }

  return [...weeks.entries()].map(([weekNumber, weekTasks]) => ({
    weekNumber,
    tasks: weekTasks,
  }));
}
