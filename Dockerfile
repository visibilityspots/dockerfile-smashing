FROM ruby:3.3.12-alpine3.24

ARG SMASHING_VERSION=1.3.6

# apk upgrade and the resolv/net-imap gems: the ruby image ships versions with
# known CVEs; the old net-imap is a bundled gem and is removed so it is not loadable
RUN apk upgrade --no-cache && \
    apk add --no-cache build-base openssl-dev tzdata nodejs && \
    gem update --system && \
    gem install bundler resolv net-imap && \
    gem uninstall -i "$(ruby -e 'print Gem.default_dir')" net-imap -v "< 0.5" --force && \
    gem install smashing -v $SMASHING_VERSION

RUN mkdir /smashing && \
    smashing new smashing && \
    cd /smashing && \
    sed -i "s/smashing.*/&, \"${SMASHING_VERSION}\"/g" Gemfile && \
    printf '\ngem "resolv", ">= 0.3.2"\n' >> Gemfile && \
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
