IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ViewExists]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[ViewExists]
END

GO

CREATE FUNCTION [dbo].[ViewExists] (@name sysname)
RETURNS bit
AS
BEGIN
    IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(@name))
        RETURN 1;
    RETURN 0;
END

GO