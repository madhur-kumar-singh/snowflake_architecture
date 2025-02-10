CREATE OR REPLACE PROCEDURE control.p_data_source_insert("DATA_SOURCE_NAME" VARCHAR, "DATA_SOURCE_TYPE" VARCHAR, "CONNECTION_STRING" VARCHAR, "CREDENTIAL_USERNAME" VARCHAR, "CREDENTIAL_SECRET" VARCHAR, "CREDENTIAL_TOKEN" VARCHAR, "COMMENT" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
BEGIN
    IF(EXISTS (SELECT data_source_id FROM control.data_source WHERE (data_source_name = :data_source_name))) THEN
        RETURN 'Data Source already Exists';
    ELSE
        INSERT INTO control.data_source (
                  data_source_name
                , data_source_type
                , connection_string
                , credential_username
                , credential_secret
                , credential_token
                , comment
            )
        VALUES (
                  :data_source_name
                , :data_source_type
                , :connection_string
                , :credential_username
                , :credential_secret
                , :credential_token
                , :comment
            );
    END IF;

    RETURN :data_source_name || '\tHas been inserted.';
END;
$$;