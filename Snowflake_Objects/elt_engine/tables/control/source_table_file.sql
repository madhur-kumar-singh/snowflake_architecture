CREATE OR ALTER TABLE control.source_table_file (
      table_id NUMBER(38,0)
    , file_format_database_name VARCHAR
    , file_format_schema_name VARCHAR
    , file_format_parse_header VARCHAR
    , file_format_parse_data VARCHAR
    , file_folder VARCHAR
    , file_name_prefix VARCHAR
    , file_date_pattern VARCHAR
    , file_name_suffix VARCHAR
    , file_date_regex VARCHAR
    , file_record_filter VARCHAR
    , skip_header_record NUMBER(38,0)
    , skip_footer_record NUMBER(38,0)
    , skip_record_string NUMBER(38,0)
    , is_active BOOLEAN NOT NULL DEFAULT TRUE
    , comment VARCHAR
    , created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , created_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
    , modified_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , modified_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
);