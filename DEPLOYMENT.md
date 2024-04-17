# Admin functionality
    uncomment Adminconfig.java src\main\java\com\omas\webapp\config\AdminConfig.java file if you want to create a default admin user

# copy schema
    docker exec database pg_dump -U postgres -d omas -n public > schema.sql