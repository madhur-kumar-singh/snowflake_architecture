CREATE OR REPLACE PROCEDURE control.p_source_table_insert("DATA_SOURCE_NAME" VARCHAR, "JOB_NAME" VARCHAR, "TABLE_NAME" VARCHAR, "TABLE_SCHEMA" VARCHAR, "PRIMARY_UNIQUE_KEY" VARCHAR, "ADD_COLUMN_ACTION" VARCHAR, "DROP_COLUMN_ACTION" VARCHAR, "IS_ACTIVE" BOOLEAN, "COMMENT" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    data_source_id NUMBER;
    job_id NUMBER;
    table_id NUMBER;
    invalid_data_source EXCEPTION (-20001, "Invalid Data Source Name.");
    invalid_job EXCEPTION (-20002,"Invalid Job Name.");
    table_found EXCEPTION (-20003, "Table already exists.");
BEGIN
    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE data_source_name = :data_source_name;

    SELECT job_id INTO :job_id FROM  elt_engine.control.job WHERE job_name = :job_name;

    IF(:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE IF (:job_id IS NULL) THEN
        RAISE invalid_job;
    ELSE IF (EXISTS(SELECT table_id FROM elt_engine.control.source_table WHERE (data_source_id = :data_source_id) AND (job_id = :job_id) AND (table_name = :table_name))) THEN
        RAISE table_found;
    ELSE
        INSERT INTO elt_engine.control.source_table (
              data_source_id
            , job_id
            , table_name
            , table_schema
            , target_schema
            , primary_unique_key
            , add_column_action
            , drop_column_action
            , is_active
            , comment
        ) VALUES (
              :data_source_id
            , :job_id
            , :table_name
            , :table_schema
            , CONCAT(:data_source_name, IFNULL(CONCAT('_',:table_schema),''))
            , :primary_unique_key
            , :add_column_action
            , :drop_column_action
            , :is_active
            , :comment
        );
    
    RETURN :table_name || '\thas been added.';
END;
$$;