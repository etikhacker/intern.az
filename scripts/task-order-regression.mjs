import assert from 'node:assert/strict';
import { groupStudentTasks } from '../lib/tasks/student-task-list.mjs';
import { getLocalizedTaskTitle } from '../lib/tasks/localized-title.mjs';

const tasks = [
  { id: 'metrics', week_number: 6, task_number: 9, title: 'Automation Metrics' },
  { id: 'final', week_number: 6, task_number: 4, title: 'Final Automation Case Study' },
  { id: 'handoff', week_number: 6, task_number: 10, title: 'Automation Case Handoff' },
  { id: 'earlier', week_number: 5, task_number: 8, title: 'Notification Flow' },
];

const groups = groupStudentTasks(tasks, []);
assert.deepEqual(groups.map((group) => group.weekNumber), [5, 6]);
assert.deepEqual(
  groups.find((group) => group.weekNumber === 6).tasks.map(({ task }) => task.id),
  ['metrics', 'handoff', 'final'],
  'final/capstone task should appear after the supporting tasks in the same week',
);

assert.equal(getLocalizedTaskTitle('Final Automation Case Study', 'az'), 'Yekun avtomatlaşdırma layihəsi');
assert.equal(getLocalizedTaskTitle('Final Automation Case Study', 'en'), 'Final Automation Case Study');
assert.equal(getLocalizedTaskTitle('Future New Task', 'az'), 'Future New Task');

console.log('Task ordering and localized-title regression checks passed.');
