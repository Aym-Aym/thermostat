import time
import json
import requests

from typing import Tuple, Dict


class NestOauthToken():
    """The OauthToken class is responsible to create, get and keep the access token up to
    date.
    """
    def __init__(self) -> None:
        self.token_url = "https://www.googleapis.com/oauth2/v4/token"

        config_datas = self.__get_json_datas("config.json")

        self.project_id = config_datas["project_id"]
        self.__client_id = config_datas["client_id"]
        self.__client_secret = config_datas["client_secret"]
        self.__redirect_uri = config_datas["redirect_uri"]
        self.__refresh_token = config_datas["refresh_token"]

    def __get_json_datas(self, json_file_path: str) -> Dict:
        """Private method to get the datas from the json file.

        Args:
            json_file_path (str): Path to the json config file.

        Returns:
            Dict: Dictionary of the json datas.
        """
        with open(json_file_path) as json_file:
            json_datas = json.load(json_file)

        return json_datas

    def __get_timestamp(self) -> int:
        """Private method to get the current access token creation timestamp.

        Returns:
            int: Access token creation timestamp.
        """
        token_data = self.__get_json_datas("access_token.json")

        return token_data["token_creation_timestamp"]

    def __refresh(self) -> str:
        """Private method to refresh the current access token if it has expired.
        Private method.

        Returns:
            str: Access token.
        """

        if not self.is_valid():
            params = (
                ("client_id", self.__client_id),
                ("client_secret", self.__client_secret),
                ("refresh_token", self.__refresh_token),
                ("grant_type", "refresh_token"),
            )

            response = requests.post(
                self.token_url,
                params=params
            )

            response_json = response.json()
            token_type = response_json["token_type"]
            access_token = response_json["access_token"]
            access_token = f"{token_type} {access_token}"

            return access_token
        return

    def __save_json_datas(self, json_file_path: str, datas: Dict) -> None:
        """Private method to save the access token in the access_token.json file.

        Args:
            json_file_path (str): Path to the json config file.
            json_datas (Dict): .
        """
        json_datas = json.dumps(datas, indent=4)

        with open(json_file_path, "w") as json_file:
            json_file.write(json_datas)

    def get_token(self) -> str:
        """Get the current access token.

        Returns:
            str: Access token.
        """
        if not self.is_valid():
            self.update()

        token_data = self.__get_json_datas("access_token.json")

        return token_data["access_token"]

    def create(self, code: str) -> Tuple[str]:
        """Create a new access token.
        Needed if the refresh token has expired.

        Args:
            code (str): code from the login url page.

        Returns:
            Tuple[str]: (Access token, Refresh token).
        """
        params = (
            ("client_id", self.__client_id),
            ("client_secret", self.__client_secret),
            ("code", code),
            ("grant_type", "authorization_code"),
            ("redirect_uri", self.__redirect_uri),
        )

        response = requests.post(
            self.token_url,
            params=params
        )

        response_json = response.json()
        token_type = response_json["token_type"]
        access_token = response_json["access_token"]
        access_token = f"{token_type} {access_token}"
        refresh_token = response_json["refresh_token"]

        return (access_token, refresh_token)

    def update(self):
        new_token_creation_timestamp = int(time.time())
        new_access_token = self.__refresh()

        if new_access_token:
            datas = {
                "access_token": new_access_token,
                "token_creation_timestamp": new_token_creation_timestamp
            }

            self.__save_json_datas(json_file_path="access_token.json", datas=datas)

    def is_valid(self) -> bool:
        """Check if the current token is still valid or not.

        Returns:
            bool: True or False.
        """
        current_timestamp = int(time.time())
        current_access_token_timestamp = self.__get_timestamp()

        if current_access_token_timestamp + 3600 <= current_timestamp:
            return False
        return True
