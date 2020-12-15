FROM openjdk:8-jdk-alpine
LABEL Saad Khan <saadkhan371@gmail.com>
EXPOSE 8090
#ARG JAR_FILE=target/my-application.jar
#ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
