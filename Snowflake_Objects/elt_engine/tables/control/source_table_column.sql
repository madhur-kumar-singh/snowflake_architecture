CREATE OR ALTER TABLE control.source_table_column (
      source_table_column_id NUMBER(38,0) NOT NULL DEFAULT util.seq_source_table_column.nextval
    , table_id VARCHAR
    , source_column_name VARCHAR
    , target_column_name VARCHAR
    , data_type VARCHAR
    , data_size NUMBER(38,0)
    , precision NUMBER(38,0)
    , default_value VARCHAR
    , not_null VARCHAR
    , source_oridinal_position NUMBER(38,0)
    , target_oridinal_position NUMBER(38,0)
    , is_active BOOLEAN NOT NULL DEFAULT TRUE
    , comment VARCHAR
    , created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , created_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
    , modified_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , modified_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
);