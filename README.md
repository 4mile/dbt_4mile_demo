# 4 Mile dbt Sample Project

## dbt at 4 Mile (Sample)

dbt is a powerful tool that represents the "T" (Transform) in an ELT data processing pipeline. dbt uses the compute power of
modern data warehouses to run transformations within your data warehouse. The reason ELT (and thus dbt) is such a strong modern
analytics design pattern is because your source data and your transformed data all live in the same place, and your business logic that defines how the source data becomes transformed data is well-defined and well-tested. It pairs particularly well
with Extract and Load tools like Fivetran, and on top of powerful yet user-friendly warehouses like Snowflake and BigQuery.

dbt is a great complement to Looker - serving as an early transformation layer to handle data testing, database
documentation, incremental processing, complex DAG dependencies, notifications and data freshness, while Looker represents the
business data model, semantic layer and data visualization for business intelligence.

## Using the dbt Project

After first pull down the project, start by running the following:

- dbt deps
- dbt seed

This will install all dependent packages, and loading any data seeds to your dev schema in the warehouse.

The below commands are commonly used on the day-to-day when developing with dbt to QA, run and test DAGs and transformation outputs.

- dbt compile
- dbt run
- dbt test

Finally, try running the following commands to get started by viewing the project documentation:

- dbt docs generate
- dbt docs serve

A full list of commands can be found [here](https://docs.getdbt.com/reference/dbt-commands/). The `dbt run` docs in particular are worth
knowing well in order to understand how to run only certain models, rather than executing all models every time while you're developing
in dbt.

## Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
