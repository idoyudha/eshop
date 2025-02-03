#!/bin/bash
set -e

until PGPASSWORD=$POSTGRES_PASSWORD psql -h $POSTGRES_MASTER_HOST -U $POSTGRES_USER -d $POSTGRES_DB -c '\q'; do
    >&2 echo "Waiting for master to be ready..."
    sleep 1
done

# Use different replication slots for each replica
SLOT_NAME="${REPLICA_NAME}_slot"

pg_basebackup -h $POSTGRES_MASTER_HOST -D $PGDATA -U $POSTGRES_REPLICATION_USER -P -v -R \
    -X stream \
    -S $SLOT_NAME \
    -W