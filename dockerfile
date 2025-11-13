FROM gradle:8.4.0-jdk17 AS builder
WORKDIR /app
COPY . /app
WORKDIR /app/server
RUN gradle shadowJar

FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=builder /app/server/build/libs/Suwayomi-Server-all.jar /app/Suwayomi-Server.jar
COPY config.json /app/config.json
CMD ["java", "-jar", "Suwayomi-Server.jar", "--config", "config.json"]
