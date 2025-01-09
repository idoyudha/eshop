# Step deployent

## Persistent Volume Claim
kubectl apply -f k8s/mysql-cart-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/mysql-payment-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-order-read-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-order-write-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-warehouse-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/redis-data-persistentvolumeclaim.yaml -n eshop

## Database Deployment
kubectl apply -f k8s/mysql-cart-deployment.yaml -n eshop
kubectl apply -f k8s/mysql-payment-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-order-read-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-order-write-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-warehouse-deployment.yaml -n eshop
kubectl apply -f k8s/redis-deployment.yaml -n eshop