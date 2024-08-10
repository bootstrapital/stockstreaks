with raw_data as (

    select 
        * 
        , row_number() over (partition by ticker order by calendar_date desc) as row_num

    from price_calcs.int_daily_metrics

)

select *

FROM raw_data

where row_num <= 200

order by ticker, calendar_date