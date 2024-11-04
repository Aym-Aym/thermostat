import socket

from pathlib import Path
from server_ssh import ServerSSH


class ServerControlWidget:
    """Server control widget backend for the dashboard."""
    def __init__(self, ssh_server: ServerSSH):
        """Initializes the Server Control Widget instance.

        Args:
            ssh_server (ServerSSH): ServerSSH instance that deals with
              server SSH connection and requests.
        """
        self.ssh_server = ssh_server

    def get_status(self) -> bool:
        """Check server status.

        Returns:
            bool: True if server is online, else False.
        """
        return self.ssh_server.get_status()

    def get_uptime(self) -> str:
        """Check server uptime.

        Returns:
            str: String with the time, uptime, user number and load average
            of the server.

        Example:
            >>> uptime()
            '12:03  up 53 mins, 2 users, load averages: 11.86 8.71 7.78'
        """
        return self.ssh_server.send_command("uptime") or "Unknown"

    def get_mac_address(self) -> str:
        """Get mac address of the server.

        Returns:
            str: Mac address string.

        Example:
            >>> get_mac_address()
            'fc:34:97:10:32:bc'
        """
        output = self.ssh_server.send_command(
            "ip link show enp4s0"
        )
        output_list = output.split(" ")
        output = output_list[output_list.index("link/ether") + 1]

        return output or "Unknown"

    def get_ip(self) -> str:
        """Get server ip.

        Returns:
            str: Server ip string.
        """
        return self.ssh_server.get_ip()

    def reboot(self) -> None:
        """Send command to reboot the server."""
        ssh_server_password = self.ssh_server.get_password()
        self.ssh_server.send_command(
            f"echo {ssh_server_password} | sudo -S systemctl reboot"
        )

    def power_off(self) -> None:
        """Send command to power off the server."""
        ssh_server_password = self.ssh_server.get_password()
        self.ssh_server.send_command(
            f"echo {ssh_server_password} | sudo -S systemctl poweroff"
        )

    def power_on(self, mac_address: str) -> None:
        """Send wake on lan command to start the server.

        Args:
            mac_address (str): Ethernet card MAC address of the server.
        """
        mac_address = mac_address.replace(":", "")

        if len(mac_address) != 12:
            raise ValueError("MAC address should be 12 hexadecimal digits")

        mac_bytes = bytes.fromhex(mac_address)
        magic_packet = b'\xff' * 6 + mac_bytes * 16

        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
            sock.sendto(magic_packet, ('<broadcast>', 9))


username = "aymeric"
password = "###########"
ip = "192.168.1.60"
private_key_path = Path("/Users/aymeric/.ssh/aymserver/id_rsa")
port = 2424

with ServerSSH(
    ip=ip,
    port=port,
    username=username,
    password=password,
    private_key_path=private_key_path,
    timeout=1
) as ssh_server:
    server = ServerControlWidget(ssh_server)
    print(server.get_status())
    print(server.get_uptime())
    print(server.get_ip())
    print(server.get_mac_address())
    # server.reboot()
    # server.power_off()
    server.power_on("fc:34:97:10:32:bc")
