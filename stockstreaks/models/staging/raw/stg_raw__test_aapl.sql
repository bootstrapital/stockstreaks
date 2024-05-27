with source as (

    select
        'aapl' as ticker,
        "Date" as calendar_date,

        -- Evidence converts to UTC which results in DATE fields being off by 1 day
        -- See: https://github.com/evidence-dev/evidence/issues/1652
        date_add(calendar_date, interval 1 day) as display_date,
        "Open" as open,
        "High" as high,
        "Low" as low,
        "Close" as close,
        "Volume" as volume
    
    from {{ source('db', 'test_aapl') }}

)

select * from source