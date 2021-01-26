# Pull the centos image from DockerHub repository to build our application as a base
# The centos image will act as a base image
#FROM centos
#LABEL Saad Khan <saadkhan371@gmail.com>
# Installing java to our image
#RUN yum install -y java
# Creating a temporary directory
#VOLUME /tmp
# Steps to run the spring boot application
# Copy the application’s jar from target directory and name it
#ADD ./target/devtools-demo-0.0.1.jar myapp.jar
#RUN sh -c 'touch /myapp.jar'
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/myapp.jar"]



FROM openjdk:8-jdk

ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
ARG SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml /usr/share/maven/ref/

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]


# Installing java to our image
#RUN yum install -y java
RUN git pull origin main
RUN mvn package -DskipTests -X
# Creating a temporary directory
VOLUME /tmp
# Steps to run the spring boot application
# Copy the application’s jar from target directory and name it
ADD ./target/devtools-demo-0.0.1.jar myapp.jar
RUN sh -c 'touch /myapp.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/myapp.jar"]