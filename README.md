**Eshop** is a cloud microservices application. The application is a web-based e-commerce app where users can find cars or motorcycles, add them to the cart, and purchase them. This application utilizes the service from Amazon Web Service and Google Cloud Platform.

## Architecture
![](./docs/img/eshop-architecture.png)
| Service                                                            | Language   | Framework   | Database     | Publisher                        | Subscriber                       | Description                                                                                              |
|--------------------------------------------------------------------|------------|-------------|--------------|----------------------------------|----------------------------------|----------------------------------------------------------------------------------------------------------|
| [Frontend Customer](https://github.com/idoyudha/eshop-fe-customer) | Typescript | NextJS      | -            | -                                | -                                | Expose an HTTP server to serve the website for the user. Does not require signup/login to see all products.   |
| [Frontend Admin](https://github.com/idoyudha/eshop-fe-admin)       | Typescript | NextJS      | -            | -                                | -                                | Expose an HTTP server to serve the website for admin. Require signup/login to perform all actions.       |
| [Auth](https://github.com/idoyudha/eshop-auth)                     | Go         | Gin         | -            | -                                | -                                | Auth service to perform centralized authorization for all internal services.                               |
| [Cart](https://github.com/idoyudha/eshop-cart)                     | Go         | Gin         | Redis, MySQL | -                                | product-updated                  | Cart service for user saving cart and get their current cart.                                            |
| [Order](https://github.com/idoyudha/eshop-order)                   | Go         | Gin         | PostgresSQL  | order-created, sale-created      | order-created, payment-updated   | Order service to process ordering after user adds items to the cart and fills address detail.              |
| [Payment](https://github.com/idoyudha/eshop-payment)               | Java       | Spring Boot | Mysql, S3    | payment-updated                  | -                                | Payment service that will receive the payment proof from the  user, then admin will validate it.              |
| [Product](https://github.com/idoyudha/eshop-product)               | Go         | Gin         | DynamoDB, S3 | product-created, product-updated | product-quantity-updated         | Product service that will show the all the list of product and the detail also with stock.               |
| [Sales Report](https://github.com/idoyudha/eshop-sales-report)     | Python     | FastAPI     | PostgresSQL  | -                                | sale-created                     | Reporting service                                                                                        |
| [Shipping Cost](https://github.com/idoyudha/eshop-shipping-cost)   | Python     | -           | -            | -                                | -                                | API for calculating the cost based on the zip code differences, running with AWS Lambda                   |
| [Warehouse](https://github.com/idoyudha/eshop-warehouse)           | Go         | Gin         | PostgresSQL  | product-quantity-updated         | product-created, product_updated | Warehouse service handles movement between warehouse and user, also get real stock of item. |

## Screenshots
| Home Page                      | Product Detail                           |
|--------------------------------|------------------------------------------|
| ![](./docs/img/eshop-home.png) | ![](./docs/img/eshop-product-detail.png) |

| Add to Cart                           | Checkout                           |
|---------------------------------------|------------------------------------|
| ![](./docs/img/eshop-add-to-cart.png) | ![](./docs/img/eshop-checkout.png) |

| Order List                           | Order Detail                           |
|--------------------------------------|----------------------------------------|
| ![](./docs/img/eshop-order-list.png) | ![](./docs/img/eshop-order-detail.png) |

## Services
### Auth
- handled by amazon cognito, requested with this service
### Product
#### Database: Dynamo DB and Amazon S3
- High read-to-write ratio (many customers viewing products)
- Need for fast product view by categories
- Flexible schema
- Easy to scale
- Durable and reliable for image storage (S3)
### Cart
#### Database: Redis Sentinel and MySQL
- Great for active cart; use will have read heavy on this (acts as primary storage)
- High availability on redis sentinel, with one master act as write and two slave act as read
- Mysql just for persistence or recovery
- Write is very low in mysql
### Order
#### Database: Postgres
- Transaction require strong consistency
### Payment
#### Database: MySQL and Amazon S3
- Simple schema and fixed
- Durable and reliable for image storage (S3)
### Warehouse
#### Database: Postgres
- Transaction
- Better handling concurrent update
- Better for complex query with many rows
### Sales Report
#### Database: Postgres
- Great for complex analytics query
- Good performance with large datasets
- Built-in time-series functionality
## Documentation
- [Development](/docs/development-guide.md) to learn how to run and develop this microservice locally or via Google Kubernetes Engine.
- [API Documentation](https://lh53ntuiw1.apidog.io) with password: *0ceNdUuG* (temporary)
## Contact
- Email: idowidya.yudhatama@gmail.com
- LinkedIn: https://linkedin.com/in/idoyudha
