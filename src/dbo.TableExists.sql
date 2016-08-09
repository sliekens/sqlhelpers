IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TableExists]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[TableExists]
END

GO

CREATE FUNCTION [dbo].[TableExists] (@name sysname)
RETURNS bit
AS
BEGIN
    IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@name) AND type in (N'U'))
        RETURN 1;
    RETURN 0;
END

GO