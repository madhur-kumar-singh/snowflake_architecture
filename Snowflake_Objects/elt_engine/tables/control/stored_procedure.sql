CREATE OR ALTER TABLE control.stored_procedure (
      table_id NUMBER(38,0)
    , stored_procedure_database VARCHAR
    , stored_procedure_schema VARCHAR
    , procedure_name VARCHAR
    , params VARCHAR
    , is_active BOOLEAN NOT NULL DEFAULT TRUE
    , comment VARCHAR
    , created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , created_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
    , modified_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , modified_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
);