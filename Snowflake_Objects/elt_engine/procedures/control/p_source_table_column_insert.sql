CREATE OR REPLACE PROCEDURE control.p_source_table_column_insert("TABLE_NAME" VARCHAR, "DATA_SOURCE_NAME" VARCHAR, "SOURCE_COLUMN_NAME" VARCHAR, "TARGET_COLUMN_NAME" VARCHAR, "DATA_TYPE" VARCHAR, "DATA_SIZE" NUMBER, "PRECISION" NUMBER, "DEFAULT_VALUE" VARCHAR, "NOT_NULL" BOOLEAN, "SOURCE_ORIDINAL_POSITION" NUMBER, "TARGET_ORIDINAL_POSITION" NUMBER, "IS_ACTIVE" BOOLEAN, "COMMENT" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    table_id NUMBER;
    data_source_id NUMBER;
    invalid_table EXCEPTION (-20001, 'Invalid Table name. Table not found.');
    invalid_data_source EXCEPTION (-20002, 'Invalid Data Source. Data source not found.');
    column_already EXCEPTION (-20003, 'Column entry already exixts.');
    
BEGIN

    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE (data_source_name = :data_source_name);

    SELECT table_id INTO :table_id FROM elt_engine.control.source_table WHERE (table_name = :table_name) AND (data_source_id = :data_source_id);

    IF (:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE IF (table_id IS NULL) THEN
        RAISE invalid_table;
    ELSE IF (EXISTS (SELECT source_table_column_id FROM elt_engine.control.source_table_columm WHERE (table_id = :table_id) AND (target_column_name = :target_column_name))) THEN
        RETURN 'Column already exists.';
    ELSE
        INSERT INTO elt_engine.control.source_table_column (
              table_id
            , source_column_name
            , target_column_name
            , data_type
            , data_size
            , precision
            , default_value
            , not_null
            , source_oridinal_position
            , target_oridinal_position
            , is_active
            , comment
        ) VALUES (
              :table_id
            , :source_column_name
            , :target_column_name
            , :data_type
            , :data_size
            , :precision
            , :default_value
            , :not_null
            , :source_oridinal_position
            , :target_oridinal_position
            , :is_active
            , :comment
        );
    
    END IF;

    RETURN 'Column has been added.';
    
END;
$$;