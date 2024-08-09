with base_metrics as (

    select 
        ticker,
        calendar_date,
        display_date,
        open,
        high,
        low,
        close,
        adj_open,
        adj_high,
        adj_low,
        adj_close,

        -- time-based attributes
        extract('dow' from calendar_date) as day_of_week,
        extract('dayofyear' from calendar_date) as day_of_year,
        extract('week' from calendar_date) as week_of_year,
        extract('month' from calendar_date) as month,
        extract('quarter' from calendar_date) as quarter,

        -- lead functions
        lead(open, 1) over (partition by ticker order by calendar_date) as next_open,
        lead(open, 2) over (partition by ticker order by calendar_date) as next_2_open,
        lead(open, 3) over (partition by ticker order by calendar_date) as next_3_open,
        lead(open, 4) over (partition by ticker order by calendar_date) as next_4_open,

        lead(close, 1) over (partition by ticker order by calendar_date) as next_close,
        lead(close, 2) over (partition by ticker order by calendar_date) as next_2_close,
        lead(close, 3) over (partition by ticker order by calendar_date) as next_3_close,
        lead(close, 4) over (partition by ticker order by calendar_date) as next_4_close,

        lead(high, 1) over (partition by ticker order by calendar_date) as next_high,
        lead(high, 2) over (partition by ticker order by calendar_date) as next_2_high,
        lead(high, 3) over (partition by ticker order by calendar_date) as next_3_high,
        lead(high, 4) over (partition by ticker order by calendar_date) as next_4_high,

        lead(low, 1) over (partition by ticker order by calendar_date) as next_low,
        lead(low, 2) over (partition by ticker order by calendar_date) as next_2_low,
        lead(low, 3) over (partition by ticker order by calendar_date) as next_3_low,
        lead(low, 4) over (partition by ticker order by calendar_date) as next_4_low,

        lead(adj_open, 1) over (partition by ticker order by calendar_date) as next_adj_open,
        lead(adj_open, 2) over (partition by ticker order by calendar_date) as next_2_adj_open,
        lead(adj_open, 3) over (partition by ticker order by calendar_date) as next_3_adj_open,
        lead(adj_open, 4) over (partition by ticker order by calendar_date) as next_4_adj_open,

        lead(adj_close, 1) over (partition by ticker order by calendar_date) as next_adj_close,
        lead(adj_close, 2) over (partition by ticker order by calendar_date) as next_2_adj_close,
        lead(adj_close, 3) over (partition by ticker order by calendar_date) as next_3_adj_close,
        lead(adj_close, 4) over (partition by ticker order by calendar_date) as next_4_adj_close,

        lead(adj_high, 1) over (partition by ticker order by calendar_date) as next_adj_high,
        lead(adj_high, 2) over (partition by ticker order by calendar_date) as next_2_adj_high,
        lead(adj_high, 3) over (partition by ticker order by calendar_date) as next_3_adj_high,
        lead(adj_high, 4) over (partition by ticker order by calendar_date) as next_4_adj_high,

        lead(adj_low, 1) over (partition by ticker order by calendar_date) as next_adj_low,
        lead(adj_low, 2) over (partition by ticker order by calendar_date) as next_2_adj_low,
        lead(adj_low, 3) over (partition by ticker order by calendar_date) as next_3_adj_low,
        lead(adj_low, 4) over (partition by ticker order by calendar_date) as next_4_adj_low 

    from {{ ref('stg_daily_prices') }}

)

