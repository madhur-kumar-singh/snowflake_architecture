BEGIN
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/sequences/control/seq_batch.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/sequences/control/seq_batch_data_source.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/sequences/control/seq_data_source.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/sequences/control/seq_job.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/sequences/control/seq_source_table_column.sql;
    EXECUTE IMMEDIATE FROM @elt_engine.public.github_repo/branches/main/Snowflake_Objects/elt_engine/sequences/control/seq_table.sql;
END;