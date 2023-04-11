# cloudsmith_fdw
A PostgreSQL Foreign Data Wrapper for [cloudsmith](https://cloudsmith.io/)

## INSTALL
Assuming you're using ubuntu and the apt.postgresql.org repositories:

```
sudo apt install python3-multicorn python3-setuptools
git clone  https://github.com/richyen/cloudsmith_fdw
cd cloudsmith_fdw
sudo python3 setup.py install
sudo service postgresql restart
```

## USE

```sql
CREATE SCHEMA cloudsmith;
CREATE EXTENSION multicorn;

CREATE SERVER cloudsmith_fdw
FOREIGN DATA WRAPPER multicorn
options (
  wrapper 'cloudsmith_fdw.cloudsmithFDW'
);


CREATE FOREIGN TABLE cloudsmith.packages (
        self_url TEXT,
        stage TEXT,
        status TEXT,
        sync_progress TEXT,
        downloads TEXT,
        extension TEXT,
        filename TEXT,
        "size" TEXT,
        repository TEXT,
        summary TEXT,
        version TEXT,
) server cloudsmith_fdw options (
   key 'your_secret_api_key'
);

SELECT * from cloudsmith.packages;
```
