# Automated Redis Database Deployment with Docker and Kubernetes

![Project Logo](./resources/logo.png)

This repository is intended to automate the deployment of a Redis database, providing a caching server for the Smart-Shell (Electronic Invoicing) and Platform-Training (Training Platform) projects.

## Related Repositories

### Current Repository
- [Smart-Shell-Redis](https://github.com/luis122448/smart-shell-redis)

### Application Repositories
Backend and Frontend repositories for the Smart-Shell and Platform-Training applications.
- [Smart-Shell-Angular](https://github.com/luis122448/smart-shell-angular)
- [Smart-Shell-SpringBoot](https://github.com/luis122448/smart-shell-springboot)
- [Platform-Training-Angular](https://github.com/luis122448/platform-training-angular)
- [Platform-Training-SpringBoot](https://github.com/luis122448/platform-training-springboot)

### Automation Repositories
- [Smart-Shell-Bash](https://github.com/luis122448/smart-shell-bash)

### Other Database Repositories
- [Smart-Shell-Mongo](https://github.com/luis122448/smart-shell-mongo)
- [Smart-Shell-Postgres](https://github.com/luis122448/smart-shell-postgres)

---

## Deployment Methods

This project supports two deployment methods: Docker Compose for simple, single-machine setups, and Kubernetes for scalable, production-grade environments.

### 1. Deployment with Docker Compose

Follow these steps to deploy Redis using Docker Compose.

#### Environment Setup

1.  **Clone the Repository**
    
```bash
git clone https://github.com/luis122448/smart-shell-redis.git
```

2.  **Enter the project directory**
    
```bash
cd smart-shell-redis
```

3.  **Run the installation script**
    
```bash
sudo bash install.sh
```

4.  **Define credentials in the .env file**
    
Create or edit the `.env` file to set your Redis password.

```bash
nano .env
```

```env
REDIS_PASSWORD='your-strong-password'
```

5.  **Create the Docker network (if it doesn't exist)**
    
```bash
docker network create smart-shell-net
```

#### Production Deployment

For production, this project uses Docker and Docker Compose. You can review the `docker-compose.yml` file for configuration details. Ensure your `.env` file is correctly configured.

1.  **Run the deployment script**
    
```bash
sudo bash deploy.sh
```

### 2. Deployment with Kubernetes

For a scalable and resilient production environment, we recommend deploying to Kubernetes.

The detailed guide for the Kubernetes deployment, including security, networking, and password management, is located in a separate document.

**Please refer to the [Kubernetes Deployment Guide](./kubernetes/kubernetes-readme.md) for step-by-step instructions.**

---

## Verifying the Deployment

To verify that your Redis instance is running correctly, you will need `redis-cli`, the command-line interface for Redis.

#### 1. Installing `redis-cli`

-   **Debian/Ubuntu**:
    
```bash
sudo apt-get update && sudo apt-get install redis-tools
```

-   **CentOS/RHEL/Fedora**:
    
```bash
sudo dnf install redis # Or sudo yum install redis
```

-   **macOS (with Homebrew)**:
    
```bash
brew install redis
```

#### 2. Connecting to the Database

Connect to Redis using the appropriate IP address and your password.

-   **For Docker Compose:** Connect to your local machine's IP or `localhost`.
-   **For Kubernetes:** Use the external IP assigned by the LoadBalancer (e.g., `192.168.100.241`).

```bash
# Replace <ip-address> and <password>
redis-cli -h <ip-address> -a '<password>'
```

#### 3. Testing the Connection

Once connected, run the `PING` command. Redis should reply with `PONG`.

```
127.0.0.1:6379> PING
PONG
```

---

## Connection String for Spring Boot

Configuration for a Java project with Spring Boot (`application.properties`).

```properties
# Redis Configuration
spring.redis.host=${REDIS_HOST:localhost}
spring.redis.port=${REDIS_PORT:6379}
spring.redis.password=${REDIS_PASSWORD:your-strong-password}
```

## Contributions

Contributions are welcome. Feel free to improve this project, add new features, or fix identified issues. To contribute, please create a Pull Request or open an Issue.

## License

This project is under the MIT License.
