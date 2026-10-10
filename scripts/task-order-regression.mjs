import assert from 'node:assert/strict';
import { groupStudentTasks } from '../lib/tasks/student-task-list.mjs';

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

console.log('Task-order regression checks passed.');
