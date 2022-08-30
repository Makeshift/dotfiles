FROM ubuntu:latest

RUN apt-get update && apt-get install --no-install-recommends -y \
  git \
  ca-certificates \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply Makeshift
