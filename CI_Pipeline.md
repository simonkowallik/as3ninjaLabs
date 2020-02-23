# CI Pipeline

Here is a quick overview of the CI Pipeline used in this demo.

## CI System: Circle CI

This demo uses Circle CI, it's available for free for open source projects and has a nice UI.
There are many other CI systems out there, choose one which suits you best / is available to you.

You can find the CI Pipeline configuration in [`.circleci/config.yml`](.circleci/config.yml)
and the results at [https://circleci.com/gh/simonkowallik/as3ninjaLabs](https://circleci.com/gh/simonkowallik/as3ninjaLabs).

## Tools

The CI Pipeline uses various tools beyond the scripts in [`cicd/`](cicd/), here is the list:

### AS3 Ninja

Tool to template AS3 Declarations, test them against the AS3 Schema and more.
See: [https://github.com/simonkowallik/as3ninja](https://github.com/simonkowallik/as3ninja)

### detect-secrets

Tool to detect secrets in source code, here is the detect-secrets homepage: [https://github.com/Yelp/detect-secrets](https://github.com/Yelp/detect-secrets)

There are many other tools like this available, this one allowed me to create a baseline, which is helpful in this demo due to the embedded secrets in the first labs.


### yamllint

yamllint is a linter for yaml, as the name suggests. It's rules are configured in [`.yamllint.yaml`](.yamllint.yaml) and you can learn more about it here: [https://github.com/adrienverge/yamllint](https://github.com/adrienverge/yamllint)


### Configuration testing (python pytest, conftest, ..)

Other tools used are:

- [pytest](https://docs.pytest.org/en/latest/): A python testing framework

  In this demo pytest is used to test structured YAML data instead of python code and still works great!

- [conftest](https://github.com/instrumenta/conftest/) isn't used currently, but is another way to test structured configuration data
