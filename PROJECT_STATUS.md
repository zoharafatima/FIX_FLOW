# FixFlow Project Status

## Milestone 1: Customer read API

- [x] Inspected the supplied customer table definition and seed SQL.
- [x] Added Spring Boot 3.5 / Java 21 Maven backend structure and environment-based MySQL settings.
- [x] Added customer entity, repository, service, response DTO, and `GET /api/customers` controller.
- [x] Configured Hibernate schema validation only; it will not create or modify tables.
- [x] Added an MVC test verifying the JSON response omits password hashes.
- [x] Documented the database-name discrepancy and local run commands.
- [x] Added the Maven Wrapper and passed the focused MVC test with `mvnw.cmd`; no system-wide Maven installation was made.
- [ ] Run the backend against MySQL and retrieve existing customer rows; MySQL is listening locally, but `DB_USERNAME` and `DB_PASSWORD` are not configured in this shell.

## Later MVP work

- [ ] Add the remaining domain APIs, validation, and business rules.
- [ ] Add the Streamlit client communicating only over HTTP.
- [ ] Add broader tests, API documentation, and a demonstration guide.