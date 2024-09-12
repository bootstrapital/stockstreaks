
select distinct 
    ticker
    , case when upper(ticker) 
        in ('AAPL','MSFT','AMZN','WMT','JPM','UNH','V',
            'PG','JNJ','HD','KO','MRK','CVX','CRM','MCD',
            'CSCO','IBM','VZ','AXP','AMGN','CAT','DIS',
            'GS','HON','NKE','BA','INTC','MMM','TRV','DOW'
        ) 
        then true 
        else false 
    end as is_dow_30

from price_calcs.stg_daily_prices


order by 1;