CREATE ROLE movieapp_dba WITH LOGIN CONNECTION LIMIT -1 ENCRYPTED PASSWORD 'dbapassword';    
CREATE TABLESPACE movie OWNER movieapp_dba LOCATION '/home/jboadas/pgsql/data/movieapp';
CREATE DATABASE movieapp_db WITH OWNER movieapp_dba TEMPLATE template0 ENCODING 'UTF8' TABLESPACE movie CONNECTION LIMIT 1024;
