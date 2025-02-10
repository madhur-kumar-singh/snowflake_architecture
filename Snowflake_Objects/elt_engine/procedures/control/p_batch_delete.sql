CREATE OR REPLACE PROCEDURE control.p_batch_delete("BATCH_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    batch_id NUMBER;
    invalid_batch EXCEPTION (-20001, 'Invalid Batch Name, Batch Name not found.');
BEGIN
    SELECT batch_id INTO :batch_id FROM elt_engine.control.batch WHERE (batch_name = :batch_name);

    IF(:batch_id IS NULL) THEN
        RAISE invalid_batch;
    ELSE
        DELETE FROM control.batch
        WHERE (batch_id = :batch_id);
    END IF;

    RETURN :batch_name || '\thas been deleted.';
END;
$$;