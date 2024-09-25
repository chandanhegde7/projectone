# Use a base image with Java 17 (or your version)
FROM openjdk:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the target folder into the container
COPY target/projectone-0.0.1-SNAPSHOT.jar /app/projectone.jar

# Expose port 8080 (or your application port)
EXPOSE 8085

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/projectone.jar"]
