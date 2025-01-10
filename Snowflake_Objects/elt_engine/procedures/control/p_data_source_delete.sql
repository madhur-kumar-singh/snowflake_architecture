CREATE OR REPLACE PROCEDURE control.p_data_source_delete ("DATA_SOURCE_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    data_source_id NUMBER;
    invalid_data_source EXCEPTION(-20001, 'Invalid Data source name. Data source name is not found.');
BEGIN
    SELECT data_source_id INTO :data_source_id FROM control.data_source WHERE (data_source_name = :data_source_name);

    IF(:data_source_id IS NULL) THEN
        RAISE invalid_data_source;
    ELSE
        DELETE FROM control.data_source 
            WHERE (data_source_id = :data_source_id);
    END IF;

    RETURN :data_source_name || '\thas been removed.';
END;
$$;