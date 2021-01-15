# dbt Coding Conventions

## Model Naming

Our models (typically) fit into three main categories: staging, marts, base/intermediate. Our project structure follows fairly closely to dbt's [Discourse post](https://discourse.getdbt.com/t/how-we-structure-our-dbt-projects/355) on how they structure their projects. The file and naming structures are as follows:

```

├── dbt_project.yml
└── models
    ├── marts
    |   └── core
    |       ├── intermediate
    |       |   ├── intermediate.yml
    |       |   ├── sessions__unioned.sql
    |       |   ├── video_sessions__grouped.sql
    |       └── _core.yml
    |       └── _core.md
    |       └── dim_account.sql
    |       └── dim_counselor.sql
    |       └── fct_sessions.sql
    |   └── b2b
    |       ├── intermediate
    |       |   ├── intermediate.yml
    |       |   ├── organizations__unioned.sql
    |       |   ├── organizations__grouped.sql
    |       └── _b2b.yml
    |       └── _b2b.md
    |       └── dim_organization.sql
    ├── staging
    |   └── stripe
    |       ├── base
    |       |   ├── base_stripe__invoices.sql
    |       ├── _src_stripe.yml
    |       ├── src_stripe.md
    |       ├── _stg_stripe.yml
    |       ├── stg_stripe__customers.sql
    |       └── stg_stripe__invoices.sql
    |   └── stripe
    |       ├── base
    |       |   ├── base_stripe__invoices.sql
    |       ├── _src_stripe.yml
    |       ├── src_stripe.md
    |       ├── _stg_stripe.yml
    |       ├── stg_stripe__customers.sql
    |       └── stg_stripe__invoices.sql
    └── exposures.yml

```

- All objects should match the name of the base table prefixed by `stg_<source_name>`, such as: `stg_salesforce__applications`
- Base tables are prefixed with `base_<source_name>`, such as: `base_salesforce__applications`
- Intermediate tables should end with a past tense verb indicating the action performed on the object, such as: `campaigns__unioned`
- Marts are categorized between fact (immutable, verbs) and dimensions (mutable, nouns) with a prefix that indicates either, such as: `fct_sessions` or `dim_account`

## Model configuration

- Model-specific attributes (like cluster keys, incremental options) should be specified in the model.
- If a particular configuration applies to all models in a directory, it should be specified in the `dbt_project.yml` file.
- In-model configurations should be specified like this:

```python
{{
  config(
    materialized = 'table',
    cluster_by = ['session_start']
    transient = true
  )
}}

```

- Marts should always be configured as tables

## dbt conventions

* Only `stg_` models (or `base_` models if your project requires them) should select from `source`s.
* All other models should only select from other models.

## Testing & Documentation

- Every subdirectory should contain a schema YAML file with tests and documentation on models in that subdirectory.
- Subdirectories in the `staging` folder should have a schema file of format `_stg_<source_name>.yml`, such as: `_stg_hubspot.yml`
- Subdirectories in the `marts` folder should have a schema file of format `_<mart_name>.yml`, such as: `_core.yml`,
- When additional (especially multi-line) documentation is necessary, create a separate `<schema_file_name>.md` file and use docs blocks to further document your models, such as: `_core.md`
- Each model in each subdirectory should be tested.
- At a minimum, unique and not_null tests should be applied to the primary key of each model.

## Sources

