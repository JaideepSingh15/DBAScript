----Schema validation
SELECT 
    s.name AS schema_name,
    USER_NAME(s.principal_id) AS owner
FROM sys.schemas s
WHERE USER_NAME(s.principal_id) = 'sqladmin';



---- Table level 
SELECT 
    o.name AS object_name,
    o.type_desc,
    SCHEMA_NAME(o.schema_id) AS schema_name,
    USER_NAME(o.principal_id) AS owner
FROM sys.objects o
WHERE o.principal_id IS NOT NULL
AND USER_NAME(o.principal_id) = 'sqladmin';

--#####Database Roles 
SELECT 
    name AS role_name,
    USER_NAME(owning_principal_id) AS owner
FROM sys.database_principals
WHERE type = 'R'
AND USER_NAME(owning_principal_id) = 'sqladmin';

---Fix: ALTER AUTHORIZATION ON ROLE::[role_name] TO dbo;
--####application roles:
SELECT 
    name,
    USER_NAME(owning_principal_id) AS owner
FROM sys.database_principals
WHERE type = 'A'
AND USER_NAME(owning_principal_id) = 'sqladmin';

--##fix: ALTER AUTHORIZATION ON APPLICATION ROLE::[app_role_name] TO dbo;

--##certificate: 
SELECT 
    name,
    USER_NAME(principal_id) AS owner
FROM sys.certificates
WHERE USER_NAME(principal_id) = 'sqladmin';
--## FIX: ALTER AUTHORIZATION ON CERTIFICATE::[cert_name] TO dbo;

--###asymmetics keys
SELECT 
    name,
    USER_NAME(principal_id) AS owner
FROM sys.asymmetric_keys
WHERE USER_NAME(principal_id) = 'sqladmin';
--###Fix: ALTER AUTHORIZATION ON ASYMMETRIC KEY::[key_name] TO dbo;

--###Drop User
DROP USER [sqladmin];

