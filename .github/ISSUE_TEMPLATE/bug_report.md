## Steps to reproduce:

List the steps that took you on your journey to discovering this bug! Include hyperlinks so we can go on the same journey.

Example:

```
## Steps to reproduce:
* Go to [this Looker/Mode/Periscope report](www.link_to_dashboard.com).
* Also go to [this GA dashboard](www.link_to_source_query.com).
```

## Expected results:

Explain what you expected to see when you went on your journey of bug-discovery. If you have historical data (e.g. a screenshot of the same report from last week), here is a great place to include it!
Example:
```
## Expected results:
* The organizations numbers for yesterday _should_ be extremely close between the Looker dashboard and source system, if not an exact match.
```

## Actual results:

Explain what you saw that made you go "that doesn't look right". Include screenshots!
```
## Actual results:
* Looker is reporting 500 active organizations yesterday:
[Screenshot of Looker]
* multi_site is reporting 468 organizations yesterday:
[Screenshot of GA]
```

## Extra details:

Include any extra details that you think might be relevant, in particular any related issues. If you are close to the dbt code, you might include a recent PR related to this bug.
```
## Extra details
PR #27 "Join page views to users" was merged just before we noticed these errors
```
