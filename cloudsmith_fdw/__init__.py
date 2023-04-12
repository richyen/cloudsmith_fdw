from multicorn import ForeignDataWrapper
from multicorn.utils import log_to_postgres
import requests
import json


class CloudsmithFDW(ForeignDataWrapper):
    def __init__(self,options,columns):
        super(CloudsmithFDW,self).__init__(options,columns)
        self.key=options.get('key',None)
        self.owner=options.get('owner','enterprisedb')
        self.repo=options.get('repo','dev')
        self.columns=columns

        self.page_size =  30

    def fetch(self):
        headers = {
          "accept": "application/json",
          "X-Api-Key": self.key
        }

        response = requests.get(self.url, headers=headers)

        return json.loads(response.text)

    def execute(self, quals, columns):
        for item in self.fetch():
            output = {}
            for column_name in self.columns:
                output[column_name] = item[column_name]
            yield output

class CloudsmithPackageFDW(CloudsmithFDW):
    def __init__(self,options,columns):
        super(CloudsmithPackageFDW,self).__init__(options,columns)
        self.url = f"https://api.cloudsmith.io/v1/packages/{self.owner}/{self.repo}/?sort=-date"

class CloudsmithRepoFDW(CloudsmithFDW):
    def __init__(self,options,columns):
        super(CloudsmithRepoFDW,self).__init__(options,columns)
        self.url = f"https://api.cloudsmith.io/v1/repos"
