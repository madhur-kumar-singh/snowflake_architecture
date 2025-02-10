CREATE OR REPLACE PROCEDURE control.p_stored_procedure_update("DATA_SOURCE_NAME" VARCHAR, "TABLE_NAME" VARCHAR, "STORED_PROCEDURE_DATABASE" VARCHAR, "STORED_PROCEDURE_SCHEMA" VARCHAR, "PROCEDURE_NAME" VARCHAR, "PARAMS" VARCHAR, "IS_ACTIVE" VARCHAR, "COMMENT" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    data_source_name NUMBER;
    table_id NUMBER;
    invalid_data_source EXCEPTION (-20001, 'Invalid Data Source Name. Data Source not Found.');
    invalid_table EXCEPTION (-20002, 'Invalid Table Name. Table Name not Found.');
BEGIN
    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE (data_source_name = :data_source_name);

    SELECT table_id INTO :table_id FROM elt_engine.control.source_table WHERE (data_source_id = :data_source_id) AND (table_name = :table_name);

    IF (:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE IF (:table_id IS NULL) THEN
        RAISE invalid_table;
    ELSE
        UPDATE elt_engine.control.stored_procedure
        SET   stored_procedure_database = IFNULL(:stored_procedure_database, stored_procedure_database)
            , stored_procedure_schema = IFNULL(:stored_procedure_schema, stored_procedure_schema)
            , procedure_name = IFNULL(:procedure_name, procedure_name)
            , params = IFNULL(:params, params)
            , is_active = IFNULL(:is_active, is_active)
            , comment = IFNULL(:comment, comment)
            , modified_timestamp = CURRENT_TIMESTAMP()
            , modified_by = CURRENT_USER()
        WHERE (table_id = :table_id);
    END IF;
    RETURN 'Stored Procedure for the table is Modified.';
END;
$$;