import test from 'node:test';
import assert from 'node:assert/strict';
import { groupStudentTasks } from '../lib/tasks/student-task-list.mjs';

test('keeps every assigned task visible, sorts by week, and attaches its submission status', () => {
  const tasks = [
    { id: 'task-4', week_number: 4, task_number: 2, title: 'Task four' },
    { id: 'task-1b', week_number: 1, task_number: 2, title: 'Task one B' },
    { id: 'task-1a', week_number: 1, task_number: 1, title: 'Task one A' },
  ];
  const submissions = [
    { id: 'sub-1', task_id: 'task-1a', status: 'approved' },
    { id: 'sub-2', task_id: 'task-4', status: 'revision_requested' },
  ];

  assert.deepEqual(groupStudentTasks(tasks, submissions), [
    {
      weekNumber: 1,
      tasks: [
        { task: tasks[2], submission: submissions[0], status: 'approved' },
        { task: tasks[1], submission: null, status: 'not_submitted' },
      ],
    },
    {
      weekNumber: 4,
      tasks: [
        { task: tasks[0], submission: submissions[1], status: 'revision_requested' },
      ],
    },
  ]);
});

test('returns a visible empty curriculum when no published tasks are assigned', () => {
  assert.deepEqual(groupStudentTasks([], []), []);
});
