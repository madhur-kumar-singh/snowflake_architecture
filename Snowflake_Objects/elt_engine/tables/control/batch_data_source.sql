CREATE OR ALTER TABLE control.batch_data_source (
      batch_data_source_id NUMBER(38,0) NOT NULL DEFAULT util.seq_batch_data_source.nextval
    , batch_id NUMBER(38,0)
    , data_source_id NUMBER(38,0)
    , is_active BOOLEAN DEFAULT TRUE
    , comment VARCHAR
    , created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , created_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
    , modified_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , modified_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
);