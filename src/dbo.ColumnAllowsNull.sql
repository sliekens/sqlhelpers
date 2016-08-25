IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_TYPE = 'FUNCTION'
      AND ROUTINE_CATALOG = DB_NAME()
      AND ROUTINE_SCHEMA = 'dbo'
      AND ROUTINE_NAME = 'ColumnAllowsNull'
    )
BEGIN
  DROP FUNCTION [dbo].[ColumnAllowsNull]
END
GO
CREATE FUNCTION [dbo].[ColumnAllowsNull] (
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
  DECLARE @tableName SYSNAME = PARSENAME(@table, 1);
  IF @tableName IS NULL
    RETURN NULL;
  DECLARE @tableSchema NVARCHAR(128) = PARSENAME(@table, 2);
  DECLARE @tableCatalog NVARCHAR(128) = PARSENAME(@table, 3);
  DECLARE @isNullable VARCHAR(3);
  SELECT @isNullable = IS_NULLABLE
  FROM INFORMATION_SCHEMA.COLUMNS
  -- Behavior is undefined when multiple records match the following criteria
  WHERE COLUMN_NAME = @name
    AND TABLE_NAME = @tableName
    AND (
      TABLE_SCHEMA = @tableSchema
      OR @tableSchema IS NULL
      )
    AND (
      TABLE_CATALOG = @tableCatalog
      OR @tableCatalog IS NULL
      );
  RETURN CASE @isNullable
      WHEN 'YES'
        THEN 1
      WHEN 'NO'
        THEN 0
      ELSE NULL
      END;
END
GO
