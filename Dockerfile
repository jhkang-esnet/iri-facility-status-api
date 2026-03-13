## Build time configuraton
FROM maven:3.8-eclipse-temurin-21-alpine AS MAVEN_BUILD
LABEL maintainer="John MacAuley <macauley@es.net>"

ENV HOME=/iri
WORKDIR $HOME

COPY . .
RUN mvn -f pom.xml clean package

FROM eclipse-temurin:21-jre

WORKDIR /
COPY --from=MAVEN_BUILD /iri/target/*.jar /app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
