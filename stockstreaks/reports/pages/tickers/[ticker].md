---
title:
---

# Daily Performance for {params.ticker.toUpperCase()}
Showing the number of positive outcomes for the last 100 days

<Dropdown name=start_metric>
    <DropdownOption valueLabel="Open" value="o" />
    <DropdownOption valueLabel="Close" value="c" />
</Dropdown>

<Dropdown name=end_metric>
    <DropdownOption valueLabel="Open" value="o" />
    <DropdownOption valueLabel="High" value="h" />
    <DropdownOption valueLabel="Low" value="l" />
    <DropdownOption valueLabel="Close" value="c" />
</Dropdown>


```sql filtered_query
select 
    ticker,
    display_date,
    dayname(calendar_date) as day,
    isodow(calendar_date) as dow,
    display_date - interval (date_part('dayofweek', display_date) - 1) day as reporting_week,
    strftime((display_date - interval (date_part('dayofweek', display_date) - 1) day), '%Y %b %d') as display_week,
    d1${inputs.start_metric.value}${inputs.end_metric.value}_pos_100d as metric
from strk.last_200d 
where ticker = lower('${params.ticker}')
    and display_date >= (current_date - interval (date_part('dayofweek', current_date) - 1) day) - interval 91 day
order by reporting_week desc, dow
```

<Heatmap
    data={filtered_query}
    x=day
    y=display_week
    value=metric 
    title="Last 13 Weeks"
/>
