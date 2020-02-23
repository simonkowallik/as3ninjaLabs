from boltons import iterutils
from ipaddress import IPv4Address
import pytest

from .testing_utils import Tenants

# Read all tenant configurations into a dict using Tenants() testing utility
tenants = Tenants("Lab10X/104/tenants/")


class Test_RequiredPractices:
    """
    These tests make sure the configuration follows required practices.
    Required practices usually ensure the configuration follows good/best practices
    to ensure they function as well as possible
    """

    @staticmethod
    @pytest.mark.parametrize(
        "config_path, _", iterutils.research(tenants, lambda p, k, v: v == "Pool")
    )
    def test_pools_have_monitors(config_path, _):
        """
        Require monitor configuration for each service
        """
        config_path = config_path[
            0:-1
        ]  # remove 'class' from config_path, which is always the last element
        monitors = iterutils.get_path(tenants, config_path).get("monitors")

        print(f"currently processing: {config_path}, monitors: {monitors}", end=" ")
        assert monitors  # not empty and not None
        for monitor in monitors:
            assert monitor  # make we don't have an empty entry in the list of monitors either!
