ARG ALPINE_VERSION=3.17.2
ARG TERRAFORM_VERSION=1.4.5
ARG CHAMBER_VERSION=v2.12.0
ARG TFENV_VERSION=0.4.0

FROM --platform=$BUILDPLATFORM alpine:$ALPINE_VERSION AS build

ARG TARGETOS
ARG TARGETARCH
ARG TERRAFORM_VERSION
ARG CHAMBER_VERSION
ARG TFENV_VERSION

RUN apk add --no-cache git curl openssh && \
    curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${TARGETOS}_${TARGETARCH}.zip && \
    unzip terraform_${TERRAFORM_VERSION}_${TARGETOS}_${TARGETARCH}.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_${TARGETOS}_${TARGETARCH}.zip && \
    curl -o /bin/chamber https://github.com/segmentio/chamber/releases/download/${CHAMBER_VERSION}/chamber-${CHAMBER_VERSION}-${TARGETOS}-${TARGETARCH} && \
    if [[ "${TARGETARCH}" = "arm64" ]]; then TARGETARCH=arm ; fi && \
    curl -o /bin/tfenv https://github.com/cloudposse/tfenv/releases/download/${TFENV_VERSION}/tfenv_${TARGETOS}_${TARGETARCH}


FROM --platform=$BUILDPLATFORM alpine:$ALPINE_VERSION as final
LABEL maintainer="Andrey Klyukin"

ARG TERRAFORM_VERSION
ARG CHAMBER_VERSION
ARG TFENV_VERSION

LABEL "com.hashicorp.terraform.version"="${TERRAFORM_VERSION}"
LABEL "com.cloudposse.chamber.version"="${CHAMBER_VERSION}"
LABEL "com.cloudposse.tfenv.version"="${TFENV_VERSION}"

RUN apk add --no-cache bash git openssh aws-cli

COPY --from=build ["/bin/terraform", "/bin/terraform"]
COPY --from=build ["/bin/chamber", "/bin/chamber"]
COPY --from=build ["/bin/tfenv", "/bin/tfenv"]

COPY commands.sh /usr/local/commands.sh
COPY entrypoints/ /entrypoints/
