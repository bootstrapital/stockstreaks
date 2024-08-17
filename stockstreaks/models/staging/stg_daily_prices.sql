with source as (

    select
        -- Update column names
        lower("Ticker") as ticker

        -- Evidence converts to UTC which results in DATE fields being off by 1 day
        -- So we're adding 9 hours to the UTC timestamp so it computes correctly
        -- See: https://github.com/evidence-dev/evidence/issues/1652
        , "Date"::timestamp + interval '9 hour' as calendar_dt

        , "Open" as open
        , "High" as high
        , "Low" as low
        , "Close" as close
        , "Volume" as volume
        , "Dividends" as dividends
        , "Stock Splits" as stock_splits

    from {{ source('history', 'daily') }} 

)

select * from source