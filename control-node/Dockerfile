FROM alpine:3.15

RUN apk --update add \
  ansible \
  bash \
  git \
  py3-pip \
  util-linux

RUN pip3 install \
  netaddr \
  ansible-lint[core,yamllint]

ARG BUILD_UID=2001
ARG BUILD_GID=2001

RUN addgroup -g $BUILD_GID ansible \
  && adduser -D -s /bin/false -u $BUILD_UID -G ansible ansible \
  && mkdir /ansible \
  && mkdir /ansible-cache \
  && chmod u+rwX,g=,o= /home/ansible /ansible /ansible-cache \
  && chown -R ansible:ansible /home/ansible /ansible /ansible-cache

COPY requirements.yml /
RUN ansible-galaxy install \
  --roles-path /etc/ansible/roles \
  --role-file requirements.yml

COPY ansible.cfg /etc/ansible/
COPY entrypoint.sh /

VOLUME /ansible
VOLUME /ansible-cache

USER $BUILD_UID:$BUILD_GID

WORKDIR /ansible
ENTRYPOINT ["/entrypoint.sh"]
