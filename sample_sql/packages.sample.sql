CREATE EXTENSION multicorn;

CREATE SERVER cloudsmith_fdw 
FOREIGN DATA WRAPPER multicorn
options (
  wrapper 'cloudsmith_fdw.CloudsmithPackageFDW'
);

CREATE SCHEMA IF NOT EXISTS cloudsmith;

--
-- the complete list of fields is available here
-- https://help.cloudsmith.io/reference/packages_list
--
-- stage, status, sync_progress, downloads, size seem to cause issues with python 3.6 on CentOS 7
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

