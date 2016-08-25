IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_TYPE = 'FUNCTION'
      AND ROUTINE_CATALOG = DB_NAME()
      AND ROUTINE_SCHEMA = 'dbo'
      AND ROUTINE_NAME = 'TypeExists'
    )
BEGIN
  DROP FUNCTION [dbo].[TypeExists]
END
GO
CREATE FUNCTION [dbo].[TypeExists] (@name SYSNAME)
RETURNS BIT
AS
BEGIN
  IF @name IS NULL
    RETURN NULL;
  DECLARE @domainName SYSNAME = PARSENAME(@name, 1);
  IF @domainName IS NULL
    RETURN NULL;
  DECLARE @domainSchema NVARCHAR(128) = PARSENAME(@name, 2);
  DECLARE @domainCatalog NVARCHAR(128) = PARSENAME(@name, 3);
  IF EXISTS (
      SELECT *
      FROM INFORMATION_SCHEMA.DOMAINS
      WHERE DOMAIN_NAME = @domainName
        AND (
          DOMAIN_SCHEMA = @domainSchema
          OR @domainSchema IS NULL
          )
        AND (
          DOMAIN_CATALOG = @domainCatalog
          OR @domainCatalog IS NULL
          )
      )
    RETURN 1;
  RETURN 0;
END
GO

