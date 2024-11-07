function sample_staging

  set PGHOST smx-ase-stage-statsparser-pgsf.postgres.database.azure.com
  set DBNAME aus-smx3_mailreport
  set PGUSER Developers
  set -x PGPASSWORD (az account get-access-token --resource-type oss-rdbms --query "[accessToken]" -o tsv)

  set PGURL host=$PGHOST user=$PGUSER dbname=$DBNAME sslmode=require

  # Dump the schema only
  # echo DUMPING SCHEMA
  # pg_dump -v --schema-only --schema=inbound -f /tmp/smx3_staging_dump_schema.sql "$PGURL"

  # Dump the sampled data
  echo SAMPLING DATA
  ~/go/bin/pg_dump_sample -s -w -h $PGHOST -U $PGUSER -f ~/Documents/smx3_staging_dump.yml -o /tmp/smx3_staging_dump.sql $DBNAME

  # Unset any vars to prevent accidentally operating on remote DBs
  set -e PGHOST
  set -e DBNAME
  set -e PGUSER
  set -e PGPASSWORD
  set -e PGURL

  # Drop and reload the db
  # echo RECREATING MAIL REPORT
  # dropdb -Usmx smx3_mailreport
  # createdb -Usmx smx3_mailreport
  # psql -Usmx smx3_mailreport < /tmp/smx3_staging_dump_schema.sql
  # psql -Usmx smx3_mailreport < /tmp/smx3_staging_dump.sql

end
