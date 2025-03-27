# syntax=docker/dockerfile:1

FROM maven:3.9.9-amazoncorretto-17-debian as package
ENV JAVA_TOOL_OPTIONS -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8008
RUN apt-get update && apt-get install git -y
WORKDIR /build
RUN git clone https://github.com/felipe-guerra-oliveira/simple-springboot-api.git .
RUN mvn clean package -DskipTests
RUN mkdir /app && cp -R ./target/simple-springboot-api-0.0.1-SNAPSHOT.jar /app
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser
WORKDIR /app
EXPOSE 8000
ENTRYPOINT [ "java", "-jar", "simple-springboot-api-0.0.1-SNAPSHOT.jar"]