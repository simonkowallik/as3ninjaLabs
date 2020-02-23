[![AS3 Ninja Labs](https://github.com/simonkowallik/as3ninjaLabs/raw/master/cicd/_static/ninjalabs.png)](https://github.com/simonkowallik/as3ninjaLabs)

*Welcome to the AS3 Ninja Lab, where you'll learn about CI, CD and AS3 Ninjutsu!*

The Labs use Circle CI, current build status: [![CircleCI](https://circleci.com/gh/simonkowallik/as3ninjaLabs.svg?style=svg)](https://circleci.com/gh/simonkowallik/as3ninjaLabs)

## Overview

Several Labs are available to explore CI, CD, AS3 Ninja and secrets management using HashiCorp Vault.

The Labs are designed to use the GitHub workflow: [Fork, modify and create a pull request to use the linked CI/CD](GetReady/use_github+cicd.md). The quickest and easiest way to get started is using the GitHub Workflow. [GitHub allows you to Fork, Modify, Commit and create a Pull Request in less than 10 steps! You only need a GitHub.com account.](https://help.github.com/en/github/managing-files-in-a-repository/editing-files-in-another-users-repository)

For an overview of additional tools used in the CI pipline see [`CI_Pipeline.md`](CI_Pipeline.md).

## Labs
Each `LabX0X` directory contains further instructions for each level and Lab.

When you are ready [start with Lab10X](Lab10X/).

## Help
If anything is unclear, you found a bug or have an idea to improve the Labs please open a [Github Issue](https://github.com/simonkowallik/as3ninjaLabs/issues).


## Details about AS3 Ninja

Head over to:

- RTFM: <https://as3ninja.readthedocs.io>
- GitHub: <https://github.com/simonkowallik/as3ninja>
- It is free software: ISC license

# Important Note

*Please do not include any sensitive or private information in any pull request. Everything is publicly visible, please act responsibly.*

When you are going through the CI/CD pipeline you will notice that a pull request is not only ran against the CI tests but also gets deployed (CD) when the CI pipeline ran successfully. In reality this is most likely a very bad idea but in a Lab setting it's great for demonstrational purposes. :-)
Same applies to including actual secrets during CI, most likely you'd want to use "Lab Secrets" and definitely never ever log actual secrets.
