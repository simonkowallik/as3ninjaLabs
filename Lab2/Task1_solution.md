# Solution: Lab 2 - Task 1

Here is a possible solution for Task 1:

### `ninja.yaml`:

Remove "piping" the private key and replace it with the Vault `path`.

```yaml
    tls:
      ciphers: DEFAULT:!TLS_v1:!TLS_v1_1
      certificate:
        path: /secretv2/admin/jumphost/x509
      privateKey:
        path: /secretv2/admin/jumphost/x509
      bridging: true
```

### `template.jinja2`:

Update the `privateKey` entry. The privateKey is stored at `data->data->privateKey`.

```jinja2
        "ckc_{{ app.name }}": {
          "class": "Certificate",
          "certificate": {{ (app.tls.certificate | vault)['data']['data']['certificate'] | jsonify }},
          "privateKey": {{ (app.tls.privateKey | vault)['data']['data']['privateKey'] | jsonify }}
        },
```
