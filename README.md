**Eshop** is a cloud microservices application. The application is a web-based e-commerce app where users can find cars or motorcycle, add them to the cart, and purchase them.

This application combining the service from Amazon Web Service and Google Cloud Platform.

## Architecture
![](./docs/img/architecture.png)

| Service           | Language   | Framework   | Database     | Publisher                        | Subscriber                       | Status | Description                                                                                              |
|-------------------|------------|-------------|--------------|----------------------------------|----------------------------------|--------|----------------------------------------------------------------------------------------------------------|
| Frontend Customer | Typescript | NextJS      | -            | -                                | -                                | Done   | Expose an HTTP server to serve the website for user. Does not require signup/login to see all product.   |
| Frontend Admin    | Typescript | NextJS      | -            | -                                | -                                | Done   | Expose an HTTP server to serve the website for admin. Require signup/login to perform all actions.       |
| Auth              | Go         | Gin         | -            | -                                | -                                | Done   | Auth service to perform centralize authorization for all internal service.                               |
| Cart              | Go         | Gin         | Redis, MySQL | -                                | product-updated                  | Done   | Cart service for user saving cart and get their current cart.                                            |
| Order             | Go         | Gin         | PostgresSQL  | order-created, sale-created      | order-created, payment-updated   | Done   | Order service to process ordering after user add items to the cart and fill address detail.              |
| Payment           | Java       | Spring Boot | Mysql, S3    | payment-updated                  | -                                | Done   | Payment service that will receive the payment proof from user, then admin will validate it.              |
| Product           | Go         | Gin         | DynamoDB, S3 | product-created, product-updated | product-quantity-updated         | Done   | Product service that will show the all the list of product and the detail also with stock.               |
| Sales Report      | Python     | FastAPI     | PostgresSQL  | -                                | sale-created                     | Done   | Reporting service                                                                                        |
| Shipping Cost     | Python     | -           | -            | -                                | -                                | Done   | API for calculating the cost based on the zipcode differences, running with AWS Lambda                   |
| Warehouse         | Go         | Gin         | PostgresSQL  | product-quantity-updated         | product-created, product_updated | Done   | Warehouse service handling movement between warehouse and movement to user, also get real stock of item. |


## Services
### Auth
- handled by amazon cognito requested with this service

### Product
#### Database: Dynamo DB and Google Cloud Storage for Image
- High read-to-write ratio (many customers viewing products)
- Need for fast product view by categories
- Flexible schema
- Easy to scale

### Cart
#### Database: Redis and MySQL
- great for active cart, use will read heavy on this (act as primary storage)
- mysql just for persistence or recovery
- write is very low in mysql

### Order
#### Database: Postgres
- transaction, require strong consistency

### Payment
#### Database: MySQL
- schema simple and fixed

### Warehouse
#### Database: Postgres
- transaction
- better handling concurrent update
- better for complex query with many rows

### Sales Report
#### Database: Postgres
- great for complex analytics query
- good performance with large datasets
- built in time-series functionality

## Documentation
- [Development](/docs/development-guide.md) to learn how to run and develop this microservice locally.