# Run AS3 Ninja Labs using GitHub + CI/CD

## Prerequisites

Tun run the labs using CI/CD the following is required:

- a Github Account

Optionally (recommended):

- a Terminal with bash (zsh and fish might work as well)
- git installed

## Using CI/CD

The Labs are setup to run CI tests for every pull request.
When the tests are successful, the AS3 Declaration is deployed as well.

[CircleCI is used for CI/CD](https://circleci.com/gh/simonkowallik/as3ninjaLabs)

### The workflow

The workflow has the following steps:

1. Fork the as3ninjaLabs repository
2. Optional: Clone your Fork (when working on your machine)
3. Make changes
4. Commit (and push when working on your machine)
5. Make a pull request
6. [Watch the CI/CD pipeline](https://circleci.com/gh/simonkowallik/as3ninjaLabs) and give it some time, it usually needs 2-3 min to complete

Don't worry if the CI/CD pipeline fails. The purpose of CI is to highlight failures help you correct them. :-)
So please, make mistakes (and learn).

If you haven't worked with Github Pull Requests ("PRs") before, I really recommend to familiarize yourself with the workflow. Git is empowering!

There are many resources available on the net, below are some quick intros.

If you don't have much time use this guide: [Editing files in another user's repository](https://help.github.com/en/github/managing-files-in-a-repository/editing-files-in-another-users-repository)

Here is the list:

  1. [GitHub Guides: Forking Projects (4 min read)](https://guides.github.com/activities/forking/)

  2. [GitHub Guides: Understanding the GitHub flow (5 min read)](https://guides.github.com/introduction/flow/)

  3. [A quick overview of CI/CD with GitHub](https://youtu.be/xSv_m3KhUO8)

## Ready?

[Start with your first Lab!](../Lab1)
