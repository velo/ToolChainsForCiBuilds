FROM maven:3.8.7-eclipse-temurin-17-focal as build

RUN apt-get update && apt-get install -y ruby openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk

RUN mkdir -p /root/.m2

COPY toolchains.xml /root/.m2/

FROM build as test

RUN mkdir -p /root/test

WORKDIR /root/test

COPY . /root/test

RUN mvn clean install

FROM build as export

# overide maven env, as breaks mvnw command
ENV MAVEN_CONFIG ""
