# stage 1
FROM openjdk:17-jdk-slim AS build

ARG arch=x86_64

RUN apt-get -y update; apt-get -y install curl

RUN mkdir -p /tmp/smithy && \
  curl -L https://github.com/smithy-lang/smithy/releases/download/1.41.1/smithy-cli-linux-$arch.tar.gz -o /tmp/smithy-cli-linux-$arch.tar.gz && \
  tar xvzf /tmp/smithy-cli-linux-$arch.tar.gz -C /tmp/smithy

ADD . /tmp

RUN /tmp/smithy/install

RUN cd /tmp/rust && ./gradlew publishToMavenLocal

RUN cd /tmp/python/codegen && ./gradlew publishToMavenLocal

RUN cd /tmp/swift && ./gradlew publishToMavenLocal

RUN cd /tmp/typescript && ./gradlew publishToMavenLocal

RUN cd /tmp && smithy build

# stage 2

FROM openjdk:17-jdk-slim

COPY --from=build /root/.m2 /root/.m2

COPY --from=build /tmp/smithy /tmp/smithy

RUN /tmp/smithy/install

COPY --from=build /tmp/smithy-build.json /root/smithy-build.json
COPY --from=build /tmp/model /root/model
