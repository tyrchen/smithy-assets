FROM 8.4.0-jdk17-alpine

RUN mkdir -p /tmp/smithy && \
  curl -L https://github.com/smithy-lang/smithy/releases/download/1.41.1/smithy-cli-linux-x86_64.tar.gz -o /tmp/smithy-cli-linux-x86_64.tar.gz && \
  tar xvzf /tmp/smithy-cli-linux-x86_64.tar.gz -C /tmp/smithy

RUN sudo /tmp/smithy/install && rm -rf /tmp/smithy

ADD . /tmp

RUN /tmp/rust/gradlew publishToMavenLocal
RUN /tmp/python/gradlew publishToMavenLocal
RUN /tmp/swift/gradlew publishToMavenLocal
RUN /tmp/typescript/gradlew publishToMavenLocal

RUN rm -rf /tmp/*
