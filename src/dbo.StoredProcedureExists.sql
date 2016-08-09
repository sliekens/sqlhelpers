IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StoredProcedureExists]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[StoredProcedureExists]
END

GO

CREATE FUNCTION [dbo].[StoredProcedureExists] (@name sysname)
RETURNS bit
AS
BEGIN
    IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@name) AND type in (N'P', N'PC'))
        RETURN 1;
    RETURN 0;
END

GO