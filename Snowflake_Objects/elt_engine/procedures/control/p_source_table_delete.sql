CREATE OR REPLACE PROCEDURE control.p_source_table_delete("TABLE_NAME" VARCHAR, "DATA_SOURCE_NAME" VARCHAR, "JOB_NAME" VARCHAR)
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
BEGIN
    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE data_source_name = :data_source_name;

    SELECT job_id INTO :job_id FROM  elt_engine.control.job WHERE job_name = :job_name;

    SELECT table_id INTO :table_id FROM elt_engine.control.source_table WHERE (data_source_id = :data_source_id) AND (job_id = :job_id) AND (table_name = :table_name);

    IF(:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSEIF(:job_id IS NULL) THEN
        RAISE invalid_job;
    ELSEIF(:table_id IS NULL) THEN
        RAISE table_not_found;
    ELSE
        DELETE FROM elt_engine.control.source_table
        WHERE (table_id = :table_id);
    END IF;
    
    RETURN :table_name || '\thas been deleted.';
END;
$$;