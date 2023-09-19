FROM ubuntu:mantic as build

RUN apt-get update && apt-get install -y gnupg openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk openjdk-21-jdk && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.m2

COPY toolchains.xml /root/.m2/

FROM build as test

RUN mkdir -p /root/test

WORKDIR /root/test

COPY . /root/test

RUN ./mvnw clean install

FROM build as export

# overide maven env, as breaks mvnw command
ENV MAVEN_CONFIG ""
