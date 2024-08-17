---
title: Ticker Index
---

```sql ticker_list
    select distinct upper(ticker) as symbol
    from strk.strk.unique_tickers
    order by ticker
```

{#each ticker_list as ticker}

- [{ticker.symbol}](/tickers/{ticker.symbol})

{/each} 