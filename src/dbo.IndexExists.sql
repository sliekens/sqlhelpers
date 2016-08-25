IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_TYPE = 'FUNCTION'
      AND ROUTINE_CATALOG = DB_NAME()
      AND ROUTINE_SCHEMA = 'dbo'
      AND ROUTINE_NAME = 'IndexExists'
    )
BEGIN
  DROP FUNCTION [dbo].[IndexExists]
END
GO
CREATE FUNCTION [dbo].[IndexExists] (
  @table SYSNAME,
  @name SYSNAME
  )
RETURNS BIT
AS
BEGIN
  IF @table IS NULL
    RETURN NULL;
  IF @name IS NULL
    RETURN NULL;
  IF @table IS NULL
    RETURN NULL;
  IF @name IS NULL
    RETURN NULL;
  DECLARE @tableName SYSNAME = PARSENAME(@table, 1);
  IF @tableName IS NULL
    RETURN NULL;
  DECLARE @tableSchema NVARCHAR(128) = PARSENAME(@table, 2);
  DECLARE @tableCatalog NVARCHAR(128) = PARSENAME(@table, 3);
  DECLARE @tableObjectId INT = OBJECT_ID(@table);
  IF NOT EXISTS (
      SELECT *
      FROM INFORMATION_SCHEMA.TABLES
      WHERE TABLE_TYPE = 'BASE TABLE'
        AND TABLE_NAME = @tableName
        AND (
          TABLE_SCHEMA = @tableSchema
          OR @tableSchema IS NULL
          )
        AND (
          TABLE_CATALOG = @tableCatalog
          OR @tableCatalog IS NULL
          )
      )
    RETURN NULL;
  IF EXISTS (
      SELECT *
      FROM sys.indexes
      WHERE object_id = @OBJECT_ID(@table)
        AND NAME = @name
      )
    RETURN 1;
  RETURN 0;
END
GO

