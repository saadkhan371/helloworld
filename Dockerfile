FROM openjdk:8-jdk-alpine
LABEL Saad Khan <saadkhan371@gmail.com>
# copy the packaged jar file into our docker image
COPY target/*.jar /demo.jar 
# set the startup command to execute the jar
CMD ["java", "-jar", "/demo.jar"]
EXPOSE 8090
