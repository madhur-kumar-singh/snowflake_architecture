CREATE OR REPLACE PROCEDURE control.p_job_delete("JOB_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    job_id NUMBER;
    invalid_job exception (-20001,'Invalid Job. Job name does exists.');
BEGIN
    SELECT job_id INTO :job_id FROM elt_engine.control.job WHERE job_name = :job_name;

    IF (:job_id IS NULL) THEN
        RAISE invalid_job;
    ELSE
        DELETE FROM elt_engine.control.job WHERE (job_id = :job_id) ;
    END IF;

    RETURN :job_name || '\thas been deleted';
END;
$$;