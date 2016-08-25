IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'FUNCTION' AND ROUTINE_CATALOG = DB_NAME() AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'PrimaryKeyExists')
BEGIN
    DROP FUNCTION [dbo].[PrimaryKeyExists]
END

GO

CREATE FUNCTION [dbo].[PrimaryKeyExists] (@table sysname, @name sysname)
RETURNS bit
AS
BEGIN
    IF @table IS NULL
        RETURN NULL;
    IF @name IS NULL
        RETURN NULL;
    DECLARE @tableName sysname = PARSENAME(@table, 1);
    IF @tableName IS NULL
        RETURN NULL;
    DECLARE @tableSchema nvarchar(128) = PARSENAME(@table, 2);
    DECLARE @tableCatalog nvarchar(128) = PARSENAME(@table, 3);
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_NAME = @tableName AND (TABLE_SCHEMA = @tableSchema OR @tableSchema IS NULL) AND (TABLE_CATALOG = @tableCatalog OR @tableCatalog IS NULL))
        RETURN NULL;
        
    DECLARE @constraintName nvarchar(128) = PARSENAME(@name, 1);
    IF @constraintName IS NULL
        RETURN NULL;
    DECLARE @constraintSchema nvarchar(128) = PARSENAME(@name, 2);
    DECLARE @constraintCatalog nvarchar(128) = PARSENAME(@name, 3);   
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND CONSTRAINT_NAME = @constraintName AND (CONSTRAINT_SCHEMA = @constraintSchema OR @constraintSchema IS NULL) AND (CONSTRAINT_CATALOG = @constraintCatalog OR @constraintCatalog IS NULL) AND TABLE_NAME = @tableName AND (TABLE_SCHEMA = @tableSchema OR @tableSchema IS NULL) AND (TABLE_CATALOG = @tableCatalog OR @tableCatalog IS NULL))
        RETURN 1;
    RETURN 0;
END

GO