CREATE OR REPLACE PROCEDURE control.p_job_update("JOB_NAME" VARCHAR, "NEW_JOB_NAME" VARCHAR, "RELATIVE_PATH" VARCHAR, "IS_ACTIVE" VARCHAR, "COMMENT" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    job_id NUMBER;
    invalid_job EXCEPTION (-20001, 'Invalid Job name. The job name does not exists.');
BEGIN
    SELECT job_id INTO :job_id FROM control.job WHERE (job_name = :job_name);

    IF(:job_id IS NULL) THEN
        RAISE invalid_job;
    ELSE
        UPDATE control.job
            SET job_name = IFNULL(:new_job_name, job_name)
                , relative_path = IFNULL(:relative_path, relative_path)
                , job = IFNULL(:relative_path || ''/'' || :job_name, job)
                , is_active = IFNULL(:is_active, is_active)
                , comment = IFNULL(:comment, comment)
                , modified_by = CURRENT_USER()
                , modified_timestamp = CURRENT_TIMESTAMP()
        WHERE (job_id = :job_id);
    END IF;

    RETURN :job_name || '\tis updated with new name\t' || :new_job_name ; 
END;
$$;