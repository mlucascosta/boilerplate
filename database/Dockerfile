FROM mariadb:latest

ENV PACKAGES openssh-server openssh-client vim

RUN apt-get update && apt-get install -y $PACKAGES

RUN sed -i 's|^#PermitRootLogin.*|PermitRootLogin yes|g' /etc/ssh/sshd_config

EXPOSE 3306

CMD ["mysqld"]
