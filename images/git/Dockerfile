FROM alpine/git

# Cria um container especial
COPY clone /usr/local/bin/clone
COPY entrypoint /usr/local/bin/entrypoint
COPY ssh.conf /etc/ssh/ssh_config.d/bypass.conf
RUN ln -s /usr/local/bin/entrypoint /entrypoint


ENTRYPOINT ["/entrypoint"]

ENV GIT_REPOSITORY="git@github.com:nightarcherbr/cake.git"
ENV GIT_TIMEOUT=120
ENV GIT_TARGET="/var/www/cake"
ENV SSH_KEYFILE=""

CMD ["run"]
