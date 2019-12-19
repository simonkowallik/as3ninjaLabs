# Solution: Lab 2 - Task 2

In `ninja.yaml` remove the following configurations from both Apps:
```yaml
    address:
    - 198.18.0.10
...
    backend:
    - servicePort: ...
      serverAddresses:
      - 192.168.100.1
```

Create a new YAML file `siteA.yaml`:
```yaml
ipam:
  WebJumphost:
    address:
      - 198.18.0.10
  SSHJumphost:
    address:
      - 198.18.0.10
backends:
  WebJumphost:
    backend:
    - servicePort: 443
      serverAddresses:
      - 192.168.100.1
  SSHJumphost:
    backend:
    - servicePort: 22
      serverAddresses:
      - 192.168.100.1
```

Modify `template.jinja2` as follows:

```
{# remove: #}
            "members": {{ app.backend | jsonify }}
{# add: #}
            "members": {{ ninja.backends[app.name] | jsonify }}
...
{# remove: #}
          "virtualAddresses": {{ app.address | jsonify }},
{# add: #}
          "virtualAddresses": {{ ninja.ipam[app.name] | jsonify }},
```

Finally modify `build_declaration.sh`:
```bash
# replace existing as3ninja command with:
as3ninja transform \
  --no-validate \
  -c $file_prefix/mappings.yaml \
  -c $file_prefix/ninja.yaml \
  -c $file_prefix/siteA.yaml \
  -t $file_prefix/template.jinja2 \
  -o $ARTIFACT
```

Creating further `siteX.yaml` files is pretty straightforward.
