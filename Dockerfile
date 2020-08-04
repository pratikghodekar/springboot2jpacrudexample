FROM maven:3.6-openjdk-8 as build

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD . /usr/src/app/

# generate build
RUN mvn package -DskipTests

# base image
FROM openjdk:8-jdk

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# copy artifact build from the 'build environment'
COPY --from=build /usr/src/app/target/springboot2-jpa-crud-example-0.0.1-SNAPSHOT.jar /usr/src/app

# expose port 80
EXPOSE 8080

# run nginx
CMD ["java", "-jar", "springboot2-jpa-crud-example-0.0.1-SNAPSHOT.jar"]
