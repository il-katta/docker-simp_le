FROM debian:jessie

RUN apt-get -qq update \
    && apt-get -qq -y --no-install-recommends install \
        ca-certificates \
        gcc \
        libssl-dev \
        libffi-dev \
        python \
        python-requests \
        python-urllib3 \
        python-dev \
        python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip \
    && pip install -U wheel \
    && pip install -U setuptools \
    && pip install -U PyOpenSSL

RUN apt-get -qq update \
    && apt-get -qq install --no-install-recommends -y \
        webfs \
        curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/simp_le \
    && curl -sL https://codeload.github.com/kuba/simp_le/tar.gz/master \
    | tar xz -C /usr/src/simp_le --strip-components=1

RUN pip install -e /usr/src/simp_le

RUN apt-get -y -q --purge remove \
        python-dev \
        gcc \
        python-pip \
        python-setuptools \
    && apt-get clean \
    && apt-get -q --purge -y autoremove

ADD run.sh /entrypoint
RUN chmod +x /entrypoint && mkdir -p /certs

WORKDIR /certs
VOLUME ["/certs"]

ENTRYPOINT ["/entrypoint"]

CMD ["--help"]
