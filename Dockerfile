FROM eclipse-temurin:17.0.17_10-jre-alpine
WORKDIR /app
COPY  /target/*.jar app.jar
EXPOSE 9999
ENTRYPOINT ["java", "-jar", "app.jar"]
