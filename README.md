# SQL Helpers
This repository contains T-SQL functions that help migrate databases to newer versions.
The functions provide a simple API for checking whether objects exists and whether they have constraints.

**Instalation instructions**

Run the scripts from this repository on your database to create the helper functions. When newer versions become available, you can safely update to the latest version by running the new scripts.

**List of functions**
 - [dbo.TableExists](#dbotableexists)
 - [dbo.ViewExists](#dboviewexists)
 - [dbo.StoredProcedureExists](#dbostoredprocedureexists)
 - [dbo.FunctionExists](#dbofunctionexists)
 - [dbo.IndexExists](#dboindexexists)
 - [dbo.ColumnExists](#dbocolumnexists)
 - [dbo.ColumnAllowsNull](#dbocolumnallowsnull)
 - [dbo.PrimaryKeyExists](#dboprimarykeyexists)
 - [dbo.TypeExists](#dbotypeexists)

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