CREATE OR REPLACE PROCEDURE control.p_batch_update("BATCH_NAME" VARCHAR, "NEW_BATCH_NAME" VARCHAR, "IS_ACTIVE" BOOLEAN)
RETURN VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    batch_id NUMBER;
    invalid_batch EXCEPTION (-20001, 'Invalid Batch Name. Batch Name not found.');
BEGIN
    SELECT batch_id INTO :batch_id FROM control.batch WHERE (batch_name = :batch_name);

    IF(:batch_id IS NULL) THEN
        RAISE invalid_batch;
    ELSE
        UPDATE control.batch
            SET batch_name = IFNULL(:new_batch_name, batch_name)
            , is_active = IFNULL(:is_active, is_active)
        WHERE (batch_id = :batch_id);
    END IF;

    RETURN :batch_name || '\t has been updated.';
END;
$$;