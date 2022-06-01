FROM adoptopenjdk/openjdk11:alpine-slim as build

COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .
COPY src src

RUN ./mvnw package -DskipTests

FROM adoptopenjdk/openjdk11:alpine-jre
COPY --from=build target/helloworld-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]