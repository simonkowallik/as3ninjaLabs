# CI/CD Tooling

This directory contains various little helpers used in the CI/CD Pipeline.

Additional tools are outlined in [`CI_Pipeline.md`](../CI_Pipeline.md)

Here is an overview:

### Files:

- [`AS3Schema_validation.sh`](AS3Schema_validation.sh) is a helper script to submit an AS3 Declaration to the AS3 Ninja REST API for validation against the AS3 Schema.

- [`deploy_hastebin.sh`](deploy_hastebin.sh) deploys an artifact (AS3 Declaration) to hastebin.com for demonstration purposes.

- The script [`skip_ci_when_unchanged.sh`](skip_ci_when_unchanged.sh) checks the git commit for changes to a specific directory. This allows to identify which Lab has changed and run tests/deployments selectively.

- [`jyyj.py`](jyyj.py) can convert data between JSON and YAML data formats. `yaml2json` and `json2yaml` are symbolic links which invoke the specific functionality by name.


### Directory: `./labsetup`
[`vault_create_secrets.sh`](labsetup/vault_create_secrets.sh) and [`vault_setup.py`](labsetup/vault_setup.py) are helper scripts to create a HashiCorp Vault environment including multiple secrets.


### Directory: `./security/secrets`

- [`detect.sh`](security/secrets/detect.sh) checks for secrets in this git repository and compares it against the secrets baseline stored in [`secrets.baseline.json`](../secrets.baseline.json)

- [`set_baseline.sh`](security/secrets/set_baseline.sh) can be used by a DevOps engineer to set or update a baseline for secrets stored in the git repository. Ideally the secrets baseline is empty or existing "embedded" secrets are only removed over time.
