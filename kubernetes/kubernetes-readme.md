# Redis Deployment Configuration

This document explains how to configure a resilient Redis instance on Kubernetes using a `Deployment`. It covers networking with `Service` objects, security with a `Secret`, and external access with a `LoadBalancer` via MetalLB.

## Core Components

A complete Redis setup involves four main Kubernetes objects:

1.  **Secret**: Securely stores the Redis password, keeping it out of your configuration files.
2.  **Deployment**: Manages the Redis pods. If a pod fails, the deployment will automatically create a new one.
3.  **ClusterIP Service**: Provides a stable internal network DNS entry for the Redis instance, used for communication within the cluster.
4.  **LoadBalancer Service**: Exposes Redis to the local network by assigning it a stable IP address from MetalLB.

---
## 1. The Secret (Dynamic Creation)

Instead of writing a YAML file, we create the secret directly on the command line. This is simpler and `kubectl` handles the required base64 encoding.

**Command to Create the Secret:**

```bash
kubectl create secret generic redis-secret \
  --from-literal=REDIS_PASSWORD='your-strong-password' \
  -n smart-shell-production
```

**Note**: Remember to replace `'your-strong-password'` with a real, secure password.

---
## 2. The Deployment

This is the main controller for our Redis pod. It ensures that a pod running Redis is always available. The deployment is configured to use the password stored in our `redis-secret`.

**`deployment.yml`**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
  namespace: smart-shell-production
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis:latest
        ports:
        - containerPort: 6379
        env:
        - name: REDIS_PASSWORD
          valueFrom:
            secretKeyRef:
              name: redis-secret
              key: REDIS_PASSWORD
```

---
## 3. The Services

We use two services to manage access to our Redis deployment.

### Internal Service (`service.yml`)

This service provides a stable DNS name (`redis-service.smart-shell-production.svc.cluster.local`) for other applications inside the Kubernetes cluster to connect to Redis.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: redis-service
  namespace: smart-shell-production
spec:
  clusterIP: None
  ports:
    - port: 6379
      name: redis
  selector:
    app: redis
```

### External Service (`external-service.yml`)

This service uses MetalLB to expose Redis on your local network. It shares the IP `192.168.100.241` with other services by using a special annotation.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: redis-external-service
  namespace: smart-shell-production
  annotations:
    metallb.universe.tf/allow-shared-ip: "192.168.100.241"
spec:
  type: LoadBalancer
  loadBalancerIP: 192.168.100.241
  ports:
    - port: 6379
      targetPort: 6379
      protocol: TCP
  selector:
    app: redis
```

---
## How to Deploy

1.  **Create the Secret**:
    ```bash
    kubectl create secret generic redis-secret \
      --from-literal=password='your-strong-password' \
      -n smart-shell-production
    ```

2.  **Apply the Manifests**:
    Apply all the YAML files to create the deployment and services.
    ```bash
    kubectl apply -f kubernetes/deployment.yml
    kubectl apply -f kubernetes/service.yml
    kubectl apply -f kubernetes/external-service.yml
    ```
    **Important**: After applying the deployment, the Redis pod will restart to begin using the new password.

---
## How to Connect

Once deployed, you can connect to Redis from any machine on your local network using the shared IP and the password you created.

```bash
redis-cli -h 192.168.100.241 -a 'your-strong-password'
```

**Note on the user:** By default, Redis uses a single user named `default`. The password you have configured is for this user. The `redis-cli` client automatically uses the `default` user when you provide a password with the `-a` flag, so you don't need to specify a username.

You can test the connection with the `PING` command, which should return `PONG`.

```
