BEGIN
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/batch.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/batch_data_source.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/data_source.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/job.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/source_table_column.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/source_table_file.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/source_table.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/tables/control/stored_procedure.sql;
END;