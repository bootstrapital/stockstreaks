with price_data as (
    select
        ticker
        , calendar_date
        , adj_open
        , adj_close
        , lag(adj_open) over (
            partition by ticker
            order by calendar_date
        ) as prev_day_adj_open
        , row_number() over (
            partition by ticker
            order by calendar_date desc
        ) as reverse_day_number

    from price_calcs.stg_daily_prices
)

select
    * exclude (reverse_day_number)
    , case
        when adj_close is null then null
        when adj_close >= prev_day_adj_open then 1
        else 0
    end as close_vs_yd1_open

from price_data

where reverse_day_number <= 14

order by
    ticker
    , calendar_date desc
