FROM maven:3.6-jdk-11 as maven_build
WORKDIR .

#copy pom
COPY pom.xml .

#resolve maven dependencies
RUN mvn clean package -Dmaven.test.skip -Dmaven.main.skip -Dspring-boot.repackage.skip && rm -r target/

#copy source
COPY src ./src

# build the app (no dependency download here)
RUN mvn clean deploy  -Dmaven.test.skip


FROM openjdk:8
EXPOSE 8080
ADD target/spring-petclinic-2.50.1-Snapshot.jar spring-petclinic-2.50.1-Snapshot.jar
ENTRYPOINT ["java","-jar","/spring-petclinic-2.50.1-Snapshot.jar"]

