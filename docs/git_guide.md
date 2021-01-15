# Git Guide

The goal of this guide is twofold:

1. Improve consistency when multiple analysts are working on a codebase; and
2. Provide a framework that decreases the number of decisions that need to be
made

## Git branches

_Git branches should_:
* be named as follows:
  * feature/name-of-feature
  * fix/name-of-fix
  * refactor/name-of-refactor

## Commits

_Commits should_:

* have a message in the imperative sense – a good way to frame this tense is to
  finish the sentence "This commit will ...". For example:
  * Add MRR models
  * Fix typo in sessions model description
  * Update schema to v2 schema syntax
  * Upgrade project to dbt v0.18.2
* happen early and often! As soon as a piece of your code works, commit it! This
  means that if (/when), down the line, you introduce bad code, you can easily
  take your code back to the state it was in when it worked.

_Commits can_:

* be squashed on a local branch before being  pushed to your remote branch, if
  you feel comfortable doing this.

## Pull requests

_Pull requests should_:

* follow the [Pull Request Template](/.github/pull_request_template.md) to fully
  describe the PR.
* tackle a functional grouping of work. While it may be tempting to (for
  example) build MRR models _and_ add maintenance jobs in a single PR, these
  should be separate pieces of work.
* include a body that explains the context of the changes to the code, as well
  as what the code does. Useful things to include in a PR are:
  * Link to JIRA ticket(s)
  * Link to dbt docs that explain any new piece of functionality you have
    introduced
  * A screenshot of the DAG for the new models you have built
  * Links to any related PRs (for example, if Looker dimensions will need to be
    updated to reflect the changes in your models)
  * Explanation of any breaking changes
  * Any special instructions to merge this code, e.g. whether a full-refresh
    needs to be run, or any renamed models that should be dropped.
* be opened with 48 hours for the reviewer to review.
* be merged by its _author_ when:
  * approval has been given by at least one collaborator
  * all tests have passed.

_Pull requests can_:

* be used to collaborate on code, as they are a great way to share the code
  you've written so far. In this scenario, use a _draft_ pull request.

## Bug reports

From time to time, some of our work will impact existing reports, such that numbers diverge from what we expect. Often in the analytics space, we will get alerted that something is "wrong" or "broken" without enough details for us to diagnose the issue effectively. To help fix things as quickly as possible, it's really important to communicate the bug clearly. Often, as the bug reporter, spending some extra effort when reporting the bug will save lots of effort in making the fix!

If you've noticed a bug, open up an issue in the dbt repository. We use the same structure in reporting analytics bugs that software engineers do when reporting software bugs.

_Bug reports should_:

* follow the [Bug Report Template](/.github/ISSUE_TEMPLATE/bug_report.md) to create a
  JIRA ticket that fully describes the bug.
* include a good summary that can quickly and uniquely identify a bug report. It should explain the problem, not your suggested solution.
  * Good: "January 2021 filter overcounts users on the Organization dashboard"
  * Bad: "Dashboard crashes V2"
* include detailed steps to reproduce, and expected vs. actual results
* link to any relevant PRs, issues, data requests or other JIRA tickets

_Bug reports can_:

* be used to track historical data issues, as a great way to track data changes
  and help the team understand how issues and PRs are related
