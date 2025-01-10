CREATE OR REPLACE PROCEDURE control.p_batch_insert("BATCH_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
BEGIN
    IF(EXISTS (SELECT batch_id FROM control.batch WHERE (batch_name = :batch_name))) THEN
        RETURN 'Batch already exists';
    ELSE
        INSERT INTO control.batch (batch_name)
            VALUES (
                :batch_name
            );
    END IF;

    RETURN :batch_name || '\thas been inserted';
END;
$$;