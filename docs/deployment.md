# Step deployment

## Namespace
kubectl create namespace eshop

## ConfigMaps
# Kafka Config
kubectl apply -f k8s/kafka0-cm0-configmap.yaml -n eshop
kubectl apply -f k8s/kafka1-cm0-configmap.yaml -n eshop
kubectl apply -f k8s/kafka-init-topics-cm0-configmap.yaml -n eshop

# Backend Services Config
kubectl apply -f k8s/eshop-product-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-cart-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-auth-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-order-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-warehouse-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-payment-env-configmap.yaml -n eshop

# Frontend Services Config
kubectl apply -f k8s/eshop-fe-customer-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-fe-admin-env-configmap.yaml -n eshop

## Persistent Volume Claims
kubectl apply -f k8s/redis-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/mysql-cart-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/mysql-payment-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-warehouse-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-order-write-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-order-read-data-persistentvolumeclaim.yaml -n eshop

## Database Deployments & Services
# Redis
kubectl apply -f k8s/redis-deployment.yaml -n eshop
kubectl apply -f k8s/redis-service.yaml -n eshop

# MySQL Cart
kubectl apply -f k8s/mysql-cart-deployment.yaml -n eshop
kubectl apply -f k8s/mysql-cart-service.yaml -n eshop

# MySQL Payment
kubectl apply -f k8s/mysql-payment-deployment.yaml -n eshop
kubectl apply -f k8s/mysql-payment-service.yaml -n eshop

# PostgreSQL Order Write
kubectl apply -f k8s/postgresql-order-write-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-order-write-service.yaml -n eshop

# PostgreSQL Order Read
kubectl apply -f k8s/postgresql-order-read-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-order-read-service.yaml -n eshop

# PostgreSQL Warehouse
kubectl apply -f k8s/postgresql-warehouse-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-warehouse-service.yaml -n eshop

## Kafka Infrastructure
kubectl apply -f k8s/kafka0-deployment.yaml -n eshop
kubectl apply -f k8s/kafka0-service.yaml -n eshop
kubectl apply -f k8s/kafka1-deployment.yaml -n eshop
kubectl apply -f k8s/kafka1-service.yaml -n eshop
kubectl apply -f k8s/schemaregistry0-deployment.yaml -n eshop
kubectl apply -f k8s/schemaregistry0-service.yaml -n eshop
kubectl apply -f k8s/schemaregistry1-deployment.yaml -n eshop
kubectl apply -f k8s/schemaregistry1-service.yaml -n eshop
kubectl apply -f k8s/kafka-ui-deployment.yaml -n eshop
kubectl apply -f k8s/kafka-ui-service.yaml -n eshop

## Backend Services
# Product Service
kubectl apply -f k8s/eshop-product-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-product-service.yaml -n eshop

# Cart Service
kubectl apply -f k8s/eshop-cart-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-cart-service.yaml -n eshop

# Auth Service
kubectl apply -f k8s/eshop-auth-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-auth-service.yaml -n eshop

# Order Service
kubectl apply -f k8s/eshop-order-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-order-service.yaml -n eshop

# Warehouse Service
kubectl apply -f k8s/eshop-warehouse-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-warehouse-service.yaml -n eshop

# Payment Service
kubectl apply -f k8s/eshop-payment-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-payment-service.yaml -n eshop

## Frontend Services
# Customer
kubectl apply -f k8s/eshop-fe-customer-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-fe-customer-service.yaml -n eshop

# Admin
kubectl apply -f k8s/eshop-fe-admin-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-fe-admin-service.yaml -n eshop

## Kafka Topic Initialization
kubectl apply -f k8s/kafka-init-topics-deployment.yaml -n eshop


## Apply in one command
kubectl apply -f k8s/ -n eshop