IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ColumnExists]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[ColumnExists]
END

GO

CREATE FUNCTION [dbo].[ColumnExists] (@table sysname, @name sysname)
RETURNS bit
AS
BEGIN
    DECLARE @tableObjectId int = OBJECT_ID(@table, N'U');
    IF @tableObjectId IS NULL
        RETURN NULL;
    IF EXISTS (SELECT * FROM sys.columns WHERE object_id = @tableObjectId AND name = @name)
        RETURN 1;
    RETURN 0;
END

GO