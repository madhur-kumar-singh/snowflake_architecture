CREATE OR REPLACE PROCEDURE control.p_source_table_column_update("DATA_SOURCE_NAME" VARCHAR, "TABLE_NAME" VARCHAR, "SOURCE_COLUMN_NAME" VARCHAR, "NEW_SOURCE_COLUMN" VARCHAR, "TARGET_COLUMN_NAME" VARCHAR, "NEW_TARGET_COLUMN_NAME" VARCHAR, "DATA_TYPE" VARCHAR, "DATA_SIZE" NUMBER, "PRECISION" NUMBER, "DEFAULT_VALUE" VARCHAR, "NOT_NULL" BOOLEAN, "SOURCE_ORIDINAL_POSITION" NUMBER, "TARGET_ORIDINAL_POSITION" NUMBER, "IS_ACTIVE" BOOLEAN, "COMMENT" VARCHAR)
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
        UPDATE elt_engine.control.source_table_column
        SET   source_column_name = IFNULL(:new_source_column, source_column_name)
            , target_column_name = IFNULL(:new_target_column_name, target_column_name)
            , data_type = IFNULL(:data_type, data_type)
            , data_size = IFNULL(:data_size, data_size)
            , precision = IFNULL(:precision, precision)
            , default_value = IFNULL(:default_value, default_value)
            , not_null = IFNULL(:not_null, not_null)
            , source_oridinal_position = IFNULL(:source_oridinal_position, source_oridinal_position)
            , target_oridinal_position = IFNULL(:target_oridinal_position, target_oridinal_position)
            , is_active = IFNULL(:is_active, is_active)
            , comment = IFNULL(:comment, comment)
            , modified_timestamp = CURRENT_TIMESTAMP()
            , modified_by = CURRENT_USER()
        WHERE (source_table_column_id = :source_table_column_id);
    END IF;

    RETURN 'Source Column has been modified.';
END;
$$;