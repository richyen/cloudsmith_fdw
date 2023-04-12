FROM ubuntu:18.04

ENV PGDATA="/etc/postgresql/13/main"
ENV DEBIAN_FRONTEND=noninteractive

# Install Postgres and Python
RUN apt -y update  && \
    apt -y install curl git vim wget gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates python-dev python3-dev python3-pip && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt -y update  && \
    apt -y upgrade  && \
    apt -y install postgresql-13 postgresql-client-13 postgresql-server-dev-13 build-essential && \
    pip3 install requests && \
    sed -i -e "s/peer/trust/" ${PGDATA}/pg_hba.conf && \
    sed -i -e "s/.*::1/###/" ${PGDATA}/pg_hba.conf && \
    service postgresql restart

# Install Multicorn
RUN git clone https://github.com/Segfault-Inc/Multicorn.git && \
    cd Multicorn && make && make install
