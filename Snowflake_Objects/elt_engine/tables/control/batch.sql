CREATE OR ALTER TABLE control.batch (
      batch_id NUMBER(38,0) NOT NULL DEFAULT elt_engine.control.seq_batch
    , batch_name VARCHAR
    , is_active BOOLEAN NOT NULL DEFAULT TRUE
    , comment VARCHAR
    , created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , created_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
    , modified_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , modified_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
);