- A [source](https://docs.getdbt.com/docs/building-a-dbt-project/using-sources/) in dbt is a named and described data source from some upstream system (e.g. MySQL database, ad platform) that is extract and loaded into your data warehouse/lake.
- Each data source should have one unique subdirectory in the `staging` folder
- Each data source should have a corresponding source schema file in its staging folder of format `_src_<source_name>.yml`, such as: `_src_hubspot.yml`
- Data sources should be tested to ensure our assumptions about source tables are true, such as `accepted_values` tests so we know when we need to handle for a new case, and primary keys
- Sources are a great place to document complex business logic or strange table behavior (e.g. some column stopped being populated in April 2020, thereafter two other columns were populated a different way)

## Exposures

- An [exposure](https://docs.getdbt.com/docs/building-a-dbt-project/exposures) in dbt is a named and described downstream use case for your data warehouse and modeled dbt data, such as a BI dashboard, Jupyter notebook or ML application.
- Exposures should all be defined in the single `exposures.yml` file
- Each exposure should include a description, `maturity` level (either low, medium or high) where low means it is early-stage and not too high priority, and high means it is business-critical (e.g. Daily Reporting Dashboard)
- Exposures should, whenever possible, include the `url` option which links directly to the exposure
- All exposures should have an `owner` specified, who is the primary person on the data team who owns it
- `depends_on` should be specified for all exposures; it need not include EVERY model, but should include at least the top mart-level dimensions and facts that the exposure is dependent upon

## Naming and field conventions

* Schema, table and column names should be in `snake_case`.
* Use names based on the _business_ terminology, rather than the source terminology.
* Each model should have a primary key.
* The primary key of a model should be named `<object>_id`, e.g. `account_id` – this makes it easier to know what `id` is being referenced in downstream joined models.
* For base/staging models, fields should be ordered in categories, where identifiers are first and timestamps are at the end.
* Timestamp columns should be named `<event>_at`, e.g. `created_at`, and should be in UTC. If a different timezone is being used, this should be indicated with a suffix, e.g `created_at_pt`.
* Booleans should be prefixed with `is_` or `has_`.
* Price/revenue fields should be in decimal currency (e.g. `19.99` for $19.99; many app databases store prices as integers in cents). If non-decimal currency is used, indicate this with suffix, e.g. `price_in_cents`.
* Avoid reserved words as column names
* Consistency is key! Use the same field names across models where possible, e.g. a key to the `customers` table should be named `customer_id` rather than `user_id`.

## CTEs

- All `{{ ref('...') }}` statements should be placed in CTEs at the top of the file
- Where performance permits, CTEs should perform a single, logical unit of work.
- CTE names should be as verbose as needed to convey what they do
- CTEs with confusing or noteable logic should be commented
- CTEs that are duplicated across models should be pulled out into their own models
- create a `final` or similar CTE that you select from as your last line of code. This makes it easier to debug code within a model (without having to comment out code!)
- CTEs should be formatted like this:

``` sql
with

events as (

    ...

),

-- CTE comments go here
filtered_events as (

    ...

)

select * from filtered_events
```

## SQL style guide

- Indents should be four spaces (except for predicates, which should line up with the `where` keyword)
- Lines of SQL should be no longer than 80 characters
- Field names and function names should all be lowercase
- The `as` keyword should be used when aliasing a field or table
- Fields should be stated before aggregates / window functions
- Aggregations should be executed as early as possible before joining to another table.
- Ordering and grouping by a number (eg. group by 1, 2) is preferred. Note that if you are grouping by more than a few columns, it may be worth revisiting your model design.
- Specify join keys - do not use `using`. Certain warehouses have inconsistencies in `using` results (specifically Snowflake).
- Prefer `union all` to `union` [*](http://docs.aws.amazon.com/redshift/latest/dg/c_example_unionall_query.html)
- Avoid table aliases in join conditions (especially initialisms) – it's harder to understand what the table called "c" is compared to "customers".
- If joining two or more tables, _always_ prefix your column names with the table alias. If only selecting from one table, prefixes are not needed.
- Be explicit about your join (i.e. write `inner join` instead of `join`). `left joins` are normally the most useful, `right joins` often indicate that you should change which table you select `from` and which one you `join` to.

- *DO NOT OPTIMIZE FOR A SMALLER NUMBER OF LINES OF CODE. NEWLINES ARE CHEAP, BRAIN TIME IS EXPENSIVE*

### Example SQL

```sql
with

my_data as (

    select * from {{ ref('my_data') }}

),

some_cte as (

    select * from {{ ref('some_cte') }}

),

some_cte_agg as (

    select
        id,
        sum(field_4) as total_field_4,
        max(field_5) as max_field_5

    from some_cte
    group by 1

),

final as (

    select [distinct]
        my_data.field_1,
        my_data.field_2,
        my_data.field_3,

        -- use line breaks to visually separate calculations into blocks
        case
            when my_data.cancellation_date is null
                and my_data.expiration_date is not null
                then expiration_date
            when my_data.cancellation_date is null
                then my_data.start_date + 7
            else my_data.cancellation_date
        end as cancellation_date,

        some_cte_agg.total_field_4,
        some_cte_agg.max_field_5

    from my_data
    left join some_cte_agg  
        on my_data.id = some_cte_agg.id
    where my_data.field_1 = 'abc'
        and (
            my_data.field_2 = 'def' or
            my_data.field_2 = 'ghi'
        )
    having count(*) > 1

)

select * from final

```

- Your join should list the "left" table first (i.e. the table you are selecting `from`):

```sql
select
    trips.*,
    drivers.rating as driver_rating,
    riders.rating as rider_rating

from trips
left join users as drivers
    on trips.driver_id = drivers.user_id
left join users as riders
    on trips.rider_id = riders.user_id

```

## YAML style guide

* Indents should be two spaces
* List items should be indented
* Use a new line to separate list items that are dictionaries where appropriate
* Lines of YAML should be no longer than 80 characters.

### Example YAML

```yaml
version: 2

models:
  - name: events
    columns:
      - name: event_id
        description: This is a unique identifier for the event
        tests:
          - unique
          - not_null

      - name: event_time
        description: "When the event occurred in UTC (eg. 2018-01-01 12:00:00)"
        tests:
          - not_null

      - name: user_id
        description: The ID of the user who recorded the event
        tests:
          - not_null
          - relationships:
              to: ref('users')
              field: id
```

## Jinja style guide

* When using Jinja delimiters, use spaces on the inside of your delimiter, like `{{ this }}` instead of `{{this}}`
* Use newlines to visually indicate logical blocks of Jinja
