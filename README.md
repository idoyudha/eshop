# eshop
The application is a web-based e-commerce app where users can browse products, add them to the cart, and purchase them.

## User management
- handled by amazon cognito

## Product
### Database: Dynamo DB and Google Cloud Storage for Image
Reason:
- High read-to-write ratio (many customers viewing products)
- Need for fast product view by categories
- Flexible schema
- Easy to scale

## Cart
### Database: Redis and MySQL
- great for active cart, use will read heavy on this (act as primary storage)
- mysql just for persistence or recovery
- write is very low in mysql

## Order
### Database: Postgres
- transaction, require strong consistency

## Payment
### Database: MySQL
- schema simple and fixed

## Warehouse
### Database: Postgres
- transaction
- better handling concurrent update
- better for complex query with many rows

## Sales Report
### Database: Postgres
- great for complex analitycs query
- good performnace with large datasets
- built in time-series functionality