with daily as (
    select
        ticker,
        display_date,
        daily_performance,
        row_number() over (partition by ticker order by display_date desc) as row_num
    from dailies
)

select
    ticker,
    display_date,
    daily_performance
from daily
where row_num <= 10