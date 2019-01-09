FROM gradle:4.9-jdk8-alpine as build

COPY build.gradle /src/build.gradle

WORKDIR /src

COPY src/ /src/src

USER root
RUN gradle shadowJar

FROM base2/awsenv as awsenv

FROM openjdk:8-jre

COPY --from=build /src/build/libs/src-1.0-SNAPSHOT-all.jar /opt/demo.jar
COPY --from=awsenv /awsenv /bin/awsenv

COPY docker-entrypoint.sh /

EXPOSE 7000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-jar","/opt/demo.jar"]
