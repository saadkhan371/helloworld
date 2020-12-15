FROM openjdk:8-jdk-alpine
LABEL Saad Khan <saadkhan371@gmail.com>
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
