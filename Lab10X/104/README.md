# Lab 104: The 'Sec' in DevSecOps and some (unit) Testing

In Lab 104 we get more serious and focus on two important topics:

1. Security
2. Testing

## Vault: A safe place for all your secrets

In Lab 103 we separated the secrets from the main configuration, the next step is to remove them from the repository. One way is to move them to a secure "vault" like HashiCorp's Vault, which we'll do in this Lab.

> Obviously there is a lot more to the 'Sec' in DevSecOps, in the end the idea is to embed Security in the entire process at any place. This includes Security of your git setup (protected branches), CI pipeline (different settings for PRs than builds on master), configuration (permitted settings) and more.
>
> Managing secrets is only a small part as you can see, but it is an important one.

In this lab we will use the Hashicorp Vault integration of AS3 Ninja to fetch the certificate and private key from Vault.

In Lab 103 we embedded the secrets in YAML and referenced them by using anchors, here is the YAML:
```yaml
# Excerpt of Lab 103 secrets.yaml
  SampleTenant:
    App1: &secrets_SampleTenant_App1
      certificate: |
        -----BEGIN CERTIFICATE-----
        MIIDmjCCAoKgAwIBAgIJALEkf97t1dr+MA0GCSqGSIb3DQEBCwUAMFYxCzAJBgNV
        ...
        YcsmTF2OULrtEJ415gM=
        -----END CERTIFICATE-----
      privateKey: |
        -----BEGIN PRIVATE KEY-----
        MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQC00fhda4h75jQ4
        ...
        YLUCvuhlaO91VUMVDKlBD+T5y3k=
        -----END PRIVATE KEY-----

# Excerpt of Lab 103 tenants/SampleTenant.yaml
    webcert:
      class: Certificate
      remark: self-signed RSA certificate
      <<: *secrets_SampleTenant_App1

```

Instead of embedding the secrets we now refer to them using the Secret's Path and actual JSON object key.


```yaml
# Lab 104: secrets.yaml
    App1:
      certificate:
        path: /secretv2/SampleTenant/App1/x509  # path of secret in Vault
        filter: data.certificate  # actual JSON object location of secret in Vault
      privateKey:
        path: /secretv2/SampleTenant/App1/x509
        filter: data.private_key
```

In the Tenant configuration we then use Jinja2 code to utilize the AS3 Ninja vault feature to fetch the secrets during AS3 Declaration generation.

```yaml
# Lab 104: tenants/SampleTenant.yaml
    webcert:
      class: Certificate
      remark: self-signed RSA certificate fetched from HashiCorp vault by as3ninja
      certificate: "{{ ninja.secrets.SampleTenant.App1.certificate | vault | jsonify(quote=False) }}"
      privateKey: "{{ ninja.secrets.SampleTenant.App1.privateKey | vault | jsonify(quote=False) }}"

```

Compare the [`secrets.yaml`](secrets.yaml) with the [`Lab103's secrets.yaml`](../103/secrets.yaml) for more details.

Using this technique we have to do a little more than concatenating the YAML and converting it to JSON. We have to use a simple Jinja2 template to generate the AS3 Declaration.

The [`Makefile`](Makefile) contains both steps; First `compose` (concatenate) the YAML configuration, then generate the `declaration` (requires the `compose` step).

```make
compose:
		cat secrets.yaml tenants/*.yaml mainDefinition.yaml > composed.yaml

declaration: compose
		as3ninja transform --no-validate -c composed.yaml -t template.jinja2 \
      | jq . > AS3Declaration.json
```

The composed YAML is fed to AS3 Ninja as a configuration file, the [`template.jinja2`](template.jinja2) replaces the `jq` filter statement for `.as3declaration` and will interpret the Jinja2 statements in the Tenant YAML.

> **Note:** Have a look in the various YAML files, they contain more detailed explanations about each topic and step.

> **Note:** Certificates are usually not kept secret as this is a public component. So there is no need to place it in Vault for confidentiality, but as public key cryptography comes with two components it simplifies management to keep them in the same place.


## Testing: Correctness, security, conformity

Infrastructure as Code examples often miss an important discipline: **Testing**.

Testing has many purposes in software engineering and testing itself is a huge field with different test strategies and tactics which are not covered here.

Instead we will look at the tests in this example and what they accomplish.

For all previous Labs we already test a couple of things:

  1. **Detect violations against the secrets baseline:** Tested by `detect-secrets`
  2. **YAML formatting and overall validity:** Tested by `yamllint`
  3. **Validate that AS3 Declaration complies with the AS3 Schema:** Tested by `as3ninja`

We will now add additional tests based on functional requirements, agreed practices and security requirements.

The first collection of tests in [`tests/Lab104/test_configuration_practices.py`](tests/Lab104/test_configuration_practices.py) validate that every defined Application Pool uses a monitor, to ensure good configuration practices are followed when creating or modifying applications.

The second collection of tests defined in [`tests/Lab104/test_configuration_security.py`](tests/Lab104/test_configuration_security.py) ensure security guidelines are followed, which are:

  1. Pools must use private IP addresses (no backend connection to public services)
  2. Pools use a specific set of Ports (eg. because of firewall access restrictions)
  3. Application services do not use disallowed UDP/TCP ports

Guidelines and implementation for other use-cases and environments will likely differ, but this serves the demo.


### Try it yourself

Feel free to fork, edit and send a pull request to try it yourself.


# [<< Return to Lab 103](../103) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Proceed to the next Level! >>](../../Lab20X)
