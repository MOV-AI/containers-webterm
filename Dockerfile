#=== PROD RUNTIME Image
FROM registry.cloud.mov.ai/devops/movai-base-focal:v1.0.1

WORKDIR /usr/src/app
ENV NODE_ENV=production

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y --no-install-recommends gpg-agent nodejs build-essential && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    curl -fsSL https://artifacts.cloud.mov.ai/repository/movai-applications/gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    add-apt-repository "deb https://artifacts.cloud.mov.ai/repository/ppa-main main main" && \
    apt-get update && \
    apt-get install -y --no-install-recommends yarn movai-cli && \
    echo 'movai:M0va1' | chpasswd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN yarn global add wetty

EXPOSE 3000
ENTRYPOINT ["wetty", "-p", "3000",\
            "--base", "/terminal",\
            "--ssh-host", "127.0.0.1" ,\
            "--ssh-user", "movai" ,\
            "--ssh-pass", "M0va1" ,\
            "--title", "MOVAI CLI",\
            "-c", "cat /opt/mov.ai/.welcome;movai-shell"]
