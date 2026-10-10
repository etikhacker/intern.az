-- Prevent students from overwriting uploaded task evidence or payment receipts.
-- Student uploads use unique paths and INSERT policies; UPDATE is reserved for admins.
BEGIN;

DROP POLICY IF EXISTS task_files_update ON storage.objects;
CREATE POLICY task_files_update
  ON storage.objects
  FOR UPDATE
  TO authenticated
  USING (bucket_id = 'task-submissions' AND (SELECT private.is_admin()))
  WITH CHECK (bucket_id = 'task-submissions' AND (SELECT private.is_admin()));

DROP POLICY IF EXISTS certificate_payment_files_update ON storage.objects;
CREATE POLICY certificate_payment_files_update
  ON storage.objects
  FOR UPDATE
  TO authenticated
  USING (bucket_id = 'certificate-payments' AND (SELECT private.is_admin()))
  WITH CHECK (bucket_id = 'certificate-payments' AND (SELECT private.is_admin()));

COMMIT;
