CREATE OR REPLACE PROCEDURE control.p_data_source_update("DATA_SOURCE_NAME" VARCHAR,"NEW_DATA_SOURCE_NAME" VARCHAR , "DATA_SOURCE_TYPE" VARCHAR, "CONNECTION_STRING" VARCHAR, "CREDENTIAL_USERNAME" VARCHAR, "CREDENTIAL_SECRET" VARCHAR, "CREDENTIAL_TOKEN" VARCHAR, "IS_ACTIVE" BOOLEAN,"COMMENT" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    data_source_id VARCHAR;
    invalid_data_source EXCEPTION (-20001,'Invalid Data source name, Data Source not found.');
BEGIN
    SELECT data_source_id INTO :data_source_id FROM control.data_source WHERE (data_source_name = :data_source_name);

    IF(:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE
        UPDATE control.data_source SET
          data_source_name = IFNULL(:new_data_source_name, data_source_name)
        , data_source_type = IFNULL(:data_source_type, data_source_type)
        , connection_string = IFNULL(:connection_string, connection_string)
        , credential_username = IFNULL(:credential_username, credential_username)
        , credential_secret = IFNULL(:credential_secret, credential_secret)
        , credential_token = IFNULL(:credential_token, credential_token)
        , is_active = IFNULL(:is_active, is_active)
        , comment = IFNULL(:comment, comment) 
        WHERE (data_source_id = :data_source_id);
    END IF;

    RETURN :data_source_name || '\thas been updated.';
END;
$$;