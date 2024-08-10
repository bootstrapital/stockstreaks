with source as (

    select
        -- Update column names
        lower("Ticker") as ticker
        , "Date"::date as calendar_date

        -- Evidence converts to UTC which results in DATE fields being off by 1 day
        -- See: https://github.com/evidence-dev/evidence/issues/1652
        , date_add("Date", interval 1 day)::date as display_date

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