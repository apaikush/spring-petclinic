FROM maven:3.6.0-jdk-11 AS build
COPY src /src
COPY pom.xml /
RUN export MAVEN_OPTS='-Xmx1024m -XX:MaxPermSize=1024m'
RUN mvn clean deploy -Dmaven.test.skip


FROM openjdk:8
EXPOSE 8080
ADD target/spring-petclinic-2.50.1-Snapshot.jar spring-petclinic-2.50.1-Snapshot.jar
ENTRYPOINT ["java","-jar","/spring-petclinic-2.50.1-Snapshot.jar"]

