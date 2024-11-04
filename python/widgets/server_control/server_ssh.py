import paramiko

from pathlib import Path
from typing import Optional, Type


class ServerSSH:
    """A wrapper around Paramiko to handle SSH connections
    for the needs of the dashboard.
    """
    def __init__(
        self,
        ip: str,
        port: int,
        username: str,
        password: str,
        private_key_path: Path,
        timeout: int = 15
    ):
        """Initializes the SSH connection instance.

        Args:
            ip (str): Server ip address.
            port (str): Server SSH port.
            username (str): Server user connecting to SSH.
            password (str): User password.
            private_key_path (Path): Local private key.
            timeout (int): Time in second before the connection timesout,
              if the server is off.
        """
        self.ip = ip
        self.port = port
        self.username = username
        self.password = password
        self.private_key_path = private_key_path
        self.timeout = timeout
        self.ssh_client = paramiko.SSHClient()
        self.connected = False

    def __enter__(self) -> None:
        """Open SSH the connection."""
        self._connect()
        return self

    def __exit__(
        self,
        excecption_type: Optional[Type[BaseException]],
        excecption_value: Optional[BaseException],
        excecption_tracebback: Optional[object]
    ) -> None:
        """Close SSH the connection.

        Args:
            excecption_type (Optional[Type[BaseException]]): Exception type.
            excecption_value (Optional[BaseException]): Exception value.
            excecption_tracebback (Optional[object]): Exception traceback.
        """
        self._close_connection()
        self.connected = False

    def __del__(self) -> None:
        """Close SSH connection on instance deletion."""
        self._close_connection()
        self.connected = False

    def _connect(self) -> None:
        """Connect to the server via SSH."""
        try:
            self.ssh_client.set_missing_host_key_policy(
                paramiko.AutoAddPolicy()
            )

            private_key = paramiko.RSAKey.from_private_key_file(
                self.private_key_path,
                password=self.password
            )
            self.ssh_client.connect(
                hostname=self.ip,
                port=self.port,
                username=self.username,
                pkey=private_key,
                timeout=self.timeout
            )

            self.connected = True

        except paramiko.AuthenticationException:
            print("Authentication failed, please verify your credentials.")
        except paramiko.SSHException as sshException:
            print(f"Unable to establish SSH connection: {sshException}")
        except Exception as e:
            print(f"Exception in connecting: {e}")

    def send_command(self, command: str) -> str:
        """Send a bash command to the server via SSH.

        Args:
            command (str): Bash command.

        Returns:
            str: String returned by the server.

        Example:
            >>> send_command("uptime")
            '12:03  up 53 mins, 2 users, load averages: 11.86 8.71 7.78'
        """
        if not self.connected:
            return ""

        _, stdout, stederr = self.ssh_client.exec_command(command)

        output = stdout.read().decode().strip()
        error = stederr.read().decode().strip()
        return output or error

    def _close_connection(self) -> None:
        """Close the SSH connection."""
        self.ssh_client.close()

    def get_ip(self) -> str:
        """Get the server ip.

        Returns:
            str: Server ip.
        """
        return self.ip

    def get_password(self) -> str:
        """Get the server password.

        Returns:
            str: Server password.
        """
        return self.password

    def get_status(self) -> bool:
        """Get server status.

        Returns:
            bool: True if online, else False.
        """
        return self.connected
