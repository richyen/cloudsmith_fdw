# cloudsmith_fdw
A PostgreSQL Foreign Data Wrapper for [cloudsmith](https://cloudsmith.io/)

## INSTALL
```
## Install multicorn in accordance with docs before perfoming the below:
git clone https://github.com/richyen/cloudsmith_fdw
cd cloudsmith_fdw
sudo python3 setup.py install
```

## USE

```sql
CREATE EXTENSION multicorn;
CREATE SCHEMA cloudsmith;

CREATE SERVER cloudsmith_fdw
FOREIGN DATA WRAPPER multicorn
options (
  wrapper 'cloudsmith_fdw.CloudsmithPackageFDW'
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
        version TEXT
) server cloudsmith_fdw options (
   key 'your_secret_api_key'
);

SELECT * FROM cloudsmith.packages;
```
