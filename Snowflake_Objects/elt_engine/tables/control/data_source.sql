CREATE OR ALTER TABLE control.data_source (
      data_source_id NUMBER(38,0) NOT NULL DEFAULT util.seq_data_source.nextval
    , data_source_name VARCHAR
    , data_source_type VARCHAR
    , connection_string VARCHAR
    , credential_username VARCHAR
    , credential_secret VARCHAR
    , credential_token VARCHAR
    , is_active BOOLEAN NOT NULL DEFAULT TRUE
    , comment VARCHAR
    , created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , created_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
    , modified_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , modified_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
);