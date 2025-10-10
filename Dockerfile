# Stage 1: Build the application using Maven with Java 21
FROM maven:3-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the final, smaller image with Java 21
FROM amazoncorretto:21-alpine-jdk
WORKDIR /app
# Salin JAR yang sudah di-build dari stage sebelumnya
COPY --from=builder /app/target/*.jar app.jar
# Port yang akan diekspos oleh container
EXPOSE 8080
# Perintah untuk menjalankan aplikasi saat container dimulai
ENTRYPOINT ["java", "-jar", "app.jar"]
