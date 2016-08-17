IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FunctionExists]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[FunctionExists]
END

GO

CREATE FUNCTION [dbo].[FunctionExists] (@name sysname)
RETURNS bit
AS
BEGIN
    IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@name) AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
        RETURN 1;
    RETURN 0;
END

GO
