-----------------------------------------------------------------------
--Date: 17-oct-2024
--Owner: Jaideep Singh
--Purpose: Set all database to read_only/read_write at once
------------------------------------------------------------------------
DECLARE @dbName NVARCHAR(256)
DECLARE db_cursor CURSOR FOR
SELECT name 
FROM sys.databases 
WHERE database_id > 4  -- Exclude system databases

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @dbName  

WHILE @@FETCH_STATUS = 0  
BEGIN  
    DECLARE @sql NVARCHAR(MAX)
    SET @sql = 'ALTER DATABASE [' + @dbName + '] SET READ_Only;'   ---set database to readonly and change to read_write
    EXEC sp_executesql @sql
    
    FETCH NEXT FROM db_cursor INTO @dbName  
END  

CLOSE db_cursor  
DEALLOCATE db_cursor  

PRINT 'All user databases have been set to READ_ONLY.'
