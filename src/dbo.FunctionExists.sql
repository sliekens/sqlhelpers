IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_TYPE = 'FUNCTION'
      AND ROUTINE_CATALOG = DB_NAME()
      AND ROUTINE_SCHEMA = 'dbo'
      AND ROUTINE_NAME = 'FunctionExists'
    )
BEGIN
  DROP FUNCTION [dbo].[FunctionExists]
END
GO
CREATE FUNCTION [dbo].[FunctionExists] (@name SYSNAME)
RETURNS BIT
AS
BEGIN
  IF @name IS NULL
    RETURN NULL;
  DECLARE @routineName NVARCHAR(128) = PARSENAME(@name, 1);
  IF @routineName IS NULL
    RETURN NULL;
  DECLARE @routineSchema NVARCHAR(128) = PARSENAME(@name, 2);
  DECLARE @routineCatalog NVARCHAR(128) = PARSENAME(@name, 3);
  IF EXISTS (
      SELECT *
      FROM INFORMATION_SCHEMA.ROUTINES
      WHERE ROUTINE_TYPE = 'FUNCTION'
        AND ROUTINE_NAME = @routineName
        AND (
          ROUTINE_SCHEMA = @routineSchema
          OR @routineSchema IS NULL
          )
        AND (
          ROUTINE_CATALOG = @routineCatalog
          OR @routineCatalog IS NULL
          )
      )
    RETURN 1;
  RETURN 0;
END
GO

