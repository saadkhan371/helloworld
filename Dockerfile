# Pull the centos image from DockerHub repository to build our application as a base
# The centos image will act as a base image
#FROM centos
FROM maven:3.6-jdk-11
LABEL Saad Khan <saadkhan371@gmail.com>


#RUN rm -rf target/


WORKDIR /app

#copy pom
COPY pom.xml .


#RUN mvn package -Dmaven.test.skip -Dmaven.main.skip -Dspring-boot.repackage.skip
VOLUME /tmp
EXPOSE 8090
ARG JAR_NAME="devtools-demo"
ADD ./target/devtools*.jar /app.jar
CMD ["java","-jar", "/app.jar"]
