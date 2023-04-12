CREATE EXTENSION multicorn;

CREATE SERVER cloudsmith_repo_fdw 
FOREIGN DATA WRAPPER multicorn
options (
  wrapper 'cloudsmith_fdw.CloudsmithRepoFDW'
);

CREATE SCHEMA IF NOT EXISTS cloudsmith;

--
-- the complete list of fields is available here
-- https://help.cloudsmith.io/reference/packages_list
--
CREATE FOREIGN TABLE cloudsmith.repos (
        created_at TEXT,
        cdn_url TEXT,
        package_count TEXT,
        package_group_count TEXT,
        "size" TEXT,
        size_str TEXT,
        storage_region TEXT,
        view_statistics TEXT,
        is_public TEXT,
        repository_type_str TEXT,
        self_url TEXT
) server cloudsmith_repo_fdw options (
   key 'your_secret_api_key'
);

