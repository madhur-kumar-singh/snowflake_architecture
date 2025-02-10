CREATE OR REPLACE PROCEDURE control.p_job_insert("JOB_NAME" VARCHAR, "RELATIVE_PATH" VARCHAR, "COMMENT" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
BEGIN
    IF(EXISTS (SELECT TOP 1 1 FROM elt_engine.control.job WHERE (job_name = :job_name))) THEN
        RETURN 'Job already exists.';
    ELSE
        INSERT INTO elt_engine.control.job (job_name, relative_path, comment)
            VALUES (
                  :job_name
                , :relative_path || ''/'' || :job_name
                , :comment);
    END IF;

    RETURN :job_name || '\thas been inserted';
END;
$$;