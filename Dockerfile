FROM maven:3.8.7-amazoncorretto-11 AS build
COPY src /src
COPY pom.xml /
RUN mvn clean deploy -Dmaven.test.skip


FROM openjdk:8
EXPOSE 8080
ADD target/spring-petclinic-2.50.1-Snapshot.jar spring-petclinic-2.50.1-Snapshot.jar
ENTRYPOINT ["java","-jar","/spring-petclinic-2.50.1-Snapshot.jar"]

