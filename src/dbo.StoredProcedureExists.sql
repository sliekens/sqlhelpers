IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'FUNCTION' AND ROUTINE_CATALOG = DB_NAME() AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'StoredProcedureExists')
BEGIN
    DROP FUNCTION [dbo].[StoredProcedureExists]
END

GO

CREATE FUNCTION [dbo].[StoredProcedureExists] (@name sysname)
RETURNS bit
AS
BEGIN
    IF @name IS NULL
        RETURN NULL;
    DECLARE @routineName nvarchar(128) = PARSENAME(@name, 1);
    IF @routineName IS NULL
        RETURN NULL;
    DECLARE @routineSchema nvarchar(128) = PARSENAME(@name, 2);
    DECLARE @routineCatalog nvarchar(128) = PARSENAME(@name, 3);
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'PROCEDURE' AND ROUTINE_NAME = @routineName AND (ROUTINE_SCHEMA = @routineSchema OR @routineSchema IS NULL) AND (ROUTINE_CATALOG = @routineCatalog OR @routineCatalog IS NULL))
        RETURN 1;
    RETURN 0;
END

GO