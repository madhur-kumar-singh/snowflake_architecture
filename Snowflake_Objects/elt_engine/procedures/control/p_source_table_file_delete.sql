CREATE OR REPLACE PROCEDURE control.p_source_table_file_delete()
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    table_id NUMBER;
    data_source_id NUMBER;
    invalid_table EXCEPTION (-20001, 'Invalid table name. Table not found.');
    invalid_data_source EXCEPTION (-20001, 'Invalid data source name. Data source name not found.');
BEGIN
    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE (data_source_name = :data_source_name);

    SELECT table_id INTO :table_id FROM elt_engine.control.source_table WHERE (table_name = :table_name) AND (data_source_id = :data_source_id);

    IF (:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE IF (:table_id IS NULL) THEN
        RAISE invalid_table;
    ELSE
        DELETE FROM elt_engine.control.source_table_file
        WHERE (table_id = :table_id); 
    END IF:
    RETURN 'Table File has been deleted.';
END;
$$;