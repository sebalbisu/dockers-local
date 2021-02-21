FROM golang:1.15.6-buster as base

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

ENV LANG C

RUN apt-get update && \
    apt-get install -y \
        git \
        less \
        nano && \
    apt-get update 

# --------

FROM base as dev

ARG USER_UID=1001
ARG USER_GID=1002
ARG USER=docky
ARG USER_GROUP=itcode

USER $USER

WORKDIR /go/src/app-go

ENV GO_ENV=development

# change root folder to user
RUN sudo chown $USER:$USER_GROUP .

# to enable versions in go get
RUN go mod init appgo

# vscode go tools
RUN go get -u -v github.com/go-delve/delve/cmd/dlv
RUN go get -u github.com/766b/go-outliner
RUN go get -u -v golang.org/x/tools/cmd/goimports
RUN go get -v golang.org/x/tools/gopls@latest

# download packages
COPY --chown=$USER:$USER_GROUP ./src/go.mod ./src/go.sum ./

RUN go mod download

# COPY --chown=$USER:$USER ./src/ .

# --------

# FROM base as prod

# ARG USER_UID=1001
# ARG USER_GID=1002
# ARG USER=docky
# ARG USER_GROUP=itcode

# USER $USER

# WORKDIR /go/src/app-go

# # change root folder to user
# RUN sudo chown $USER:$USER .

# # to enable versions in go get
# RUN go mod init appgo

# # download packages
# COPY --chown=$USER:$USER ./src/go.mod ./src/go.sum ./

# RUN go mod download

# COPY --chown=$USER:$USER ./src/ .

# RUN go install 

# # ----------

# FROM prod as compiled

# WORKDIR /go/src/app-go

# RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go install

# RUN sudo chmod a+x /go/bin/appgo

# RUN sudo chown root:root /go/bin/appgo

# # ----------

# FROM scratch as final

# COPY --from=compiled /go/bin/appgo /appgo

# CMD [ "appgo" ]