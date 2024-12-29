BEGIN
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/Sequence_Script.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/Table_Script.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/Procedure_Script.sql;
END;
