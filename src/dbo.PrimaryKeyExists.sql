IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PrimaryKeyExists]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[PrimaryKeyExists]
END

GO

CREATE FUNCTION [dbo].[PrimaryKeyExists] (@table sysname, @name sysname)
RETURNS bit
AS
BEGIN
    DECLARE @tableObjectId int = OBJECT_ID(@table);
    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = @tableObjectId AND type in (N'U'))
        RETURN NULL;
    DECLARE @tableName sysname;
    SELECT TOP 1 @tableName = name FROM sys.objects WHERE object_id = @tableObjectId;
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = @tableName AND CONSTRAINT_NAME = @name)
        RETURN 1;
    RETURN 0;
END

GO