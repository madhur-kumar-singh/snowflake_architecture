CREATE OR REPLACE PROCEDURE control.p_stored_procedure_delete("DATA_SOURCE_NAME" VARCHAR, "TABLE_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    data_source_id NUMBER;
    table_id NUMBE;
    invalid_data_source EXCEPTION (-20001, 'Invalid Data Source Name. Data Source not Found.');
    invalid_table EXCEPTION (-20002, 'Invalid Table Name. Table Name not Found.');
BEGIN
    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE (data_source_name = :data_source_name);

    SELECT table_id INTO :table_id FROM elt_engine.control.source_table WHERE (data_source_id = :data_source_id) AND (table_name = :table_name);

    IF(:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSEIF(:table_id IS NULL) THEN
        RAISE invalid_table;
    ELSE
        DELETE FROM elt_engine.control.stored_procedure
        WHERE (table_id = :table_id);
    END IF;

    RETURN 'Stored Procedure row deleted.';
END;
$$;