# copy schema
    docker exec database pg_dump -U postgres -d omas -n public > schema.sql