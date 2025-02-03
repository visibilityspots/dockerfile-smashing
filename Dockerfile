FROM ruby:3.3.7-alpine3.21

ARG SMASHING_VERSION=1.3.6

RUN apk add --no-cache build-base openssl-dev tzdata nodejs && \
    gem update --system && \
    gem install bundler && \
    gem install smashing -v $SMASHING_VERSION

RUN mkdir /smashing && \
    smashing new smashing && \
    cd /smashing && \
    sed -i "s/smashing.*/&, \"${SMASHING_VERSION}\"/g" Gemfile && \
    bundle && \
    ln -s /smashing/dashboards /dashboards && \
    ln -s /smashing/jobs /jobs && \
    ln -s /smashing/assets /assets && \
    ln -s /smashing/lib /lib-smashing && \
    ln -s /smashing/public /public && \
    ln -s /smashing/widgets /widgets && \
    mkdir /smashing/config && \
    mv /smashing/config.ru /smashing/config/config.ru && \
    ln -s /smashing/config/config.ru /smashing/config.ru && \
    ln -s /smashing/config /config

COPY run.sh /

VOLUME ["/dashboards", "/jobs", "/lib-smashing", "/config", "/public", "/widgets", "/assets"]

ENV PORT 3030
EXPOSE $PORT
WORKDIR /smashing

CMD ["/run.sh"]
