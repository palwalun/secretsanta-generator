FROM maven:3.9.12-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY /src ./src
RUN mvn clean package -DskipTests

#============================================

FROM eclipse-temurin:17.0.17_10-jre-alpine
WORKDIR /app
COPY --from=build /target/*.jar app.jar
EXPOSE 9999
ENTRYPOINT ["java", "-jar", "app.jar"]
