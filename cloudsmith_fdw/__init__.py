"""

"""

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

        self.page_size =  100

        self.columns=columns

    def fetch(self) :
        url = f"https://api.cloudsmith.io/v1/packages/{self.owner}/{self.repo}/?sort=-date"

        headers = {
          "accept": "application/json",
          "X-Api-Key": self.key
        }

        response = requests.get(url, headers=headers)

        return json.loads(response.text)

    def execute(self, quals, columns):
        for item in self.fetch():
            output = {}
            for column_name in self.columns:
                output[column_name] = item[column_name]
            yield output
