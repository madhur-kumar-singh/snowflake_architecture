BEGIN
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/sequence_script.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/table_script.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/procedure_script.sql;
END;
