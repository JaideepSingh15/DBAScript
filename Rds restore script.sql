exec msdb.dbo.rds_backup_database
    @source_db_name='TestDB_1000Tables',
    @s3_arn_to_backup_to='arn:aws:s3:::amzn-s3-bacpac/backup/Testdb.bacpac'


	exec msdb.dbo.rds_task_status;
   exec msdb.dbo.rds_task_status @db_name='TestDB_1000Tables';