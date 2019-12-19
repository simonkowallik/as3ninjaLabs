# AS3 Ninja Lab1

## Objective

Our objective for this lab is to familiarize yourself with AS3 Ninja, the Declaration Template (`template.jinja2`), Jinja2, the Template Configuration (`ninja.yaml`) and the CI/CD pipeline configuration (`/.circleci/config.yml`).

It's not necessarily an easy start but I have trust in your skills! :-)

## Task 1

The Template Configuration is "fed" to the Declaration Template, which then results in an AS3 Declaration.

Take some time to review `template.jinja2` and `ninja.yaml`, ideally side-by-side. Then also have a look at the `AS3Declaration.json`, which is the result of both.

You probably get an idea how `template.jinja2` and `ninja.yaml` where *transformed* to the `AS3Declaration.json`.

If you wonder what the pipe (`|`) in the YAML does, have a look at this stackoverflow answer: <https://stackoverflow.com/a/21699210>

## Task 2

Have a look at the [CI/CD pipeline configuration](../.circleci/config.yml) (`/.circleci/config.yml`).

Look for the `Lab1 CI pipeline` and read through each `step`.
Most should be pretty self-explanatory. Every `run` key indicates `command`s to be run during this particular step.
If the command fails (non-zero exit code), the step fails -> CI failure.

Further down in the file `CD (Continuous Delivery) Pipeline (used for all Labs)` describes the Continuous Delivery of all AS3 Declarations.

At the end of the file the `CI/CD Workflow` defines the pipeline execution and dependencies.
The `ci-setup` job has to complete successfully to kick-off the CI jobs for all Labs. The Lab CI jobs could run in parallel.
Once the Lab CI jobs are completed successfully, Continuous Delivery kicks-in and deploys the AS3 Declaration `artifact` to <https://hastebin.com>.

## Task 3

It's time to play!

> **Hint:** [Don't forget, you can even edit files directly on GitHub](https://help.github.com/en/github/managing-files-in-a-repository/editing-files-in-another-users-repository)

Small steps first, start with `ninja.yaml` and change some addresses and ports. Later try adding another service.

If you work locally try this the below commands.
For more help on the local usage see [this RTFM page](https://as3ninja.readthedocs.io/en/latest/usage.html).

```bash
docker run --rm -it -v $PWD/:/Lab1 simonkowallik/as3ninja \
  as3ninja transform \
    --no-validate \
    --configuration-file Lab1/ninja.yaml \
    --declaration-template Lab1/template.jinja2
```

Now try the same with validation enabled:

```bash
docker run --rm -it -v $PWD/:/Lab1 simonkowallik/as3ninja \
  as3ninja transform \
    --validate \
    --configuration-file Lab1/ninja.yaml \
    --declaration-template Lab1/template.jinja2
```

## Final words

If you liked it, please don't forget to "star" this repository. :-)
If you didn't, [I'm happy for any feedback!](https://github.com/simonkowallik/as3ninjaLabs/issues/new/choose)

When you are ready [continue to Lab2](../Lab2/)
