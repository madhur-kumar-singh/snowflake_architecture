CREATE OR REPLACE PROCEDURE control.p_source_table_file_insert("DATA_SOURCE_NAME" VARCHAR, "TABLE_NAME" VARCHAR, "FILE_FORMAT_DATABASE_NAME" VARCHAR, "FILE_FORMAT_SCHEMA_NAME" VARCHAR, "FILE_FORMAT_PARSE_HEADER" VARCHAR, "FILE_FORMAT_PARSE_DATA" VARCHAR,"FILE_FOLDER" VARCHAR, "FILE_NAME_PREFIX" VARCHAR, "FILE_DATE_PATTERN" VARCHAR, "FILE_NAME_SUFFIX" VARCHAR, "FILE_DATE_REGEX" VARCHAR, "FILE_RECORD_FILTER" VARCHAR, "SKIP_HEADER_RECORD" NUMBER,"SKIP_FOOTER_RECORD" NUMBER,  "SKIP_RECORD_STRING" NUMBER, "IS_ACTIVE" BOOLEAN, "COMMENT" VARCHAR)
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
    table_file_found EXCEPTION (-20003, 'Source table file already exists.');
BEGIN
    SELECT data_source_id INTO :data_source_id FROM elt_engine.control.data_source WHERE (data_source_name = :data_source_name);

    SELECT table_id INTO :table_id FROM elt_engine.control.source_table WHERE (table_name = :table_name) AND (data_source_id = :data_source_id);

    IF(:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE IF(:table_id IS NULL) THEN
        RAISE invalid_table;
    ELSE IF(EXISTS(SELECT table_id FROM elt_engine.control.source_table_file WHERE (table_id = :table_id))) THEN
        RAISE table_file_found;
    ELSE
        INSERT INTO elt_engine.control.source_table_file (
              table_id
            , file_format_database_name
            , file_format_schema_name
            , file_format_parse_header
            , file_format_parse_data
            , file_folder
            , file_name_prefix
            , file_date_pattern
            , file_name_suffix
            , file_date_regex
            , file_record_filter
            , skip_header_record
            , skip_footer_record
            , skip_record_string
            , is_active
            , comment
        ) VALUES (
              :table_id
            , :file_format_database_name
            , :file_format_schema_name
            , :file_format_parse_header
            , :file_format_parse_data
            , :file_folder
            , :file_name_prefix
            , :file_date_pattern
            , :file_name_suffix
            , :file_date_regex
            , :file_record_filter
            , :skip_header_record
            , :skip_footer_record
            , :skip_record_string
            , :is_active
            , :comment
        );
    END IF;
    RETURN 'Source file Added.';
END;
$$;