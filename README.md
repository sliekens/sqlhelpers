# SQL Helpers
This repository contains SQL Server function scripts for functions that check the current database for object existence. They provide a simple API for checking table existence, view existence, procedure existence and more.

## dbo.TableExists

### Syntax
dbo.TableExists( name )

### Arguments
*name*

**sysname**, required
 
### Return Types

**bit**, not null
 
### Usage Examples
```sql
IF dbo.TableExists('dbo.Products') = 0
BEGIN
	 CREATE TABLE dbo.Products(Id int, Name nvarchar(max));
END
```

```sql
IF dbo.TableExists('Products_backup') = 1
BEGIN
	 DROP TABLE Products_backup;
END
```

## dbo.ViewExists
TODO

## dbo.StoredProcedureExists
TODO

## dbo.FunctionExists
TODO

## dbo.IndexExists
TODO

## dbo.ColumnExists
TODO

## dbo.ColumnAllowsNull
TODO

## dbo.PrimaryKeyExists
TODO

## dbo.TypeExists
TODO