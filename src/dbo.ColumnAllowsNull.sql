IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnColumnAllowsNull]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[fnColumnAllowsNull]
END

GO

CREATE FUNCTION [dbo].[fnColumnAllowsNull] (@table sysname, @name sysname)
RETURNS bit
AS
BEGIN
    DECLARE @tableObjectId int = OBJECT_ID(@table, N'U');
    IF @tableObjectId IS NULL
        RETURN NULL
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = @tableObjectId AND name = @name)
        RETURN NULL;
    RETURN COLUMNPROPERTY(@tableObjectId, @name, 'AllowsNull');
END

GO