, interday_metrics as (

    select
        ticker,
        calendar_date,

        -- open to open
        (next_open - open) / open as d1oo,
        (next_2_open - open) / open as d2oo,
        (next_3_open - open) / open as d3oo,
        (next_4_open - open) / open as d4oo,

        -- open to close
        (next_close - open) / open as d1oc,
        (next_2_close - open) / open as d2oc,
        (next_3_close - open) / open as d3oc,
        (next_4_close - open) / open as d4oc,

        -- open to high
        (next_high - open) / open as d1oh,
        (next_2_high - open) / open as d2oh,
        (next_3_high - open) / open as d3oh,
        (next_4_high - open) / open as d4oh,

        -- open to low
        (next_low - open) / open as d1ol,
        (next_2_low - open) / open as d2ol,
        (next_3_low - open) / open as d3ol,
        (next_4_low - open) / open as d4ol,

        -- aopen to aopen
        (next_adj_open - adj_open) / adj_open as a_d1oo,
        (next_2_adj_open - adj_open) / adj_open as a_d2oo,
        (next_3_adj_open - adj_open) / adj_open as a_d3oo,
        (next_4_adj_open - adj_open) / adj_open as a_d4oo,

        -- aopen to aclose
        (next_adj_close - adj_open) / adj_open as a_d1oc,
        (next_2_adj_close - adj_open) / adj_open as a_d2oc,
        (next_3_adj_close - adj_open) / adj_open as a_d3oc,
        (next_4_adj_close - adj_open) / adj_open as a_d4oc,

        -- aopen to ahigh
        (next_adj_high - adj_open) / adj_open as a_d1oh,
        (next_2_adj_high - adj_open) / adj_open as a_d2oh,
        (next_3_adj_high - adj_open) / adj_open as a_d3oh,
        (next_4_adj_high - adj_open) / adj_open as a_d4oh,

        -- aopen to alow
        (next_adj_low - adj_open) / adj_open as a_d1ol,
        (next_2_adj_low - adj_open) / adj_open as a_d2ol,
        (next_3_adj_low - adj_open) / adj_open as a_d3ol,
        (next_4_adj_low - adj_open) / adj_open as a_d4ol

    from base_metrics

)

