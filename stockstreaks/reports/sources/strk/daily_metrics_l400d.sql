
select *

FROM price_calcs.int_daily_metrics

where calendar_dt >= current_date - 400

order by ticker, calendar_dt