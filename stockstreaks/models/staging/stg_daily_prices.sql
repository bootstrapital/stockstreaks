with source as (

    select
        -- Update column names
        lower("Ticker") as ticker

        -- Evidence converts to UTC which results in DATE fields being off by 1 day
        -- So we're adding 9 hours to the UTC timestamp so it computes correctly
        -- See: https://github.com/evidence-dev/evidence/issues/1652
        , "Date"::timestamp - interval '4 hour' as calendar_date

        -- Evidence converts to UTC which results in DATE fields being off by 1 day
        -- See: https://github.com/evidence-dev/evidence/issues/1652
        , date_add("Date"::timestamp + interval '4 hour', interval 1 day) as display_date

        , "Open" as open
        , "High" as high
        , "Low" as low
        , "Close" as close
        , "Volume" as volume
        , "Dividends" as dividends
        , "Stock Splits" as stock_splits

    from {{ source('history', 'daily') }} 

)

, calc_split_factors AS (

    select
        ticker,
        calendar_date,
        exp(sum(ln(case when stock_splits = 0 then 1 else stock_splits end)) 
            over (partition by ticker order by calendar_date desc)) as cumulative_split_factor

    from source

)

, calc_dividend_factors AS (

    select
        s.ticker,
        s.calendar_date,
        exp(sum(ln(1 + coalesce(s.dividends, 0) / s.close * csf.cumulative_split_factor)) 
            over (partition by s.ticker order by s.calendar_date desc)) as cumulative_dividend_factor
    from source s
        join calc_split_factors csf 
            on s.ticker = csf.ticker and s.calendar_date = csf.calendar_date

)

select
    s.*,
    csf.cumulative_split_factor,
    cdf.cumulative_dividend_factor,
    s.open * csf.cumulative_split_factor / cdf.cumulative_dividend_factor as adj_open,
    s.high * csf.cumulative_split_factor / cdf.cumulative_dividend_factor as adj_high,
    s.low * csf.cumulative_split_factor / cdf.cumulative_dividend_factor as adj_low,
    s.close * csf.cumulative_split_factor / cdf.cumulative_dividend_factor as adj_close,
    s.volume / csf.cumulative_split_factor as adj_volume

from source s
    join calc_split_factors csf 
        on s.ticker = csf.ticker and s.calendar_date = csf.calendar_date
    join calc_dividend_factors cdf
        on s.ticker = cdf.ticker and s.calendar_date = cdf.calendar_date

order by s.ticker, s.calendar_date