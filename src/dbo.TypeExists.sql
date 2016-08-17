IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TypeExists]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[TypeExists]
END

GO

CREATE FUNCTION [dbo].[TypeExists] (@name sysname)
RETURNS bit
AS
BEGIN
    DECLARE @schemaName sysname = ISNULL(PARSENAME(@name, 2), 'dbo');
    DECLARE @typeName sysname = PARSENAME(@name, 1);
    IF @typeName IS NULL
        RETURN NULL;
    IF EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE is_user_defined = 1 AND st.name = @typeName AND ss.name = @schemaName)
        RETURN 1;
    RETURN 0;
END

GO