FROM node:lts-alpine

LABEL maintainer="SuperManito"

ARG JD_BASE_URL=https://github.com/Kkwoai/base123.git

ARG JD_BASE_BRANCH=source

ARG KEY1="-----BEGIN OPENSSH PRIVATE KEY-----
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
J3fLFebcXm92cAAAAJeHhAcXEuY29tAQI=
-----END OPENSSH PRIVATE KEY-----"

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PS1="\u@\h:\w \$ " \
    JD_DIR=/jd \
    ENABLE_HANGUP=true \
    ENABLE_WEB_PANEL=true

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f bash \
    coreutils \
    moreutils \
    git \
    wget \
    curl \
    nano \
    tzdata \
    perl \
    openssl \
    openssh \
    && rm -rf /var/cache/apk/* \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh \
    && cd /root/.ssh \
    && echo -e $KEY > /root/.ssh/id_rsa \
    && chmod 600 /root/.ssh/id_rsa \
    && ssh-keyscan gitee.com > /root/.ssh/known_hosts \
    && git clone -b ${JD_BASE_BRANCH} ${JD_BASE_URL} ${JD_DIR} \
    && cd ${JD_DIR}/panel \
    && npm install \
    && npm install -g pm2 \
    && touch ${JD_DIR}/run_all.sh \
    && ln -sf ${JD_DIR}/run_all.sh /usr/local/bin/run_all \
    && ln -sf ${JD_DIR}/jd.sh /usr/local/bin/jd \
    && ln -sf ${JD_DIR}/git_pull.sh /usr/local/bin/git_pull \
    && ln -sf ${JD_DIR}/rm_log.sh /usr/local/bin/rm_log \
    && ln -sf ${JD_DIR}/export_sharecodes.sh /usr/local/bin/export_sharecodes \
    && cp -f ${JD_DIR}/docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh \
    && chmod 777 /usr/local/bin/docker-entrypoint.sh \
    && rm -rf /root/.npm

WORKDIR ${JD_DIR}

ENTRYPOINT docker-entrypoint.sh
