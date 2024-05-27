---
Title: ${params.ticker}
---

Contents

- [Interday](/tickers/{params.ticker}/interday)
- [Intraday](/tickers/{params.ticker}/intraday)

---

```sql l10d
select
    ticker,
    calendar_date,
    open,
    close,
    daily_performance,
    case 
        when daily_performance < 0 then 'down' 
        when daily_performance = 0 then '-'
        else 'up'
    end as direction
from stockstreaks.dailies
where ticker = '${params.ticker}'
order by 2 desc
limit 10
```

<!-- # {params.ticker} -->

<BigValue
    data={l10d}
    value='close'
    fmt=usd2
    comparison='daily_performance'
    comparisonFmt=pct2
    comparisonTitle='for day on {l10d[0].calendar_date}'
/>

<BarChart
    title='Daily Performance (Close vs Open)'
    subtitle='Last 10 days'
    data={l10d} 
    x=calendar_date 
    xAxisLabels=true
    showAllXAxisLabels=true
    y='daily_performance'
    yFmt=pct3
    yAxisLabels=false
    yGridlines=false
    series=direction
    labels=false
    seriesColors={{'down': 'red', 'up': 'green'}}
    legend=false
/>

```sql l90d
select
    ticker,
    calendar_date,
    open,
    close,
    daily_performance,
    case 
        when daily_performance < 0 then 'down' 
        when daily_performance = 0 then '-'
        else 'up'
    end as direction
from stockstreaks.dailies
where ticker = '${params.symbol}'
order by 2 desc
limit 90
```

