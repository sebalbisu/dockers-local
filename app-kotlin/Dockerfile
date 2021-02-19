FROM zenika/kotlin:1.4.20-jdk11 as base

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

RUN apt-get update && \
    apt-get install -y \
        git \
        less \
        nano && \
    apt-get update 

# --------

FROM base as dev

ARG USER_UID
ARG USER_GID
ARG USER

USER $USER

WORKDIR /kotlin/src/app-kotlin

# change root folder to user
RUN sudo chown $USER:$USER .
