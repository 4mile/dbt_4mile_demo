# dbt at 4 Mile (Sample)

Welcome to the 4 Mile sample dbt project!
### Introduction

dbt is a powerful tool that represents the "T" (Transform) in an ELT data processing pipeline. dbt uses the compute power of modern data warehouses to run transformations within your data warehouse. The reason ELT (and thus dbt) is such a strong modern analytics design pattern is because your source data and your transformed data all live in the same place, and your business logic that defines how the source data becomes transformed data is well-defined and well-tested. It pairs particularly well with Extract and Load tools like Fivetran or Stitch, and on top of powerful yet user-friendly warehouses like Snowflake and BigQuery.

dbt is a great complement to Looker - serving as an early transformation layer to handle data testing, database
documentation, incremental processing, complex DAG dependencies, notifications and data freshness, while Looker represents the business data model, semantic layer and data visualization for business intelligence to allow business users to self-service.

### Using the dbt Project

If you plan to contribute to the project, please check out our [dbt Style Guide](/docs/dbt_style_guide.md) to learn more about using dbt at 4 Mile! Also, please review our [git Guide](/docs/git_guide.md)) to understand our git flow and pull request process!

First off, you'll want to pull down the project locally. If you haven't done so already, be sure that you have installed and have the most recent version of git and [dbt](https://docs.getdbt.com/dbt-cli/installation). You may also want to install [Visual Studio Code](https://code.visualstudio.com/) as your development environment, along with a few key extensions:

- vscode-dbt
- dbt Power User
- Git History

These should be enough to get your environment set up VS Code for now (more details in the data team handbook coming soon for full environment setup).

You can then get started by running the following using the [dbt CLI](https://docs.getdbt.com/dbt-cli/cli-overview/):

- `dbt deps`
- `dbt seed`

This will install all dependent packages (`dbt deps`), and loading any data seed files (`dbt seed`) to your dev schema in the warehouse. At this point you'll now be able to see your personal development schema in the warehouse! Just log into Snowflake, open up the `dev` database and you should be able to see schema(s) which are prefixed with your username (the one you configured in your `profiles.yml` file).

The below commands are commonly used on the day-to-day when developing with dbt to QA, run and test DAGs and transformation outputs. Run each of these commands to get a preview of running dbt:

- `dbt compile`
- `dbt run --models four_mile_analytics_sample.staging`
- `dbt test --models four_mile_analytics_sample.marts.core.dim_country`

Finally, try running the following commands in order to view the dbt project documentation on your local machine:

- `dbt docs generate`
- `dbt docs serve`

A full list of dbt commands can be found [here](https://docs.getdbt.com/reference/dbt-commands/). The `dbt run` docs in particular are worth knowing well in order to understand how to run only certain models, rather than executing all models every time while you're developing in dbt.

### Resources

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out the dbt [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
