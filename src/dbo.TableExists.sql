IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_TYPE = 'FUNCTION'
      AND ROUTINE_CATALOG = DB_NAME()
      AND ROUTINE_SCHEMA = 'dbo'
      AND ROUTINE_NAME = 'TableExists'
    )
BEGIN
  DROP FUNCTION [dbo].[TableExists]
END
GO
CREATE FUNCTION [dbo].[TableExists] (@name SYSNAME)
RETURNS BIT
AS
BEGIN
  IF @name IS NULL
    RETURN NULL;
  DECLARE @tableName SYSNAME = PARSENAME(@name, 1);
  IF @tableName IS NULL
    RETURN NULL;
  DECLARE @tableSchema NVARCHAR(128) = PARSENAME(@name, 2);
  DECLARE @tableCatalog NVARCHAR(128) = PARSENAME(@name, 3);
  IF EXISTS (
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
    RETURN 1;
  RETURN 0;
END
GO

