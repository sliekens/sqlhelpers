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
IF dbo.TableExists('Products') = 1
BEGIN
	 DROP TABLE Products;
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
Note that you can't use `CREATE VIEW` or `ALTER VIEW` inside a conditional block. You can use `sp_executesql` as a workaround. The following example uses `sp_executesql` to ensure that a placeholder view with the specified name exists. You can then use `ALTER VIEW` on the placeholder view in a new batch.
```sql
-- Create a placeholder that can be altered later
IF dbo.ViewExists('dbo.ProductAndDescription') = 0
  EXEC sp_executesql @statements = N'CREATE VIEW dbo.ProductAndDescription AS SELECT NULL [undefined]'
GO

ALTER VIEW dbo.ProductAndDescription
AS -- Actual implementation
SELECT ...
```

The same restrictions do not apply to `DROP VIEW`.

```sql
IF dbo.ViewExists('ProductAndDescription') = 1
  DROP VIEW ProductAndDescription;
```

## dbo.StoredProcedureExists
### Syntax
```sql
dbo.StoredProcedureExists( name )
```

### Arguments
`name`  
**sysname**, required  
The name and optional schema name of a stored procedure.  
When no schema name is specified, the default schema is used.
 
### Return Types

**bit**, not null  
A value indicating whether a stored procedure with the specified name exists.
 
### Usage Examples
Note that you can't use `CREATE PROCEDURE` or `ALTER PROCEDURE` inside a conditional block. You can use `sp_executesql` as a workaround. The following example uses `sp_executesql` to ensure that a placeholder procedure with the specified name exists. You can then use `ALTER PROCEDURE` on the placeholder procedure in a new batch.
```sql
-- Create a placeholder that can be altered later
IF dbo.StoredProcedureExists('dbo.GetSalesByProduct') = 0
    EXEC sp_executesql @statement = N'CREATE PROCEDURE dbo.GetSalesByProduct AS;'
GO

ALTER PROCEDURE dbo.GetSalesByProduct
AS -- Actual implementation
SELECT ...;
```

```sql
IF dbo.StoredProcedureExists('GetSalesByProduct') = 1
  DROP PROCEDURE GetSalesByProduct;
```

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