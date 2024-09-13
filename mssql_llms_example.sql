use master;
go

exec sp_configure 'show advanced options', 1;
go

reconfigure;
go

exec sp_configure 'clr enabled', 1;
go

reconfigure;
go

create database [ai];
go

alter authorization on database::[ai] to [sa];
go

alter database [ai] set trustworthy on;
go

use [ai];
go

--exec sp_add_trusted_assembly 0x<SHA2 512>,
--	N'SqlServerLlmClr, version=0.0.0.0, culture=neutral, publickeytoken=null, processorarchitecture=msil';
--go

--create assembly [SqlServerLlmClr]
--authorization [dbo]
--from 'D:\Temp\SqlServerLlmClr.dll'
--with permission_set = unsafe
--go

create procedure [dbo].[hello_world] @out nvarchar(255) output
with execute as caller
as
external name [SqlServerLlmClr].[SqlServerLlmClr].[HelloWorld]
go

declare @out nvarchar(255);
exec [dbo].[hello_world] @out output;
select @out as output;
go

create procedure [dbo].[generate_and_execute_sql] @prompt nvarchar(max), @db_name sysname, @model sysname, @additional_instructions nvarchar(4000) = N''
with execute as caller
as
external name [SqlServerLlmClr].[SqlServerLlmClr].[GeneratAndExecuteSql]
go

exec [ai].[dbo].[generate_and_execute_sql] @prompt = 'show me all users', @db_name = 'TEST', @model = 'phi3.5';
go

exec [ai].[dbo].[generate_and_execute_sql] @prompt = 'Who is the oldest user?', @db_name = 'TEST', @model = 'duckdb-nsql';
go

exec [ai].[dbo].[generate_and_execute_sql] @prompt = 'how many people work in my company', @db_name = 'TEST', @model = 'duckdb-nsql';
go

exec [ai].[dbo].[generate_and_execute_sql] @prompt = 'how many people work in my company? use is_active = 1 filter for employees tables to count only currently employed people', @db_name = 'TEST', @model = 'duckdb-nsql';
go

exec [ai].[dbo].[generate_and_execute_sql] @prompt = 'find the city where most of my workers live', @db_name = 'TEST', @model = 'llama3.1';
go

exec [ai].[dbo].[generate_and_execute_sql] @prompt = 'name the second popular city where most of my workers live', @db_name = 'TEST', @model = 'llama3.1';
go


--exec [ai].[dbo].[generate_and_execute_sql] @prompt = 'how many people work in my company', @db_name = 'AdventureWorks2022', @model = 'mistral';
--go

--exec [ai].[dbo].[generate_and_execute_sql] @prompt = 'return top 5 cities where employees live', @db_name = 'AdventureWorks2022', @model = 'mistral';
--go
