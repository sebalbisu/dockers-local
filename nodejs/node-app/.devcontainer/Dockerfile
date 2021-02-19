FROM node:5.9.0-stretch as base

ARG USER_UID=1001
ARG USER_GID=1002
ARG USER=docky
ARG USER_GROUP=itcode

RUN groupadd --gid $USER_GID $USER_GROUP \
    && useradd --uid $USER_UID --gid $USER_GID -m $USER \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

RUN apt-get update && \
    apt-get install -y \
        git \
        less \
        zip \
        curl \
        libcurl4-openssl-dev \
        nano && \
    apt-get update 


# --------------

FROM base as dev

ARG USER_UID=1001
ARG USER_GID=1002
ARG USER=docky
ARG USER_GROUP=itcode

USER $USER

WORKDIR /app