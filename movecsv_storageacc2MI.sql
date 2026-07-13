--Step 1: Create a Database Master Key
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'StrongPassword@123';

--Step 2: Create Database Scoped Credential
CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredential
WITH
IDENTITY='SHARED ACCESS SIGNATURE',
SECRET='sp=racwdli&st=2026-07-13T13:20:34Z&se=2026-07-13T21:35:34Z&spr=https&sv=2026-02-06&sr=c&sig=uTtrut4wki14VcgnwSCeMy%2FYmup2tKecR9fLOLY%2FqPQ%3D';

--Step 3: Create External Data Source
CREATE EXTERNAL DATA SOURCE AzureBlob
WITH
(
    TYPE = BLOB_STORAGE,
    LOCATION = 'https://yourstorageaccount.blob.core.windows.net/yourcontainer',
    CREDENTIAL = AzureStorageCredential
);

--Step 4: Create the Destination Table
CREATE TABLE Employee
(
    EmployeeID INT,

);

--Import the CSV
BULK INSERT Employee
FROM 'movementdata.csv'
WITH
(
    DATA_SOURCE = 'AzureBlob',
    FORMAT='CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
);


--SQL MI don't support OpenRowset in CSV parser