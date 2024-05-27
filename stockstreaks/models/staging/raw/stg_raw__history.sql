with source as (

    select
        lower("Ticker") as ticker,
        "Date" as calendar_date,

        -- Evidence converts to UTC which results in DATE fields being off by 1 day
        -- See: https://github.com/evidence-dev/evidence/issues/1652
        date_add("Date", interval 1 day) as display_date,

        "Open" as open,
        "High" as high,
        "Low" as low,
        "Close" as close,
        "Volume" as volume,
        "Dividends" as dividends,
        "Stock Splits" as split,
        "Capital Gains" as capital_gains
    
    from {{ source('db', 'history') }}

)

select * from source