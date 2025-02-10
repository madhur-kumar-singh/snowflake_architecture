CREATE OR REPLACE PROCEDURE control.p_batch_data_source_insert("BATCH_NAME" VARCHAR, "DATA_SOURCE_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    batch_id NUMBER;
    data_source_id NUMBER;
    batch_data_source_id NUMBER;
    invalid_batch EXCEPTION (-20001, 'Invalid Batch name, Batch name not found.');
    invalid_data_source EXCEPTION (-20002,'Invalid data source name, Data Source not found.');
BEGIN
    SELECT batch_id INTO :batch_id FROM control.batch WHERE (batch_name = :batch_name);

    SELECT data_source_id INTO :data_source_id FROM control.data_source WHERE (data_source_name = :data_source_name);
    
    IF (:batch_id IS NULL) THEN
        RAISE invalid_batch;
    ELSE IF (:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE IF (EXISTS (SELECT batch_data_source_id FROM control.batch_data_source WHERE (batch_id = :batch_id) AND (data_source_id = :data_source_id))) THEN
        RETURN 'Batch and data source already Mapped';
    ELSE
        INSERT INTO control.batch_data_source(batch_id, data_source_id)
        VALUES (
              :batch_id
            , :data_source_id
        );
    END IF;

    RETURN :batch_name || '\tmapped with\t' || :data_source_name;
END;
$$;