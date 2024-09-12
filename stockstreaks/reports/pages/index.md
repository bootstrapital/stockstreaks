
```sql heatmap_summary
select
    upper(ticker) as ticker
    , calendar_date
    , strftime(calendar_date, '%b %d') as date_label
    , case when close_vs_yd1_open = 0 then -1 else 1 end as closed_up
    , sum(close_vs_yd1_open) over (partition by ticker) as days_closed_up

from strk.last_14d_performance

where calendar_date > (select min(calendar_date) from strk.last_14d_performance)
    and ticker in (select ticker from strk.unique_tickers where is_dow_30)

order by ticker, calendar_date
```

<Modal title='About StockStreaks' buttonText='About Us'>
    We're building the most comprehensive set of interday metrics for stock analysis in order to help investors avoid violating the Pattern-Day Trading (PDT) rule while growing their account -- and power algorithmic trading strategies using a novel set of data not available elsewhere.
</Modal>

<LineBreak lines=2/>

# Close vs. Previous Day Open
The heatmap shows whether the stock's close price is greater than the previous day's open price for the last 14 trading days.
<LineBreak lines=1/>


<Heatmap 
    data={heatmap_summary}
    title='Dow Jones 30'
    x=date_label
    xSort=calendar_date
    xSortOrder=desc
    xLabelRotation=-45
    y=ticker
    ySort=ticker
    value=closed_up
    valueLabels=false
    colorPalette={['red','white','green']}
    borders=false
    legend=false
/>