, rolling_counts as (

    select
        ticker,
        calendar_date,

        -- d1oo
        sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d1oo_pos_5d,
        sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d1oo_pos_10d,
        sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d1oo_pos_20d,
        sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d1oo_pos_50d,
        sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d1oo_pos_100d,
        sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d1oo_pos_200d,
       
        -- d2oo
        sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d2oo_pos_5d,
        sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d2oo_pos_10d,
        sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d2oo_pos_20d,
        sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d2oo_pos_50d,
        sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d2oo_pos_100d,
        sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d2oo_pos_200d,
        
        -- d3oo
        sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d3oo_pos_5d,
        sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d3oo_pos_10d,
        sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d3oo_pos_20d,
        sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d3oo_pos_50d,
        sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d3oo_pos_100d,
        sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d3oo_pos_200d,

        -- d4oo
        sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d4oo_pos_5d,
        sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d4oo_pos_10d,
        sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d4oo_pos_20d,
        sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d4oo_pos_50d,
        sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d4oo_pos_100d,
        sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d4oo_pos_200d,

        --a d1oc
        sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d1oc_pos_5d,
        sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d1oc_pos_10d,
        sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d1oc_pos_20d,
        sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d1oc_pos_50d,
        sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d1oc_pos_100d,
        sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d1oc_pos_200d,

        -- d2oc
        sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d2oc_pos_5d,
        sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d2oc_pos_10d,
        sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d2oc_pos_20d,
        sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d2oc_pos_50d,
        sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d2oc_pos_100d,
        sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d2oc_pos_200d,

        -- d3oc
        sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d3oc_pos_5d,
        sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d3oc_pos_10d,
        sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d3oc_pos_20d,
        sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d3oc_pos_50d,
        sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d3oc_pos_100d,
        sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d3oc_pos_200d, 

        -- d4oc
        sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d4oc_pos_5d,
        sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d4oc_pos_10d,
        sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d4oc_pos_20d,
        sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d4oc_pos_50d,
        sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d4oc_pos_100d,
        sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d4oc_pos_200d,

        -- d1oh
        sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d1oh_pos_5d,
        sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d1oh_pos_10d,
        sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d1oh_pos_20d,
        sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d1oh_pos_50d,
        sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d1oh_pos_100d,
        sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d1oh_pos_200d,

        -- d2oh
        sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d2oh_pos_5d,
        sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d2oh_pos_10d,
        sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d2oh_pos_20d,
        sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d2oh_pos_50d,
        sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d2oh_pos_100d,
        sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d2oh_pos_200d,

        -- d3oh
        sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d3oh_pos_5d,
        sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d3oh_pos_10d,
        sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d3oh_pos_20d,
        sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d3oh_pos_50d,
        sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d3oh_pos_100d,
        sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d3oh_pos_200d, 

        -- d4oh
        sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d4oh_pos_5d,
        sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d4oh_pos_10d,
        sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d4oh_pos_20d,
        sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d4oh_pos_50d,
        sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d4oh_pos_100d,
        sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d4oh_pos_200d,

        --a d1ol
        sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d1ol_pos_5d,
        sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d1ol_pos_10d,
        sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d1ol_pos_20d,
        sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d1ol_pos_50d,
        sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d1ol_pos_100d,
        sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d1ol_pos_200d,

        -- d2ol
        sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d2ol_pos_5d,
        sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d2ol_pos_10d,
        sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d2ol_pos_20d,
        sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d2ol_pos_50d,
        sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d2ol_pos_100d,
        sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d2ol_pos_200d,

        -- d3ol
        sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d3ol_pos_5d,
        sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d3ol_pos_10d,
        sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d3ol_pos_20d,
        sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d3ol_pos_50d,
        sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d3ol_pos_100d,
        sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d3ol_pos_200d,

        -- d4ol
        sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d4ol_pos_5d,
        sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d4ol_pos_10d,
        sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d4ol_pos_20d,
        sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d4ol_pos_50d,
        sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d4ol_pos_100d,
        sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d4ol_pos_200d,

        -- a_d1oo
        sum(case when a_d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d1oo_pos_5d,
        sum(case when a_d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d1oo_pos_10d,
        sum(case when a_d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d1oo_pos_20d,
        sum(case when a_d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d1oo_pos_50d,
        sum(case when a_d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d1oo_pos_100d,
        sum(case when a_d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d1oo_pos_200d,

        -- a_d2oo
        sum(case when a_d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d2oo_pos_5d,
        sum(case when a_d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d2oo_pos_10d,
        sum(case when a_d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d2oo_pos_20d,
        sum(case when a_d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d2oo_pos_50d,
        sum(case when a_d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d2oo_pos_100d,
        sum(case when a_d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d2oo_pos_200d,

        -- a_d3oo
        sum(case when a_d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d3oo_pos_5d,
        sum(case when a_d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d3oo_pos_10d,
        sum(case when a_d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d3oo_pos_20d,
        sum(case when a_d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d3oo_pos_50d,        
        sum(case when a_d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d3oo_pos_100d,
        sum(case when a_d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d3oo_pos_200d,

        -- a_d4oo
        sum(case when a_d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d4oo_pos_5d,
        sum(case when a_d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d4oo_pos_10d,
        sum(case when a_d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d4oo_pos_20d,        
        sum(case when a_d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d4oo_pos_50d,        
        sum(case when a_d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d4oo_pos_100d,
        sum(case when a_d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d4oo_pos_200d,

        -- a_d1oc
        sum(case when a_d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d1oc_pos_5d,
        sum(case when a_d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d1oc_pos_10d,
        sum(case when a_d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d1oc_pos_20d,        
        sum(case when a_d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d1oc_pos_50d,        
        sum(case when a_d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d1oc_pos_100d,
        sum(case when a_d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d1oc_pos_200d,

        -- a_d2oc
        sum(case when a_d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d2oc_pos_5d,        
        sum(case when a_d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d2oc_pos_10d,
        sum(case when a_d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d2oc_pos_20d,        
        sum(case when a_d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d2oc_pos_50d,        
        sum(case when a_d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d2oc_pos_100d,
        sum(case when a_d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d2oc_pos_200d,

        -- a_d3oc
        sum(case when a_d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d3oc_pos_5d,        
        sum(case when a_d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d3oc_pos_10d,
        sum(case when a_d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d3oc_pos_20d,        
        sum(case when a_d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d3oc_pos_50d,        
        sum(case when a_d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d3oc_pos_100d,
        sum(case when a_d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d3oc_pos_200d,

        -- a_d4oc
        sum(case when a_d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d4oc_pos_5d,        
        sum(case when a_d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d4oc_pos_10d,
        sum(case when a_d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d4oc_pos_20d,        
        sum(case when a_d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d4oc_pos_50d,        
        sum(case when a_d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d4oc_pos_100d,
        sum(case when a_d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d4oc_pos_200d,

        -- a_d1oh
        sum(case when a_d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d1oh_pos_5d,  
        sum(case when a_d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d1oh_pos_10d,
        sum(case when a_d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d1oh_pos_20d,        
        sum(case when a_d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d1oh_pos_50d,        
        sum(case when a_d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d1oh_pos_100d,
        sum(case when a_d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d1oh_pos_200d,

        -- a_d2oh
        sum(case when a_d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d2oh_pos_5d,        
        sum(case when a_d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d2oh_pos_10d,
        sum(case when a_d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d2oh_pos_20d,        
        sum(case when a_d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d2oh_pos_50d,        
        sum(case when a_d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d2oh_pos_100d,
        sum(case when a_d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d2oh_pos_200d,

        -- a_d3oh
        sum(case when a_d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d3oh_pos_5d,        
        sum(case when a_d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d3oh_pos_10d,
        sum(case when a_d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d3oh_pos_20d,        
        sum(case when a_d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d3oh_pos_50d,        
        sum(case when a_d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d3oh_pos_100d,
        sum(case when a_d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d3oh_pos_200d,

        -- a_d4oh
        sum(case when a_d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d4oh_pos_5d,
        sum(case when a_d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d4oh_pos_10d,
        sum(case when a_d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d4oh_pos_20d,
        sum(case when a_d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d4oh_pos_50d,
        sum(case when a_d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d4oh_pos_100d,
        sum(case when a_d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d4oh_pos_200d,

        -- a_d1ol
        sum(case when a_d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d1ol_pos_5d,
        sum(case when a_d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d1ol_pos_10d,
        sum(case when a_d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d1ol_pos_20d,
        sum(case when a_d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d1ol_pos_50d,
        sum(case when a_d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d1ol_pos_100d,
        sum(case when a_d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d1ol_pos_200d,

        -- a_d2ol
        sum(case when a_d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d2ol_pos_5d,
        sum(case when a_d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d2ol_pos_10d,
        sum(case when a_d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d2ol_pos_20d,
        sum(case when a_d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d2ol_pos_50d,
        sum(case when a_d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d2ol_pos_100d,
        sum(case when a_d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d2ol_pos_200d,

        -- a_d3ol
        sum(case when a_d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d3ol_pos_5d,
        sum(case when a_d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d3ol_pos_10d,
        sum(case when a_d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d3ol_pos_20d,
        sum(case when a_d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d3ol_pos_50d,
        sum(case when a_d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d3ol_pos_100d,
        sum(case when a_d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d3ol_pos_200d,

        -- a_d4ol
        sum(case when a_d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as a_d4ol_pos_5d,
        sum(case when a_d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as a_d4ol_pos_10d,
        sum(case when a_d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as a_d4ol_pos_20d,
        sum(case when a_d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as a_d4ol_pos_50d,
        sum(case when a_d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as a_d4ol_pos_100d,
        sum(case when a_d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as a_d4ol_pos_200d

    from interday_metrics

)

, rolling_metrics as (

    select
        ticker,
        calendar_date,

        --a d1oo percentages
        d1oo_pos_5d / 5.0 as d1oo_pct_5d,
        d1oo_pos_10d / 10.0 as d1oo_pct_10d,
        d1oo_pos_20d / 20.0 as d1oo_pct_20d,
        d1oo_pos_50d / 50.0 as d1oo_pct_50d,
        d1oo_pos_100d / 100.0 as d1oo_pct_100d,
        d1oo_pos_200d / 200.0 as d1oo_pct_200d,

        -- d2oo percentages
        d2oo_pos_5d / 5.0 as d2oo_pct_5d,
        d2oo_pos_10d / 10.0 as d2oo_pct_10d,
        d2oo_pos_20d / 20.0 as d2oo_pct_20d,
        d2oo_pos_50d / 50.0 as d2oo_pct_50d,
        d2oo_pos_100d / 100.0 as d2oo_pct_100d,
        d2oo_pos_200d / 200.0 as d2oo_pct_200d,

        -- d3oo percentages
        d3oo_pos_5d / 5.0 as d3oo_pct_5d,
        d3oo_pos_10d / 10.0 as d3oo_pct_10d,
        d3oo_pos_20d / 20.0 as d3oo_pct_20d,
        d3oo_pos_50d / 50.0 as d3oo_pct_50d,
        d3oo_pos_100d / 100.0 as d3oo_pct_100d,
        d3oo_pos_200d / 200.0 as d3oo_pct_200d,

        -- d4oo percentages
        d4oo_pos_5d / 5.0 as d4oo_pct_5d,
        d4oo_pos_10d / 10.0 as d4oo_pct_10d,
        d4oo_pos_20d / 20.0 as d4oo_pct_20d,
        d4oo_pos_50d / 50.0 as d4oo_pct_50d,
        d4oo_pos_100d / 100.0 as d4oo_pct_100d,
        d4oo_pos_200d / 200.0 as d4oo_pct_200d,

        --a d1oc percentages
        d1oc_pos_5d / 5.0 as d1oc_pct_5d,
        d1oc_pos_10d / 10.0 as d1oc_pct_10d,
        d1oc_pos_20d / 20.0 as d1oc_pct_20d,
        d1oc_pos_50d / 50.0 as d1oc_pct_50d,
        d1oc_pos_100d / 100.0 as d1oc_pct_100d,
        d1oc_pos_200d / 200.0 as d1oc_pct_200d,

        -- d2oc percentages
        d2oc_pos_5d / 5.0 as d2oc_pct_5d,
        d2oc_pos_10d / 10.0 as d2oc_pct_10d,
        d2oc_pos_20d / 20.0 as d2oc_pct_20d,
        d2oc_pos_50d / 50.0 as d2oc_pct_50d,
        d2oc_pos_100d / 100.0 as d2oc_pct_100d,
        d2oc_pos_200d / 200.0 as d2oc_pct_200d,

        -- d3oc percentages
        d3oc_pos_5d / 5.0 as d3oc_pct_5d,
        d3oc_pos_10d / 10.0 as d3oc_pct_10d,
        d3oc_pos_20d / 20.0 as d3oc_pct_20d,
        d3oc_pos_50d / 50.0 as d3oc_pct_50d,
        d3oc_pos_100d / 100.0 as d3oc_pct_100d,
        d3oc_pos_200d / 200.0 as d3oc_pct_200d,

        -- d4oc percentages
        d4oc_pos_5d / 5.0 as d4oc_pct_5d,
        d4oc_pos_10d / 10.0 as d4oc_pct_10d,
        d4oc_pos_20d / 20.0 as d4oc_pct_20d,
        d4oc_pos_50d / 50.0 as d4oc_pct_50d,
        d4oc_pos_100d / 100.0 as d4oc_pct_100d,
        d4oc_pos_200d / 200.0 as d4oc_pct_200d,

        --a d1oh percentages
       d1oh_pos_5d / 5.0 as d1oh_pct_5d,
       d1oh_pos_10d / 10.0 as d1oh_pct_10d,
       d1oh_pos_20d / 20.0 as d1oh_pct_20d,
       d1oh_pos_50d / 50.0 as d1oh_pct_50d,
       d1oh_pos_100d / 100.0 as d1oh_pct_100d,
       d1oh_pos_200d / 200.0 as d1oh_pct_200d,

        -- d2oh percentages
        d2oh_pos_5d / 5.0 as d2oh_pct_5d,
        d2oh_pos_10d / 10.0 as d2oh_pct_10d,
        d2oh_pos_20d / 20.0 as d2oh_pct_20d,
        d2oh_pos_50d / 50.0 as d2oh_pct_50d,
        d2oh_pos_100d / 100.0 as d2oh_pct_100d,
        d2oh_pos_200d / 200.0 as d2oh_pct_200d,

        -- d3oh percentages
        d3oh_pos_5d / 5.0 as d3oh_pct_5d,
        d3oh_pos_10d / 10.0 as d3oh_pct_10d,
        d3oh_pos_20d / 20.0 as d3oh_pct_20d,
        d3oh_pos_50d / 50.0 as d3oh_pct_50d,
        d3oh_pos_100d / 100.0 as d3oh_pct_100d,
        d3oh_pos_200d / 200.0 as d3oh_pct_200d,

        -- d4oh percentages
        d4oh_pos_5d / 5.0 as d4oh_pct_5d,
        d4oh_pos_10d / 10.0 as d4oh_pct_10d,
        d4oh_pos_20d / 20.0 as d4oh_pct_20d,
        d4oh_pos_50d / 50.0 as d4oh_pct_50d,
        d4oh_pos_100d / 100.0 as d4oh_pct_100d,
        d4oh_pos_200d / 200.0 as d4oh_pct_200d,

        -- d1ol percentages
       d1ol_pos_5d / 5.0 as d1ol_pct_5d,
       d1ol_pos_10d / 10.0 as d1ol_pct_10d,
       d1ol_pos_20d / 20.0 as d1ol_pct_20d,
       d1ol_pos_50d / 50.0 as d1ol_pct_50d,
       d1ol_pos_100d / 100.0 as d1ol_pct_100d,
       d1ol_pos_200d / 200.0 as d1ol_pct_200d,

        -- d2ol percentages
        d2ol_pos_5d / 5.0 as d2ol_pct_5d,
        d2ol_pos_10d / 10.0 as d2ol_pct_10d,
        d2ol_pos_20d / 20.0 as d2ol_pct_20d,
        d2ol_pos_50d / 50.0 as d2ol_pct_50d,
        d2ol_pos_100d / 100.0 as d2ol_pct_100d,
        d2ol_pos_200d / 200.0 as d2ol_pct_200d,

        -- d3ol percentages
        d3ol_pos_5d / 5.0 as d3ol_pct_5d,
        d3ol_pos_10d / 10.0 as d3ol_pct_10d,
        d3ol_pos_20d / 20.0 as d3ol_pct_20d,
        d3ol_pos_50d / 50.0 as d3ol_pct_50d,
        d3ol_pos_100d / 100.0 as d3ol_pct_100d,
        d3ol_pos_200d / 200.0 as d3ol_pct_200d,

        -- d4ol percentages
        d4ol_pos_5d / 5.0 as d4ol_pct_5d,
        d4ol_pos_10d / 10.0 as d4ol_pct_10d,
        d4ol_pos_20d / 20.0 as d4ol_pct_20d,
        d4ol_pos_50d / 50.0 as d4ol_pct_50d,
        d4ol_pos_100d / 100.0 as d4ol_pct_100d,
        d4ol_pos_200d / 200.0 as d4ol_pct_200d,

        -- a_d1oo percentages
        a_d1oo_pos_5d / 5.0 as a_d1oo_pct_5d,
        a_d1oo_pos_10d / 10.0 as a_d1oo_pct_10d,
        a_d1oo_pos_20d / 20.0 as a_d1oo_pct_20d,
        a_d1oo_pos_50d / 50.0 as a_d1oo_pct_50d,
        a_d1oo_pos_100d / 100.0 as a_d1oo_pct_100d,
        a_d1oo_pos_200d / 200.0 as a_d1oo_pct_200d,

        -- a_d2oo percentages
        a_d2oo_pos_5d / 5.0 as a_d2oo_pct_5d,
        a_d2oo_pos_10d / 10.0 as a_d2oo_pct_10d,
        a_d2oo_pos_20d / 20.0 as a_d2oo_pct_20d,
        a_d2oo_pos_50d / 50.0 as a_d2oo_pct_50d,        
        a_d2oo_pos_100d / 100.0 as a_d2oo_pct_100d,        
        a_d2oo_pos_200d / 200.0 as a_d2oo_pct_200d,

        -- a_d3oo percentages
        a_d3oo_pos_5d / 5.0 as a_d3oo_pct_5d,
        a_d3oo_pos_10d / 10.0 as a_d3oo_pct_10d,
        a_d3oo_pos_20d / 20.0 as a_d3oo_pct_20d,
        a_d3oo_pos_50d / 50.0 as a_d3oo_pct_50d,
        a_d3oo_pos_100d / 100.0 as a_d3oo_pct_100d,
        a_d3oo_pos_200d / 200.0 as a_d3oo_pct_200d,

        -- a_d4oo percentages
        a_d4oo_pos_5d / 5.0 as a_d4oo_pct_5d,
        a_d4oo_pos_10d / 10.0 as a_d4oo_pct_10d,
        a_d4oo_pos_20d / 20.0 as a_d4oo_pct_20d,
        a_d4oo_pos_50d / 50.0 as a_d4oo_pct_50d,
        a_d4oo_pos_100d / 100.0 as a_d4oo_pct_100d,
        a_d4oo_pos_200d / 200.0 as a_d4oo_pct_200d,

        -- a_d1oc percentages
        a_d1oc_pos_5d / 5.0 as a_d1oc_pct_5d,
        a_d1oc_pos_10d / 10.0 as a_d1oc_pct_10d,
        a_d1oc_pos_20d / 20.0 as a_d1oc_pct_20d,
        a_d1oc_pos_50d / 50.0 as a_d1oc_pct_50d,
        a_d1oc_pos_100d / 100.0 as a_d1oc_pct_100d,
        a_d1oc_pos_200d / 200.0 as a_d1oc_pct_200d,

        -- a_d2oc percentages
        a_d2oc_pos_5d / 5.0 as a_d2oc_pct_5d,
        a_d2oc_pos_10d / 10.0 as a_d2oc_pct_10d,
        a_d2oc_pos_20d / 20.0 as a_d2oc_pct_20d,
        a_d2oc_pos_50d / 50.0 as a_d2oc_pct_50d,
        a_d2oc_pos_100d / 100.0 as a_d2oc_pct_100d,
        a_d2oc_pos_200d / 200.0 as a_d2oc_pct_200d,

        -- a_d3oc percentages
        a_d3oc_pos_5d / 5.0 as a_d3oc_pct_5d,
        a_d3oc_pos_10d / 10.0 as a_d3oc_pct_10d,
        a_d3oc_pos_20d / 20.0 as a_d3oc_pct_20d,
        a_d3oc_pos_50d / 50.0 as a_d3oc_pct_50d,
        a_d3oc_pos_100d / 100.0 as a_d3oc_pct_100d,
        a_d3oc_pos_200d / 200.0 as a_d3oc_pct_200d,

        -- a_d4oc percentages
        a_d4oc_pos_5d / 5.0 as a_d4oc_pct_5d,
        a_d4oc_pos_10d / 10.0 as a_d4oc_pct_10d,
        a_d4oc_pos_20d / 20.0 as a_d4oc_pct_20d,
        a_d4oc_pos_50d / 50.0 as a_d4oc_pct_50d,        
        a_d4oc_pos_100d / 100.0 as a_d4oc_pct_100d,
        a_d4oc_pos_200d / 200.0 as a_d4oc_pct_200d,

        -- a_d1oh percentages
        a_d1oh_pos_5d / 5.0 as a_d1oh_pct_5d,
        a_d1oh_pos_10d / 10.0 as a_d1oh_pct_10d,
        a_d1oh_pos_20d / 20.0 as a_d1oh_pct_20d,
        a_d1oh_pos_50d / 50.0 as a_d1oh_pct_50d,
        a_d1oh_pos_100d / 100.0 as a_d1oh_pct_100d,
        a_d1oh_pos_200d / 200.0 as a_d1oh_pct_200d,

        -- a_d2oh percentages
        a_d2oh_pos_5d / 5.0 as a_d2oh_pct_5d,
        a_d2oh_pos_10d / 10.0 as a_d2oh_pct_10d,
        a_d2oh_pos_20d / 20.0 as a_d2oh_pct_20d,
        a_d2oh_pos_50d / 50.0 as a_d2oh_pct_50d,        
        a_d2oh_pos_100d / 100.0 as a_d2oh_pct_100d,        
        a_d2oh_pos_200d / 200.0 as a_d2oh_pct_200d,

        -- a_d3oh percentages
        a_d3oh_pos_5d / 5.0 as a_d3oh_pct_5d,
        a_d3oh_pos_10d / 10.0 as a_d3oh_pct_10d,
        a_d3oh_pos_20d / 20.0 as a_d3oh_pct_20d,
        a_d3oh_pos_50d / 50.0 as a_d3oh_pct_50d,
        a_d3oh_pos_100d / 100.0 as a_d3oh_pct_100d,
        a_d3oh_pos_200d / 200.0 as a_d3oh_pct_200d,

        -- a_d4oh percentages
        a_d4oh_pos_5d / 5.0 as a_d4oh_pct_5d,
        a_d4oh_pos_10d / 10.0 as a_d4oh_pct_10d,
        a_d4oh_pos_20d / 20.0 as a_d4oh_pct_20d,
        a_d4oh_pos_50d / 50.0 as a_d4oh_pct_50d,        
        a_d4oh_pos_100d / 100.0 as a_d4oh_pct_100d,
        a_d4oh_pos_200d / 200.0 as a_d4oh_pct_200d,

        -- a_d1ol percentages
        a_d1ol_pos_5d / 5.0 as a_d1ol_pct_5d,
        a_d1ol_pos_10d / 10.0 as a_d1ol_pct_10d,
        a_d1ol_pos_20d / 20.0 as a_d1ol_pct_20d,
        a_d1ol_pos_50d / 50.0 as a_d1ol_pct_50d,
        a_d1ol_pos_100d / 100.0 as a_d1ol_pct_100d,
        a_d1ol_pos_200d / 200.0 as a_d1ol_pct_200d,

        -- a_d2ol percentages
        a_d2ol_pos_5d / 5.0 as a_d2ol_pct_5d,
        a_d2ol_pos_10d / 10.0 as a_d2ol_pct_10d,
        a_d2ol_pos_20d / 20.0 as a_d2ol_pct_20d,
        a_d2ol_pos_50d / 50.0 as a_d2ol_pct_50d,
        a_d2ol_pos_100d / 100.0 as a_d2ol_pct_100d,
        a_d2ol_pos_200d / 200.0 as a_d2ol_pct_200d,

        -- a_d3ol percentages
        a_d3ol_pos_5d / 5.0 as a_d3ol_pct_5d,
        a_d3ol_pos_10d / 10.0 as a_d3ol_pct_10d,
        a_d3ol_pos_20d / 20.0 as a_d3ol_pct_20d,
        a_d3ol_pos_50d / 50.0 as a_d3ol_pct_50d,
        a_d3ol_pos_100d / 100.0 as a_d3ol_pct_100d,
        a_d3ol_pos_200d / 200.0 as a_d3ol_pct_200d,

        -- a_d4ol percentages        
        a_d4ol_pos_5d / 5.0 as a_d4ol_pct_5d,
        a_d4ol_pos_10d / 10.0 as a_d4ol_pct_10d,
        a_d4ol_pos_20d / 20.0 as a_d4ol_pct_20d,
        a_d4ol_pos_50d / 50.0 as a_d4ol_pct_50d,
        a_d4ol_pos_100d / 100.0 as a_d4ol_pct_100d,
        a_d4ol_pos_200d / 200.0 as a_d4ol_pct_200d

    from rolling_counts

)

select
    base_metrics.*,
    interday_metrics.* exclude (ticker, calendar_date),
    rolling_counts.* exclude (ticker, calendar_date),
    rolling_metrics.* exclude (ticker, calendar_date)
    
from base_metrics
    left join interday_metrics using (ticker, calendar_date)
    left join rolling_counts using (ticker, calendar_date)
    left join rolling_metrics using (ticker, calendar_date)

order by ticker, calendar_date