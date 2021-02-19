# Pull the centos image from DockerHub repository to build our application as a base
# The centos image will act as a base image
#FROM centos
FROM maven:3.6-jdk-11
LABEL Saad Khan <saadkhan371@gmail.com>

WORKDIR /app

#copy pom
COPY pom.xml .

# Installing java to our image
#RUN yum install -y java
RUN mvn clean package -Dmaven.test.skip -Dmaven.main.skip -Dspring-boot.repackage.skip && rm -r target/
#RUN mvn package -DskipTests -X

#copy source
COPY src ./src

# build the app (no dependency download here)
RUN mvn clean package  -Dmaven.test.skip

# Creating a temporary directory
VOLUME /tmp

EXPOSE 8090

ARG JAR_NAME="devtools-demo"

# Steps to run the spring boot application
# Copy the application’s jar from target directory and name it

COPY target/devtools-demo*.jar /app.jar


##ADD ./app/target/{JAR_NAME}.jar myapp.jar
CMD ["java","-jar", "./app.jar"]
#RUN sh -c 'touch /myapp.jar'
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/myapp.jar"]
