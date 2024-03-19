from nest_oauth_token import NestOauthToken
from typing import Dict

import requests


class NestThermostat():
    """Class to query the nest Thermostat API."""
    def __init__(self):
        self.request_url = "https://smartdevicemanagement.googleapis.com/v1/enterprises"
        self.__token = NestOauthToken()

    def __get_headers(self) -> Dict[str, str]:
        """Private method to connect to the nest thermostat with the access token
        credential.

        Returns:
            Dict[str, str]: Dictionary containing data for connection.
        """
        self.access_token = self.__token.get_token()

        headers = {
            "Content-Type": "application/json",
            "Authorization": self.access_token
        }

        return headers

    def query(self, query_type: str) -> Dict:
        """Query the Nest Thermostat API.
        
        Args:
            query_type (str) Type of query needed.

        Returns:
            Dict: API response.
        """
        headers = self.__get_headers()
        query_url = self.get_query_url(query_type=query_type)

        response = requests.get(
            url=query_url,
            headers=headers
        )

        return response.json()

    def get_query_url(self, query_type: str) -> str:
        """Generate the path to query the thermostat.

        Args:
            query_type (str): Type of query needed.

        Returns:
            str: Path for the query of the thermostat.
        """
        project_id = self.__token.project_id

        return f"{self.request_url}/{project_id}/{query_type}"
