BEGIN
    EXECUTE IMMEDIATE FROm @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/sequences/control/seq_batch.sql;
    EXECUTE IMMEDIATE FROm @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/batch.sql;
END;