#!/bin/sh
# Create main database
# need to edit line in pg_hba.conf
# local all postgres trust
dropdb -U postgres movieapp_db
sudo mkdir -p /home/jboadas/pgsql/data/movieapp
sudo chown postgres:postgres /home/jboadas/pgsql/data/movieapp
psql template1 postgres < ../etc/pgsql_movie_local.sql
psql bibleapp_db postgres -c 'CREATE SCHEMA IF NOT EXISTS public AUTHORIZATION movieapp_dba; GRANT ALL ON SCHEMA public TO movieapp_dba;'
# Create tables
psql movieapp_db movieapp_dba < ../etc/movie_ddl.sql
# Populate DB
#psql bibleapp_db bibleapp_dba < ../etc/db_init.sql
# Migrate DB
#psql bibleapp_db bibleapp_dba < ../etc/db_init_verses.sql

# Create tests database
# dropdb -U postgres bibleapp_db_test
# sudo mkdir -p /home/jboadas/pgsql/data/bibleapp_test
# sudo chown postgres:postgres /home/jboadas/pgsql/data/bibleapp_test
# psql template1 postgres < ../etc/pgsql_bible_local_test.sql
# psql bibleapp_db_test postgres -c 'CREATE SCHEMA IF NOT EXISTS public AUTHORIZATION bibleapp_dba_test; GRANT ALL ON SCHEMA public TO bibleapp_dba_test;'
# Create tables
# psql bibleapp_db_test bibleapp_dba_test < ../etc/bible_ddl_test.sql


