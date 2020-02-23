from boltons import iterutils
from ipaddress import IPv4Address
import pytest

from .testing_utils import Tenants

# Read all tenant configurations into a dict using Tenants() testing utility
tenants = Tenants("Lab10X/104/tenants/")


class Test_Security:
    """
    This Test Class contains security checks on the configuration data based on our Security Policy.
    """

    @staticmethod
    @pytest.mark.parametrize(
        "config_path, pool_members",
        iterutils.research(tenants, lambda p, k, v: k == "serverAddresses"),
    )
    def test_pool_must_use_private_addresses(config_path, pool_members):
        """
        The Security Policy requires pool members use private addresses / no public IPs
        """
        print(f"currently processing: {config_path}, members: ", end="")
        for member in pool_members:
            print(f"member:{member} ", end="")
            assert IPv4Address(member).is_private  # member IP address must be private

    @staticmethod
    @pytest.mark.parametrize(
        "config_path, servicePort",
        iterutils.research(tenants, lambda p, k, v: k == "servicePort"),
    )
    def test_pool_allow_specific_ports(
        config_path, servicePort, allowed_ports=(80, 81, 8000, 8080)
    ):
        """
        Pool members must use a port in the allowed ports list
        """
        print(f"currently processing: {config_path}, servicePort: {servicePort}", end=" ")
        assert isinstance(servicePort, int)  # servicePort must be an integer
        assert (
            servicePort in allowed_ports
        )  # servicePort must be listed in allowed_ports

    @staticmethod
    @pytest.mark.parametrize(
        "config_path, virtualPort",
        iterutils.research(tenants, lambda p, k, v: k == "virtualPort"),
    )
    def test_disallowed_service_ports(
        config_path, virtualPort,
        disallowed_ports=(
            0,  # no wildcard listeners
            6667,  # disallowed port
            )
    ):
        """
        Services must not listen on the disallowed_ports
        """
        print(f"currently processing: {config_path}, virtualPort: {virtualPort}", end=" ")
        if virtualPort is not None:
            assert isinstance(virtualPort, int)  # virtualPort must be an integer
            assert (
                virtualPort not in disallowed_ports
            )  # virtualPort must not be in disallowed_ports
