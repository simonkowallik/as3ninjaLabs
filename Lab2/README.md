# AS3 Ninja Lab2

## Objective

Now that you mastered Lab 1, let's enhance the code from Lab 1.

We have two tasks:

1. Separate secrets from configuration

2. Enable deployment in multiple sites

## Task 1: Separate secrets from configuration

Whoever worked on the config started to separate the *secrets* from the Template Configuration (`ninja.yaml`) but missed the most important one, the *privateKey*!

Let's update the Template Configuration and Declaration Template to fetch
the `privateKey` from HashiCorp Vault as well.

> Vault is started as a container in the CI pipeline, the shell environment
> variables VAULT_TOKEN and VAULT_ADDR are set which provides us with access
> to Vault and the stored secrets.

If you don't want to fiddle with it, have a look at [the Task 1 solution document](Task1_solution.md).


## Task 2: Enable deployment in multiple sites

The administrative services should be available in multiple sites, e.g. different regions of a public cloud provider.
We want to keep all settings the same except:

- The external application address (virtual server)
- The backend addresses (pool members)

The `mappings` have been moved to a dedicated Template Configuration file already (`mappings.yaml`), This helps to keep everything organized.

Have a look at the `build_declaration.sh` script, it refers both files.

**Some guidance:**
There are multiple ways to achieve this.

We could duplicate the `ninja.yaml` file multiple times and modify the IP addresses for each but this would produce many redundant settings therefore isn't a great option.

We could implement something similar to the `mappings` object and lookup addresses based on a "site key" for example, but setting this "site" would require additional logic as well.

Let's instead use site-specific Template Configuration files and include them when generating the AS3 Declaration (in the `build_declaration.sh` script).
This is pretty simple to start with and could come in handy for other site-specific requirements as well.

If you don't want to fiddle with it, have a look at [the Task 2 solution document](Task2_solution.md).

## Final words

If you liked it, please don't forget to "star" this repository. :-)
If you didn't, [I'm happy for any feedback!](https://github.com/simonkowallik/as3ninjaLabs/issues/new/choose)

When you are ready [continue to Lab3](../Lab3/)
