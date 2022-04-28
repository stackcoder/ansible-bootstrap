FROM debian:bullseye

RUN apt-get update && apt-get install -y \
  openssh-server \
  sudo \
  python3

RUN set -eufx \
  && mkdir -p -m0755 /run/sshd \
  && sed -E 's/^AcceptEnv.+/#&/' -i /etc/ssh/sshd_config \
  && sed -E 's/^#?UseDNS.+/UseDNS no/' -i /etc/ssh/sshd_config \
  && adduser --disabled-login --disabled-password --gecos "" ansible \
  && echo "ansible    ALL= NOPASSWD: ALL" > /etc/sudoers.d/ansible \
  && echo 'ansible:ansible' | chpasswd

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]
