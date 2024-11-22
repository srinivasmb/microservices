# Stage 1: Build the application using Maven and Java 17
FROM maven:3.9.5-eclipse-temurin-17 AS build

# Set the working directory in the container
WORKDIR /app

# Install Git to clone the repository
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Clone the repository (replace with your repository URL)
RUN git clone https://github.com/srinivasmb/microservices.git .

# Run Maven build to create the WAR file
RUN mvn clean package -DskipTests -X

# Stage 2: Deploy the WAR file to Tomcat (Java 17 compatible)
FROM tomcat:9.0-jdk17-temurin

# Set the working directory in the container
WORKDIR /usr/local/tomcat/webapps

# Copy the built WAR file from the previous stage
COPY --from=build /app/target/restful-web-services.war ./restful-web-services.war

# Expose Tomcat's port
EXPOSE 8081

# Start Tomcat
CMD ["catalina.sh", "run"]

# Docker build and run commands:
# docker build -t restful-web-services .
# docker run -d -p 8080:8080 restful-web-services

# Application URL:
# http://localhost:8080/restful-web-services

#docker logs <container_id>
#docker exec -it <container_id> bash
#ls /usr/local/tomcat/webapps