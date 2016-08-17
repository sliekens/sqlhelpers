# SQL Helpers
This repository contains SQL Server function scripts for functions that check the current database for object existence. They provide a simple API for checking table existence, view existence, procedure existence and more.

## dbo.TableExists
### Syntax
```sql
dbo.TableExists( name )
```

### Arguments
`name`  
**sysname**, required  
The name and optional schema name of a table.  
When no schema name is specified, the default schema is used.
 
### Return Types

**bit**, not null  
A value indicating whether a table with the specified name exists.
 
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
### Syntax
```sql
dbo.ViewExists( name )
```

### Arguments
`name`  
**sysname**, required  
The name and optional schema name of a view.  
When no schema name is specified, the default schema is used.
 
### Return Types

**bit**, not null  
A value indicating whether a view with the specified name exists.
 
### Usage Examples
```sql
IF dbo.ViewExists('dbo.ProductAndDescription') = 0
BEGIN
	 CREATE VIEW dbo.ProductAndDescription
	 AS
	 SELECT ...;
END
```

```sql
IF dbo.ViewExists('Sales2004') = 1
BEGIN
	 DROP VIEW Sales2004;
END
```

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