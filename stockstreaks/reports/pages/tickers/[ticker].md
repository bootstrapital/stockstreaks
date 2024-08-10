---
title: Daily Performance for ${params.ticker.toUpperCase()}
---

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

**Percent of positive ${params.ticker.toUpperCase()} {inputs.start_metric.valueLabel} to ${inputs.end_metric.valueLabel} performance for the last 100 days**

```sql filtered_query
select 
    ticker,
    calendar_date,
    dayname(calendar_date) as day,
    monthname(calendar_date) as month,
    d1${inputs.start_metric.value}${inputs.end_metric.value}_pos_100d as metric
from strk.last_200d 
where ticker = lower('${params.ticker}')
```

<Heatmap
    data={filtered_query}
    x=day
    y=month 
    value=metric 
    title="Rolling 100 Day Performance"
/>
