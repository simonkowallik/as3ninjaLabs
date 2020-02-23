# Lab 103: Techniques to scale configurations

Lab 102 highlighted scalability issues when working on a single-file-declaration of our configuration.

Lab 103 addresses this problem.


### divide and conquer

The idea is to [divide and conquer](https://en.wikipedia.org/wiki/Divide-and-conquer_algorithm#Divide_and_conquer). Decompose a huge (and complex) singe-file-declaration into multiple smaller files. This allows us to focus on specific parts of the configuration, for example a specific Tenant or application. In addition the secrets (certificate & private keys) are moved to a dedicated configuration file as well to further declutter the configuration. This decoupling is also a step towards proper secrets management.

This technique could be applied to further configuration elements, for example `App1` and `App2` of `SampleTenant` could be moved out to separate files as well. While this isn't necessary for `SampleTenant` this could prove helpful if the number of applications grow further.

### Layout and purpose

Here is the relevant directory tree structure.
```
$ tree
.
├── mainDefinition.yaml
├── secrets.yaml
└── tenants
    ├── AnotherTenant.yaml
    └── SampleTenant.yaml
```

The YAML file is [`mainDefinition.yaml`](./mainDefinition.yaml), which contains the high-level Declaration information.
The `as3declaration` key holds the AS3 Declaration information. It uses [YAML anchors](https://en.wikipedia.org/wiki/YAML#Advanced_components) to reference to `SampleTenant` and `AnotherTenant`.
Both tenants are defined in their own YAML files located in the [`tenants/`](./tenants) directory.
Within tenant [`SampleTenant.yaml`](./tenants/SampleTenant.yaml) and [`AnotherTenant.yaml`](./tenants/AnotherTenant.yaml) the [YAML merge feature](https://yaml.org/type/merge.html) is used to reference to certificates & private keys which are defined in [`secrets.yaml`](./secrets.yaml).

### Merging the YAML

YAML doesn't auto-magically merge all files, this is going to be our task. The dependency tree would look like this:

```
mainDefinition.yaml
  ├──> AnotherTenant.yaml
  │                     \
  └──> SampleTenant.yaml \
                       \  │
                        └─└─> secrets.yaml
```

As YAML requires an anchor to be defined when it is referenced, the order of *merging* the files is:

  1. `secrets.yaml`
  2. `tenants/*.yaml`
  3. `mainDefinition.yaml`


If you inspect the YAML files closely you will notice that each file has it's own "top-level key" which you could call "namespace". This is **important**, as it avoids running into collisions (eg. duplicate keys) when combining the files.

Composing the intermediate YAML is as easy as concatenating the files in the correct order:

```shell
$ cat \
    secrets.yaml \
    tenants/*.yaml \
    mainDefinition.yaml \
  > composed.yaml
```

### Building the AS3 Declaration

Building the AS3 Declaration requires two things:

1. Convert the YAML to JSON
2. Filter the JSON to only return the AS3 Declaration (remember the `as3declaration` key?)

We can do this in one step actually:

```shell
cicd/yaml2json -f Lab10X/103/composed.yaml | jq .as3declaration > AS3Declaration.json
```

`cicd/yaml2json` converts the YAML to JSON and  `jq .as3declaration` returns the JSON value of key `as3declaration`, which is what we are looking for!


Although some keys might be ordered differently the AS3 Declaration will match the one of Lab 102.


> **Note:** The same technique cannot be used with JSON easily as anchoring and merging are YAML specific features and concatenating JSON files is a little more complicated as well.


### Try it yourself

Feel free to fork, edit and send a pull request to try it yourself.


# [<< Return to Lab 102](../102) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Proceed to Lab 104 >>](../104)
