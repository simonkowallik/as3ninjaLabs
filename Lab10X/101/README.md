# Lab 101: Basics

The AS3 API uses JSON as the data format. It is important to realize that is is *just* a data format, which means we can express the AS3 Declaration in other data formats as well, such as YAML!

### AS3 Declaration as YAML

There is a lot of back and forth which format is better/best but it's not the focus of this lab to discuss all these. One advantage of YAML is that changes usually only affect the lines the data is hold in, which makes it easier to to read when reviewing changes (diffs). In contrast changes within JSON usually affect multiple lines, due to the need to append a comma `,` for separation of entries.


Also YAML allows comments, which is great for us humans.

### Comparing YAML and JSON AS3 Declarations

The files [`AS3Declaration.json`](AS3Declaration.json) and [`AS3Declaration.yaml`](AS3Declaration.yaml) in this lab describe the same AS3 declaration using different data formats, have a look!
The CI test [`tests/Lab10X/test_lab101.sh`](../../tests/Lab10X/test_lab101.sh) will test this by converting the YAML AS3 Declaration to JSON and compare both.


Say we want to add `192.0.2.14` as an additional pool member, this requires two changes in the JSON data format, where only one additional line is required for YAML.

This is how a diff for `AS3Declaration.json` looks like:

```diff
               "servicePort": 80,
               "serverAddresses": [
                 "192.0.2.12",
-                "192.0.2.13"
+                "192.0.2.13",
+                "192.0.2.14"
               ]
             }
           ]
```

And this is the diff for `AS3Declaration.yaml`:

```diff
           serverAddresses:
           - 192.0.2.12
           - 192.0.2.13
+          - 192.0.2.14
       webtls:
         class: TLS_Server
         certificates:
```

### Try it yourself

Feel free to fork, edit both files and send a pull request to try it yourself.

If you don't perform the same changes to both JSON and YAML AS3 Declaration, the CI pipeline will fail.


# [Proceed to Lab 102 >>](../102)
