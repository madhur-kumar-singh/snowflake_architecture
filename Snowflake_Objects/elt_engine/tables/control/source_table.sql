CREATE OR ALTER TABLE control.source_table (
      table_id NUMBER(38,0) NOT NULL DEFAULT control.seq_table.nextval
    , data_source_id NUMBER(38,0)
    , job_id NUMBER(38,0)
    , table_name VARCHAR
    , table_schema VARCHAR
    , target_schema VARCHAR
    , primary_unique_key VARCHAR
    , add_column_action VARCHAR
    , drop_column_action VARCHAR
    , is_active BOOLEAN NOT NULL DEFAULT TRUE
    , comment VARCHAR
    , created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , created_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
    , modified_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , modified_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
);