# Step deployment

## Namespace
```sh
kubectl create namespace eshop
```

## ConfigMaps
# Kafka Config
```sh
kubectl apply -f k8s/kafka-init-topics-cm0-configmap.yaml -n eshop
```

# Backend Services Config
```sh
kubectl apply -f k8s/eshop-auth-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-cart-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-order-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-payment-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-product-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-warehouse-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-sales-report-env-configmap.yaml -n eshop
```

# Frontend Services Config
```sh
kubectl apply -f k8s/eshop-fe-customer-env-configmap.yaml -n eshop
kubectl apply -f k8s/eshop-fe-admin-env-configmap.yaml -n eshop
```

## Persistent Volume Claims
```sh
kubectl apply -f k8s/redis-master-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/redis-slave1-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/redis-slave2-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/redis-sentinel1-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/redis-sentinel2-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/redis-sentinel3-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/mysql-cart-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/mysql-payment-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-warehouse-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-order-write-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-order-read-data-persistentvolumeclaim.yaml -n eshop
kubectl apply -f k8s/postgres-sales-data-persistentvolumeclaim.yaml -n eshop
```

## Database Deployments & Services
# Redis Sentinel
```sh
kubectl apply -f k8s/redis-master-deployment.yaml -n eshop
kubectl apply -f k8s/redis-master-service.yaml -n eshop
kubectl apply -f k8s/redis-slave1-deployment.yaml -n eshop
kubectl apply -f k8s/redis-slave1-service.yaml -n eshop
kubectl apply -f k8s/redis-slave2-deployment.yaml -n eshop
kubectl apply -f k8s/redis-slave2-service.yaml -n eshop
kubectl apply -f k8s/redis-sentinel1-deployment.yaml -n eshop
kubectl apply -f k8s/redis-sentinel1-service.yaml -n eshop
kubectl apply -f k8s/redis-sentinel2-deployment.yaml -n eshop
kubectl apply -f k8s/redis-sentinel2-service.yaml -n eshop
kubectl apply -f k8s/redis-sentinel3-deployment.yaml -n eshop
kubectl apply -f k8s/redis-sentinel3-service.yaml -n eshop
```

# MySQL Cart
```sh
kubectl apply -f k8s/mysql-cart-deployment.yaml -n eshop
kubectl apply -f k8s/mysql-cart-service.yaml -n eshop
```

# MySQL Payment
```sh
kubectl apply -f k8s/mysql-payment-deployment.yaml -n eshop
kubectl apply -f k8s/mysql-payment-service.yaml -n eshop
```

# PostgreSQL Order Write
```sh
kubectl apply -f k8s/postgresql-order-write-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-order-write-service.yaml -n eshop
```

# PostgreSQL Order Read
```sh
kubectl apply -f k8s/postgresql-order-read-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-order-read-service.yaml -n eshop
```

# PostgreSQL Warehouse
```sh
kubectl apply -f k8s/postgresql-warehouse-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-warehouse-service.yaml -n eshop
```

# PostgreSQL Sales
```sh
kubectl apply -f k8s/postgresql-sales-deployment.yaml -n eshop
kubectl apply -f k8s/postgresql-sales-service.yaml -n eshop
```

## Kafka Infrastructure
```sh
kubectl apply -f k8s/kafka0-deployment.yaml -n eshop
kubectl apply -f k8s/kafka0-service.yaml -n eshop
kubectl apply -f k8s/kafka1-deployment.yaml -n eshop
kubectl apply -f k8s/kafka1-service.yaml -n eshop
kubectl apply -f k8s/kafka2-deployment.yaml -n eshop
kubectl apply -f k8s/kafka2-service.yaml -n eshop
kubectl apply -f k8s/schemaregistry0-deployment.yaml -n eshop
kubectl apply -f k8s/schemaregistry0-service.yaml -n eshop
kubectl apply -f k8s/schemaregistry1-deployment.yaml -n eshop
kubectl apply -f k8s/schemaregistry1-service.yaml -n eshop
kubectl apply -f k8s/kafka-ui-deployment.yaml -n eshop
kubectl apply -f k8s/kafka-ui-service.yaml -n eshop
```

## Backend Services
# Auth Service
```sh
kubectl apply -f k8s/eshop-auth-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-auth-service.yaml -n eshop
```

# Cart Service
```sh
kubectl apply -f k8s/eshop-cart-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-cart-service.yaml -n eshop
```

# Order Service
```sh
kubectl apply -f k8s/eshop-order-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-order-service.yaml -n eshop
```

# Payment Service
```sh
kubectl apply -f k8s/eshop-payment-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-payment-service.yaml -n eshop
```

# Product Service
```sh
kubectl apply -f k8s/eshop-product-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-product-service.yaml -n eshop
```

# Sales Report Service
```sh
kubectl apply -f k8s/eshop-sales-report-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-sales-report-service.yaml -n eshop
```

# Warehouse Service
```sh
kubectl apply -f k8s/eshop-warehouse-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-warehouse-service.yaml -n eshop
```

## Frontend Services
# Customer
```sh
kubectl apply -f k8s/eshop-fe-customer-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-fe-customer-service.yaml -n eshop
```

# Admin
```sh
kubectl apply -f k8s/eshop-fe-admin-deployment.yaml -n eshop
kubectl apply -f k8s/eshop-fe-admin-service.yaml -n eshop
```

## Kafka Topic Initialization
```sh
kubectl apply -f k8s/kafka-init-topics-deployment.yaml -n eshop
```

## Apply in one command
```sh
kubectl apply -f k8s/ -n eshop
```