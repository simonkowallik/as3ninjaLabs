# AS3 Ninja Lab3

## Objective

As we use structured configuration files, it is possible to code configuration tests or even *full policies*.

As you design your Template Configuration, you can take into account to test any incoming requests to change the configuration against simple rules or more sophisticated policies.

This approach also fits the "*Everything* as Code" movement.

[openpolicyagent.org](https://www.openpolicyagent.org) is used by [conftest](https://github.com/instrumenta/conftest), which we will use.

An Introduction to Conftest: <https://garethr.dev/2019/06/introducing-conftest/>

Documentation about the Policy Language (Rego): <https://www.openpolicyagent.org/docs/latest/policy-language/>

There are many other ways to implement similar checks, you could come up with your own script to check the configuration.

## Task

Review the `/policy/deny.rego` file as well as the CI/CD pipeline for Lab3.

Then make some changes to trigger the deny rules.


## Final words

If you liked it, please don't forget to "star" this repository. :-)
If you didn't, [I'm happy for any feedback!](https://github.com/simonkowallik/as3ninjaLabs/issues/new/choose)
