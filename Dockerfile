# ============================================
# Dockerfile - Instruções para criar imagem Docker
# ============================================
# Similar ao Dockerfile do Node.js, mas para Java

# ============================================
# ETAPA 1: BUILD (Compilar o projeto)
# ============================================
# Usa uma imagem com Maven para compilar
FROM maven:3.9-eclipse-temurin-21 AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo pom.xml primeiro (para cache de dependências)
# Se o pom.xml não mudar, o Docker reutiliza a camada cacheada
COPY pom.xml .

# Baixa as dependências (cache se pom.xml não mudou)
RUN mvn dependency:go-offline -B

# Copia o código fonte
COPY src ./src

# Compila o projeto e cria o JAR
RUN mvn clean package -DskipTests

# ============================================
# ETAPA 2: RUNTIME (Executar a aplicação)
# ============================================
# Usa uma imagem menor, só com Java (sem Maven)
FROM eclipse-temurin:21-jre-alpine

# Cria um usuário não-root (segurança)
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Define o diretório de trabalho
WORKDIR /app

# Copia o JAR compilado da etapa de build
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta 8080 (porta padrão do Spring Boot)
EXPOSE 8080

# Define variáveis de ambiente
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Comando para executar a aplicação
# java -jar app.jar inicia o Spring Boot
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]

# ============================================
# EXPLICAÇÃO DAS ETAPAS:
# ============================================
# 
# 1. Multi-stage build:
#    - Etapa 1 (build): Compila com Maven (imagem grande)
#    - Etapa 2 (runtime): Só copia o JAR (imagem pequena)
#    - Resultado: Imagem final menor e mais rápida
#
# 2. Cache de dependências:
#    - Copia pom.xml primeiro
#    - Baixa dependências
#    - Se pom.xml não mudar, reutiliza cache
#
# 3. Segurança:
#    - Usa usuário não-root
#    - Imagem Alpine (menor, mais segura)
#
# 4. Porta:
#    - 8080 é a porta padrão do Spring Boot
#    - Pode mudar com variável de ambiente
