FROM ubuntu:18.04

ENV PGDATA="/etc/postgresql/13/main"

RUN apt -y update && \
    apt -y install curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc| gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    apt -y update && \
    apt -y upgrade && \
    apt install postgresql-13 postgresql-client-13 python3-multicorn python3-setuptools && \
    easy_install3 pip

COPY . /cloudsmith_fdw
RUN cd /cloudsmith_fdw && \
    python3 setup.py install && \
    sed -i -e "s/peer/trust/" ${PGDATA}/pg_hba.conf && \
    service postgresql-13 restart
