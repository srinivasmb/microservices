# For Java 11 and the latest Node.js LTS
# FROM timbru31/java-node:11-lts 
# Stage 1: Build the application using Maven
FROM maven:3.8.8-eclipse-temurin-11 AS build

# Set the working directory in the container
WORKDIR /app

# Install Git to clone the repository
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Clone the repository (replace with your repository URL)
RUN git clone https://github.com/srinivasmb/microservices.git .

# Run Maven build to create the WAR file
# For Java 11 and the latest Node.js LTS
# FROM timbru31/java-node:11-lts 
# Stage 1: Build the application using Maven
FROM maven:3.8.8-eclipse-temurin-11 AS build

# Set the working directory in the container
WORKDIR /app

# Install Git to clone the repository
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Clone the repository (replace with your repository URL)
RUN git clone https://github.com/srinivasmb/microservices.git .

# Run Maven build to create the WAR file
RUN mvn clean package -DskipTests -X

# Stage 2: Deploy the WAR file to Tomcat
FROM tomcat:9.0-jdk11-openjdk

# Set the working directory in the container
WORKDIR /usr/local/tomcat/webapps

# Copy the built WAR file from the previous stage
COPY --from=build /app/target/restful-web-services.war ./restful-web-services.war

# Expose Tomcat's port
EXPOSE 8081

# Start Tomcat
CMD ["catalina.sh", "run"]

# docker build -t restful-web-services .

# docker run -d -p 8080:8080 restful-web-services

# http://localhost:8080/app



# Stage 2: Deploy the WAR file to Tomcat
FROM tomcat:9.0-jdk11-openjdk

# Set the working directory in the container
WORKDIR /usr/local/tomcat/webapps

# Copy the built WAR file from the previous stage
COPY --from=build /app/target/restful-web-services.war ./restful-web-services.war

# Expose Tomcat's port
EXPOSE 8081

# Start Tomcat
CMD ["catalina.sh", "run"]

# docker build -t restful-web-services .

# docker run -d -p 8080:8080 restful-web-services

# http://localhost:8080/app

