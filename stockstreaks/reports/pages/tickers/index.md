```sql symbols
select distinct
    ticker
from dailies
```

{#each symbols as symbol}

- [{symbol.ticker.toUpperCase()}](/tickers/{symbol.ticker})

{/each}