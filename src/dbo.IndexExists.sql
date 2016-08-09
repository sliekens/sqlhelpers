IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IndexExists]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[IndexExists]
END

GO

CREATE FUNCTION [dbo].[IndexExists] (@table sysname, @name sysname)
RETURNS bit
AS
BEGIN
    DECLARE @tableObjectId int = OBJECT_ID(@table);
    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = @tableObjectId AND type in (N'U'))
        RETURN NULL;
    IF EXISTS (SELECT * FROM sys.indexes WHERE object_id = @tableObjectId AND name = @name)
        RETURN 1;
    RETURN 0;
END

GO