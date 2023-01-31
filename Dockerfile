FROM maven:3.6-jdk-11 as maven_build
WORKDIR .

#copy pom
COPY pom.xml .

#copy source
COPY src ./src

# build the app (no dependency download here)
# build the app and download dependencies only when these are new (thanks to the cache)
RUN --mount=type=cache,target=/root/.m2  mvn clean package -Dmaven.test.skip


FROM openjdk:8
EXPOSE 8080
ADD target/spring-petclinic-2.50.1-Snapshot.jar spring-petclinic-2.50.1-Snapshot.jar
ENTRYPOINT ["java","-jar","/spring-petclinic-2.50.1-Snapshot.jar"]

