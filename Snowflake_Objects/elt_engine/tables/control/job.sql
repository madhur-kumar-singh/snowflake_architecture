CREATE OR ALTER TABLE control.job (
      job_id NUMBER(38,0) NOT NULL DEFAULT util.seq_job.nextval
    , job_name VARCHAR
    , relative_path VARCHAR
    , job VARCHAR
    , is_active BOOLEAN NOT NULL DEFAULT TRUE
    , comment VARCHAR
    , created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , created_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
    , modified_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
    , modified_by VARCHAR NOT NULL DEFAULT CURRENT_USER()
);