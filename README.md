# SQL Helpers
This repository contains T-SQL functions that help migrate databases to newer versions.
The functions provide a simple API for checking whether objects exists and whether they have constraints.

## Project Goals
My goal is to provide a simplish way to check the state of your database.

Previously, you would write code like this to check if a table exists (and drop it when it does):

```sql
IF OBJECT_ID('dbo.Scores', 'U') IS NOT NULL 
  DROP TABLE dbo.Scores;
```

That's kind of hard to read and even harder to remember. ('U' is for 'Table', duh doy!)

Instead you should be able to write this:

```sql
IF TableExists('dbo.Scores')
    DROP TABLE dbo.Scores;
```

## Instalation instructions

Run the scripts from this repository on your database to create the helper functions. When newer versions become available, you can safely update to the latest version by running the new scripts.

## Available Functions
Click on a function name to go to its page on the wiki.
 - [TableExists](https://github.com/StevenLiekens/sqlhelpers/wiki/TableExists)
 - [ViewExists](https://github.com/StevenLiekens/sqlhelpers/wiki/ViewExists)
 - [StoredProcedureExists](https://github.com/StevenLiekens/sqlhelpers/wiki/StoredProcedureExists)
 - [FunctionExists](https://github.com/StevenLiekens/sqlhelpers/wiki/FunctionExists)
 - [IndexExists](https://github.com/StevenLiekens/sqlhelpers/wiki/IndexExists)
 - [ColumnExists](https://github.com/StevenLiekens/sqlhelpers/wiki/ColumnExists)
 - [ColumnAllowsNull](https://github.com/StevenLiekens/sqlhelpers/wiki/ColumnAllowsNull)
 - [PrimaryKeyExists](https://github.com/StevenLiekens/sqlhelpers/wiki/PrimaryKeyExists)
 - [TypeExists](https://github.com/StevenLiekens/sqlhelpers/wiki/TypeExists)
