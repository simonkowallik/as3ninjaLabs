#!/usr/bin/env python3
"""Setup Vault Configuration and add test secrets"""

import hvac
import json

VAULT_DIR = "/tmp/vault"

def readfile(file: str) -> str:
    with open(file, "r") as f:
        return str(f.read())

def setup_secrets_engines(client):
    """create kv v1 and v2 secret engines"""
    client.sys.enable_secrets_engine(
        backend_type='kv',
        path='secretv1',
        options=dict(version=1),
    )
    client.sys.enable_secrets_engine(
        backend_type='kv',
        path='secretv2',
        options=dict(version=2),
    )

def create_kv1_secrets(client):
    """create secrets in kv v1"""
    kv1_s = {
        'privateKey': readfile(f"{VAULT_DIR}/key1k.pem"),
        'certificate': readfile(f"{VAULT_DIR}/cert1k.pem"),
    }
    client.secrets.kv.v1.create_or_update_secret(
        mount_point='secretv1',
        path='classic/x509',
        secret=kv1_s,
    )
    client.secrets.kv.v1.create_or_update_secret(
        mount_point='secretv1',
        path='classic/sharedsecret',
        secret={
            'AES128': readfile(f"{VAULT_DIR}/aes.key1"),
        },
    )


def create_kv2_secrets(client):
    """create secrets in kv v2"""
    kv2_s = {
        'privateKey': readfile(f"{VAULT_DIR}/key1k.pem"),
        'certificate': readfile(f"{VAULT_DIR}/cert1k.pem"),
    }
    client.secrets.kv.v2.create_or_update_secret(mount_point='secretv2', path='admin/jumphost/x509', secret=kv2_s)
    kv2_s = {
        'privateKey': readfile(f"{VAULT_DIR}/key2k.pem"),
        'certificate': readfile(f"{VAULT_DIR}/cert2k.pem"),
    }
    client.secrets.kv.v2.create_or_update_secret(mount_point='secretv2', path='admin/jumphost/x509', secret=kv2_s)

    client.secrets.kv.v2.create_or_update_secret(
        mount_point='secretv2', path='admin/jumphost/sharedsecret',
        secret={'AES128': readfile(f"{VAULT_DIR}/aes.key1")}
    )
    client.secrets.kv.v2.create_or_update_secret(
        mount_point='secretv2', path='admin/jumphost/sharedsecret',
        secret={'AES128': readfile(f"{VAULT_DIR}/aes.key2")}
    )

def log_kv1_secrets(client, vault_log):
    """append kv1 secrets to vault_log"""
    kv1 = []

    secret = {'mount_point':'secretv1','path':'classic/x509'}
    kv1.append({'secret': secret, 'value' : client.secrets.kv.v1.read_secret(**secret)})
    secret = {'mount_point':'secretv1','path':'classic/sharedsecret'}
    kv1.append({'secret': secret, 'value' : client.secrets.kv.v1.read_secret(**secret)})

    vault_log['kv1'] = kv1

def log_kv2_secrets(client, vault_log):
    """append kv2 secrets to vault_log"""
    kv2 = []

    secrets = (
        {'mount_point':'secretv2','path':'admin/jumphost/x509','version':1},
        {'mount_point':'secretv2','path':'admin/jumphost/x509','version':2},
        {'mount_point':'secretv2','path':'admin/jumphost/sharedsecret','version':1},
        {'mount_point':'secretv2','path':'admin/jumphost/sharedsecret','version':2},
    )

    for secret in secrets:
        kv2.append({'secret': secret, 'value' : client.secrets.kv.v2.read_secret_version(**secret)})

    vault_log['kv2'] = kv2


def main():
    client = hvac.Client()

    vault_log = {}
    vault_log['Authentication successful'] = client.is_authenticated()

    if client.is_authenticated():
        # we expect client is authenticated but we check anyway
        setup_secrets_engines(client)

        create_kv1_secrets(client)
        create_kv2_secrets(client)

        log_kv1_secrets(client, vault_log)
        log_kv2_secrets(client, vault_log)

    print(json.dumps(vault_log))


if __name__ == "__main__":
    main()
