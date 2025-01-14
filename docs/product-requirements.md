# PRODUCT REQUIREMENTS

## FUNCTIONAL
### Customer
1. Customer can register and login with Username or email with password
2. Customer can register and login with social login (google)
3. Customer can update their data (phone number, address)
4. Customer can view him/her data on User page

### Cart
1. Customer can add products to the cart
2. Customer can view the list of the cart
3. Customer can view the detail of the card
4. Customer can update quantity the product in the cart
5. Customer can delete the cart
6. Customer can make an order from the cart

### Order
1. Customer can view the list of order
2. Customer can view the detail of order
3. Customer can cancel the order before the payment
4. Admin can view the list of the order and filter by status or date created
5. Admin can view the detail of the order
6. Admin can update the status of the order (shipped, failed, delivered) within the message or note
7. If customer not upload payment proof for 10 min, order will automatically cancelled

### Payment
1. Customer can make a payment after order is placed by upload the PDF or image
2. Admin can accept or reject the payment proof

### Admin
1. User can register and login as Admin in Admin page
2. Admin can make User as warehouse manager and warehouse staff

### Product
1. User can search product by it’s name or category
2. User can view the details of the product (name, price, description, and total stock)
3. Admin and warehouse manger can search the product by it’s name, sku, or category
4. Admin and warehouse manger  can view the details of the product (name, price, category, description, and quantity)
5. Admin and warehouse manger can add a product
6. Admin and warehouse manger can update a product
7. Admin and warehouse manager can delete the product within confirmation popup

### Warehouse
1. Admin and warehouse manger can view the stock level based on warehouse and product and filter by product and warehouse
2. Admin and warehouse manger can move the product stock between warehouse
3. Admin and warehouse can alert whenever the stock of product is below the limit (example: 10) 
4. Admin and warehouse manger can view the movement between warehouse (product, quantity, source, destination, created at)

### Sales Report
1. Admin can view the sales report, filter by date range, product, or warehouse
2. Admin can view the detail of report (product, price, quantity, margin)
3. Admin can download the report in PDF or CSV