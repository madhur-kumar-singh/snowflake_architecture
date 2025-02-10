CREATE OR REPLACE PROCEDURE control.p_source_table_column_update("DATA_SOURCE_NAME" VARCHAR, "TABLE_NAME" VARCHAR, "TARGET_COLUMN_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    table_id NUMBER;
    source_table_column_id NUMBER;
    data_source_id NUMBER;
    invalid_table EXCEPTION (-20001, 'Invalid Table Name, Table Not Found.');
    invalid_column EXCEPTION (-20002, 'Invalid Column Name, Column Not found.');
    invalid_data_source EXCEPTION (-20003,'Invalid Data Source Name, Data Source Not Found.');
BEGIN
    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE (data_source_name = :data_source_name);

    SELECT table_id INTO :table_id FROM elt_engine.control.source_table WHERE (table_name = :table_name) AND (data_source_id = :data_source_id);

    SELECT source_table_column_id INTO :source_table_column_id FROM elt_engine.control.source_table_column WHERE (table_id = :table_id) AND (target_column_name = :target_column_name);

    IF(:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE IF(:table_id IS NULL) THEN
        RAISE invalid_table;
    ELSE IF(:source_table_column_id IS NULL) THEN
        RAISE invalid_column;
    ELSE
        DELETE FROM elt_engine.control.source_table_column
        WHERE (source_table_column_id = :source_table_column_id);

    END IF;
    RETURN 'Source Column has been Deleted.';
END;
$$;