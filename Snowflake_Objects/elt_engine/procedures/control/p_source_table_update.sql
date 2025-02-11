CREATE OR REPLACE PROCEDURE control.p_source_table_update("TABLE_NAME" VARCHAR, "NEW_TABLE_NAME" VARCHAR, "DATA_SOURCE_NAME" VARCHAR, "JOB_NAME" VARCHAR, "TABLE_SCHEMA" VARCHAR, "PRIMARY_UNIQUE_KEY" VARCHAR, "ADD_COLUMN_ACTION" VARCHAR, "DROP_COLUMN_ACTION" VARCHAR, "IS_ACTIVE" BOOLEAN, "COMMENT" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    data_source_id NUMBER;
    job_id NUMBER;
    table_id NUMBER;
    invalid_data_source EXCEPTION (-20001, 'Invalid Data Source Name.');
    invalid_job EXCEPTION (-20002,'Invalid Job Name.');
    table_not_found EXCEPTION (-20003, 'Table does not exists.');
    new_table_name EXCEPTION (-20004, 'New table name parameter can not be null');
BEGIN
    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE data_source_name = :data_source_name;

    SELECT job_id INTO :job_id FROM  elt_engine.control.job WHERE job_name = :job_name;

    SELECT table_id INTO :table_id FROM elt_engine.control.source_table WHERE (data_source_id = :data_source_id) AND (job_id = :job_id) AND (table_name = :table_name);

    IF(:new_table_name IS NULL) THEN
        RAISE new_table_name;
    ELSEIF(:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSEIF(:job_id IS NULL) THEN
        RAISE invalid_job;
    ELSEIF(:table_id IS NULL) THEN
        RAISE table_not_found;
    ELSE
        UPDATE elt_engine.control.source_table
        SET table_name = :new_table_name
        , table_schema = IFNULL(:table_schema, table_schema)
        , target_schema = IFNULL(CONCAT(:data_source_name, IFNULL(CONCAT('_',:table_schema),'')), target_schema)
        , primary_unique_key = IFNULL(:primary_unique_key, primary_unique_key)
        , add_column_action = IFNULL(:add_column_action, add_column_action)
        , drop_column_action = IFNULL(:drop_column_action, drop_column_action)
        , is_active = IFNULL(:is_action, is_action)
        , comment = IFNULL(:comment, comment)
        , modified_timestamp = CURRENT_TIMESTAMP()
        , modified_by = CURRENT_USER() 
    WHERE (table_id = :table_id);
    END IF;
    
    RETURN :table_name || '\thas been updated.';
END;
$$;