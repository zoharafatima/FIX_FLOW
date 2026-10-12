# FixFlow Backend

The first backend slice provides `GET /api/customers` using Spring Boot, Spring Data JPA, and the existing MySQL `customer` table. The API response deliberately excludes `password_hash`.

## Requirements

- Java 21
- Internet access on first run so the Maven Wrapper can download Maven
- The existing MySQL server and `fixflow_db` database

## Configure and run (PowerShell)

From `backend_java`, set the database values in the current PowerShell session. Keep the password out of project files and source control:

```powershell
$env:DB_URL = "jdbc:mysql://localhost:3306/fixflow_db"
$env:DB_USERNAME = "your_mysql_username"
$env:DB_PASSWORD = "your_mysql_password"
.\mvnw.cmd spring-boot:run
```

Hibernate uses `ddl-auto=validate`; it checks mapped columns but does not create or change tables. The table-creation SQL selects `fixflow_db`, but the customer seed script selects `fix_flow_db`. Confirm the customer rows exist in `fixflow_db` in MySQL Workbench before testing this API; this project does not run either SQL script.

## Test

Run the controller test with `.\mvnw.cmd test`. With the backend running, request:

```powershell
Invoke-RestMethod http://localhost:8080/api/customers
```

The response is a JSON array. Each customer includes `customerId`, `name`, `email`, `phone`, `address`, `city`, and `createdAt`; it never includes `password_hash`.