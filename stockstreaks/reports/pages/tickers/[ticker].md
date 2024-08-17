---
title:
---

# Daily Performance for {params.ticker.toUpperCase()}


<!-- <Dropdown name=start_metric>
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
    ticker
    , calendar_dt
    , d1oc
    , d1oc_pos

from strk.daily_metrics_l400d
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
/> -->
