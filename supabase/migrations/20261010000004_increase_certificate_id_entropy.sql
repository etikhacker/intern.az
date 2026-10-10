-- Increase public certificate verification ID entropy to match the app's
-- eight-character, grouped ID format. There are currently no issued certificates,
-- so this only changes IDs generated from this point forward.
DO $migration$
DECLARE
  v_definition text;
  v_old text := $old$
  v_certificate_id := 'AZ-INT-' || to_char(current_date, 'YYYY') || '-' ||
    upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 4));
$old$;
  v_new text := $new$
  v_certificate_id := 'AZ-INT-' || to_char(current_date, 'YYYY') || '-' ||
    (SELECT string_agg(substr('ABCDEFGHJKLMNPQRSTUVWXYZ23456789', floor(random() * 32)::int + 1, 1), '' ORDER BY n) FROM generate_series(1, 4) AS g(n)) || '-' ||
    (SELECT string_agg(substr('ABCDEFGHJKLMNPQRSTUVWXYZ23456789', floor(random() * 32)::int + 1, 1), '' ORDER BY n) FROM generate_series(1, 4) AS g(n));
$new$;
BEGIN
  SELECT pg_get_functiondef(
    'public.issue_certificate_secure(uuid, uuid, uuid, text, text, text)'::regprocedure
  ) INTO v_definition;

  IF position(v_old IN v_definition) = 0 THEN
    RAISE EXCEPTION 'Expected certificate ID generator was not found; refusing to rewrite function';
  END IF;

  v_definition := replace(v_definition, v_old, v_new);
  EXECUTE v_definition;
END;
$migration$;
