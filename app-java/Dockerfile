FROM ubuntu:20.10 as base

RUN apt-get update && \
    apt-get install -y openjdk-15-jdk \
        git \
        less \
        nano && \
    apt-get clean

COPY profile.d/java.sh /etc/profile.d/
ENV JAVA_HOME=/usr

ARG USER_UID
ARG USER_GID
ARG USER

RUN groupadd --gid $USER_GID $USER \
    && useradd --uid $USER_UID --gid $USER_GID -m $USER \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

ENV LANG C

# --------

FROM base as dev

USER $USER

WORKDIR /usr/src/app-java

CMD ["/bin/bash"]

# --------

FROM base as prod

COPY ./app-java/src /usr/src/app-java

WORKDIR /usr/src/app-java

RUN javac AppJava.java

CMD ["java", "AppJava"]