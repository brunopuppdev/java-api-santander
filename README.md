# 🏦 Projeto Java Santander - API Integration

Projeto Spring Boot para integração com a API do Santander, preparado para rodar em Docker e Kubernetes.

## 🚀 Tecnologias

- **Java 21** (LTS)
- **Spring Boot 3.3.x**
- **Maven 3.9.x**
- **Docker** & **Docker Compose**
- **Kubernetes**

## 📋 Pré-requisitos

- Java 21 JDK
- Maven 3.9+
- Docker (para containers)
- Kubernetes (opcional, para produção)

## 🏃 Como Executar Localmente

### Opção 1: Direto com Maven

```bash
# Compilar e executar
mvn spring-boot:run

# Ou compilar primeiro
mvn clean package
java -jar target/java-santander-1.0.0.jar
```

A aplicação estará disponível em: `http://localhost:8080/api`

### Opção 2: Com Docker

```bash
# Construir a imagem
docker build -t java-santander:latest .

# Executar o container
docker run -p 8080:8080 java-santander:latest
```

### Opção 3: Com Docker Compose

```bash
# Construir e iniciar
docker-compose up --build

# Em background
docker-compose up -d

# Ver logs
docker-compose logs -f app

# Parar
docker-compose down
```

## 🐳 Docker

### Construir Imagem

```bash
docker build -t java-santander:latest .
```

### Executar Container

```bash
docker run -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=docker \
  java-santander:latest
```

### Publicar Imagem

```bash
# Tag para seu registry
docker tag java-santander:latest seu-registry.com/java-santander:latest

# Push
docker push seu-registry.com/java-santander:latest
```

## ☸️ Kubernetes

### Pré-requisitos

- Cluster Kubernetes configurado
- `kubectl` instalado e configurado

### Deploy

```bash
# Aplicar todos os recursos
kubectl apply -f k8s/

# Ou individualmente
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/ingress.yaml
```

### Verificar Status

```bash
# Ver pods
kubectl get pods -l app=java-santander

# Ver serviços
kubectl get services

# Ver logs
kubectl logs -f deployment/java-santander-app

# Descrever deployment
kubectl describe deployment java-santander-app
```

### Atualizar Deployment

```bash
# Atualizar imagem
kubectl set image deployment/java-santander-app \
  java-santander=seu-registry.com/java-santander:v2

# Ou aplicar novamente
kubectl apply -f k8s/deployment.yaml
```

### Remover

```bash
kubectl delete -f k8s/
```

## 📁 Estrutura do Projeto

```
java-santander/
├── src/
│   ├── main/
│   │   ├── java/com/santander/
│   │   │   ├── SantanderApplication.java
│   │   │   ├── controller/
│   │   │   ├── service/
│   │   │   ├── config/
│   │   │   └── dto/
│   │   └── resources/
│   │       └── application.properties
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── configmap.yaml
├── Dockerfile
├── docker-compose.yml
├── pom.xml
└── README.md
```

## 🔧 Configuração

### Variáveis de Ambiente

- `SPRING_PROFILES_ACTIVE`: Perfil ativo (docker, kubernetes, local)
- `JAVA_OPTS`: Opções da JVM
- `SANTANDER_API_BASE_URL`: URL base da API Santander
- `SANTANDER_API_CLIENT_ID`: Client ID da API
- `SANTANDER_API_CLIENT_SECRET`: Client Secret da API

### Application Properties

Configure em `src/main/resources/application.properties`:

```properties
server.port=8080
santander.api.base-url=https://api.santander.com.br
```

## 🧪 Testes

```bash
# Executar todos os testes
mvn test

# Com cobertura
mvn test jacoco:report
```

## 📦 Build

```bash
# Build completo
mvn clean package

# Build sem testes
mvn clean package -DskipTests

# Build otimizado para produção
mvn clean package -Pprod
```

## 🔍 Endpoints

- **Health Check**: `GET /api/actuator/health`
- **Info**: `GET /api/actuator/info`
- **Santander Health**: `GET /api/santander/health`
- **Welcome**: `GET /api/santander/welcome`

## 🚢 CI/CD

### GitHub Actions (exemplo)

```yaml
name: Build and Deploy
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build Docker Image
        run: docker build -t java-santander:latest .
      - name: Deploy to K8s
        run: kubectl apply -f k8s/
```

## 📝 Comandos Úteis

```bash
# Ver logs do container
docker logs -f java-santander-app

# Entrar no container
docker exec -it java-santander-app sh

# Verificar saúde
curl http://localhost:8080/api/actuator/health

# Escalar no K8s
kubectl scale deployment/java-santander-app --replicas=3
```

## 🐛 Troubleshooting

### Container não inicia

```bash
# Ver logs
docker logs java-santander-app

# Verificar se a porta está livre
netstat -ano | findstr :8080
```

### Kubernetes - Pod não sobe

```bash
# Ver eventos
kubectl get events --sort-by='.lastTimestamp'

# Descrever pod
kubectl describe pod <pod-name>

# Ver logs
kubectl logs <pod-name>
```

## 📚 Documentação

- [Spring Boot Docs](https://spring.io/projects/spring-boot)
- [Docker Docs](https://docs.docker.com/)
- [Kubernetes Docs](https://kubernetes.io/docs/)

## 👥 Contribuindo

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é privado e pertence à Santander.

---

**Desenvolvido para integração com API Santander** 🏦
