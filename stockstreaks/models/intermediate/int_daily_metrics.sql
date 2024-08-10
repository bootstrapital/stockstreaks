with base_metrics as (

    select 
        ticker,
        calendar_date,
        display_date,
        open,
        high,
        low,
        close,

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
        lead(low, 4) over (partition by ticker order by calendar_date) as next_4_low

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

        -- close to open
        (next_open - close) / close as d1co,
        (next_2_open - close) / close as d2co,
        (next_3_open - close) / close as d3co,
        (next_4_open - close) / close as d4co,

        -- close to close
        (next_close - close) / close as d1cc,
        (next_2_close - close) / close as d2cc,
        (next_3_close - close) / close as d3cc,
        (next_4_close - close) / close as d4cc,

        -- close to high
        (next_high - close) / close as d1ch,
        (next_2_high - close) / close as d2ch,
        (next_3_high - close) / close as d3ch,
        (next_4_high - close) / close as d4ch,

        -- close to low
        (next_low - close) / close as d1cl,
        (next_2_low - close) / close as d2cl,
        (next_3_low - close) / close as d3cl,
        (next_4_low - close) / close as d4cl

    from base_metrics

)

, rolling_counts as (

    -- Counts of days where the metric is greater than 0 (`_pos_`)

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

        -- d1ol
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

        -- d1co
        sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d1co_pos_5d,
        sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d1co_pos_10d,
        sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d1co_pos_20d,
        sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d1co_pos_50d,
        sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d1co_pos_100d,
        sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d1co_pos_200d,
    
        -- d2co
        sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d2co_pos_5d,
        sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d2co_pos_10d,
        sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d2co_pos_20d,
        sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d2co_pos_50d,
        sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d2co_pos_100d,
        sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d2co_pos_200d,

        -- d3co
        sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d3co_pos_5d,
        sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d3co_pos_10d,
        sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d3co_pos_20d,
        sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d3co_pos_50d,
        sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d3co_pos_100d,
        sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d3co_pos_200d,

        -- d4co
        sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d4co_pos_5d,
        sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d4co_pos_10d,
        sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d4co_pos_20d,
        sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d4co_pos_50d,
        sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d4co_pos_100d,
        sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d4co_pos_200d,

        -- d1cc
        sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d1cc_pos_5d,
        sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d1cc_pos_10d,
        sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d1cc_pos_20d,
        sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d1cc_pos_50d,
        sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d1cc_pos_100d,
        sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d1cc_pos_200d,

        -- d2cc
        sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d2cc_pos_5d,
        sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d2cc_pos_10d,
        sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d2cc_pos_20d,
        sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d2cc_pos_50d,
        sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d2cc_pos_100d,
        sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d2cc_pos_200d,

        -- d3cc
        sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d3cc_pos_5d,
        sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d3cc_pos_10d,
        sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d3cc_pos_20d,
        sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d3cc_pos_50d,
        sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d3cc_pos_100d,
        sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d3cc_pos_200d,

        -- d4cc
        sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d4cc_pos_5d,
        sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d4cc_pos_10d,
        sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d4cc_pos_20d,
        sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d4cc_pos_50d,
        sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d4cc_pos_100d,
        sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d4cc_pos_200d,

        -- d1ch
        sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d1ch_pos_5d,
        sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d1ch_pos_10d,
        sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d1ch_pos_20d,
        sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d1ch_pos_50d,
        sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d1ch_pos_100d,
        sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d1ch_pos_200d,

        -- d2ch
        sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d2ch_pos_5d,
        sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d2ch_pos_10d,
        sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d2ch_pos_20d,
        sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d2ch_pos_50d,
        sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d2ch_pos_100d,
        sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d2ch_pos_200d,

        -- d3ch
        sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d3ch_pos_5d,
        sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d3ch_pos_10d,
        sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d3ch_pos_20d,
        sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d3ch_pos_50d,
        sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d3ch_pos_100d,
        sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d3ch_pos_200d,

        -- d4ch
        sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d4ch_pos_5d,
        sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d4ch_pos_10d,
        sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d4ch_pos_20d,
        sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d4ch_pos_50d,
        sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d4ch_pos_100d,
        sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d4ch_pos_200d,

        -- d1cl
        sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d1cl_pos_5d,
        sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d1cl_pos_10d,
        sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d1cl_pos_20d,
        sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d1cl_pos_50d,
        sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d1cl_pos_100d,
        sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d1cl_pos_200d,

        -- d2cl
        sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d2cl_pos_5d,
        sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d2cl_pos_10d,
        sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d2cl_pos_20d,
        sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d2cl_pos_50d,
        sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d2cl_pos_100d,
        sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d2cl_pos_200d,

        -- d3cl
        sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d3cl_pos_5d,
        sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d3cl_pos_10d,
        sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d3cl_pos_20d,
        sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d3cl_pos_50d,
        sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d3cl_pos_100d,
        sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d3cl_pos_200d,

        -- d4cl
        sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 4 preceding and current row) as d4cl_pos_5d,
        sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 9 preceding and current row) as d4cl_pos_10d,
        sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 19 preceding and current row) as d4cl_pos_20d,
        sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 49 preceding and current row) as d4cl_pos_50d,
        sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 99 preceding and current row) as d4cl_pos_100d,
        sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_date rows between 199 preceding and current row) as d4cl_pos_200d

    from interday_metrics

)

, rolling_metrics as (

    select
        ticker,
        calendar_date,

        -- d1oo percentages
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

        -- d1oc percentages
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

        -- d1oh percentages
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

        -- d1co percentages
        d1co_pos_5d / 5.0 as d1co_pct_5d,
        d1co_pos_10d / 10.0 as d1co_pct_10d,
        d1co_pos_20d / 20.0 as d1co_pct_20d,
        d1co_pos_50d / 50.0 as d1co_pct_50d,
        d1co_pos_100d / 100.0 as d1co_pct_100d,
        d1co_pos_200d / 200.0 as d1co_pct_200d,

        -- d2co percentages
        d2co_pos_5d / 5.0 as d2co_pct_5d,
        d2co_pos_10d / 10.0 as d2co_pct_10d,
        d2co_pos_20d / 20.0 as d2co_pct_20d,
        d2co_pos_50d / 50.0 as d2co_pct_50d,
        d2co_pos_100d / 100.0 as d2co_pct_100d,
        d2co_pos_200d / 200.0 as d2co_pct_200d,

        -- d3co percentages
        d3co_pos_5d / 5.0 as d3co_pct_5d,
        d3co_pos_10d / 10.0 as d3co_pct_10d,
        d3co_pos_20d / 20.0 as d3co_pct_20d,
        d3co_pos_50d / 50.0 as d3co_pct_50d,
        d3co_pos_100d / 100.0 as d3co_pct_100d,
        d3co_pos_200d / 200.0 as d3co_pct_200d,

        -- d4co percentages
        d4co_pos_5d / 5.0 as d4co_pct_5d,
        d4co_pos_10d / 10.0 as d4co_pct_10d,
        d4co_pos_20d / 20.0 as d4co_pct_20d,
        d4co_pos_50d / 50.0 as d4co_pct_50d,
        d4co_pos_100d / 100.0 as d4co_pct_100d,
        d4co_pos_200d / 200.0 as d4co_pct_200d,

        -- d1cc percentages
        d1cc_pos_5d / 5.0 as d1cc_pct_5d,
        d1cc_pos_10d / 10.0 as d1cc_pct_10d,
        d1cc_pos_20d / 20.0 as d1cc_pct_20d,
        d1cc_pos_50d / 50.0 as d1cc_pct_50d,
        d1cc_pos_100d / 100.0 as d1cc_pct_100d,
        d1cc_pos_200d / 200.0 as d1cc_pct_200d,

        -- d2cc percentages
        d2cc_pos_5d / 5.0 as d2cc_pct_5d,
        d2cc_pos_10d / 10.0 as d2cc_pct_10d,
        d2cc_pos_20d / 20.0 as d2cc_pct_20d,
        d2cc_pos_50d / 50.0 as d2cc_pct_50d,
        d2cc_pos_100d / 100.0 as d2cc_pct_100d,
        d2cc_pos_200d / 200.0 as d2cc_pct_200d,

        -- d3cc percentages
        d3cc_pos_5d / 5.0 as d3cc_pct_5d,
        d3cc_pos_10d / 10.0 as d3cc_pct_10d,
        d3cc_pos_20d / 20.0 as d3cc_pct_20d,
        d3cc_pos_50d / 50.0 as d3cc_pct_50d,
        d3cc_pos_100d / 100.0 as d3cc_pct_100d,
        d3cc_pos_200d / 200.0 as d3cc_pct_200d,

        -- d4cc percentages
        d4cc_pos_5d / 5.0 as d4cc_pct_5d,
        d4cc_pos_10d / 10.0 as d4cc_pct_10d,
        d4cc_pos_20d / 20.0 as d4cc_pct_20d,
        d4cc_pos_50d / 50.0 as d4cc_pct_50d,
        d4cc_pos_100d / 100.0 as d4cc_pct_100d,
        d4cc_pos_200d / 200.0 as d4cc_pct_200d,

        -- d1ch percentages
        d1ch_pos_5d / 5.0 as d1ch_pct_5d,
        d1ch_pos_10d / 10.0 as d1ch_pct_10d,
        d1ch_pos_20d / 20.0 as d1ch_pct_20d,
        d1ch_pos_50d / 50.0 as d1ch_pct_50d,
        d1ch_pos_100d / 100.0 as d1ch_pct_100d,
        d1ch_pos_200d / 200.0 as d1ch_pct_200d,

        -- d2ch percentages
        d2ch_pos_5d / 5.0 as d2ch_pct_5d,
        d2ch_pos_10d / 10.0 as d2ch_pct_10d,
        d2ch_pos_20d / 20.0 as d2ch_pct_20d,
        d2ch_pos_50d / 50.0 as d2ch_pct_50d,
        d2ch_pos_100d / 100.0 as d2ch_pct_100d,
        d2ch_pos_200d / 200.0 as d2ch_pct_200d,

        -- d3ch percentages
        d3ch_pos_5d / 5.0 as d3ch_pct_5d,
        d3ch_pos_10d / 10.0 as d3ch_pct_10d,
        d3ch_pos_20d / 20.0 as d3ch_pct_20d,
        d3ch_pos_50d / 50.0 as d3ch_pct_50d,
        d3ch_pos_100d / 100.0 as d3ch_pct_100d,
        d3ch_pos_200d / 200.0 as d3ch_pct_200d,

        -- d4ch percentages
        d4ch_pos_5d / 5.0 as d4ch_pct_5d,
        d4ch_pos_10d / 10.0 as d4ch_pct_10d,
        d4ch_pos_20d / 20.0 as d4ch_pct_20d,
        d4ch_pos_50d / 50.0 as d4ch_pct_50d,
        d4ch_pos_100d / 100.0 as d4ch_pct_100d,
        d4ch_pos_200d / 200.0 as d4ch_pct_200d,

        -- d1cl percentages
        d1cl_pos_5d / 5.0 as d1cl_pct_5d,
        d1cl_pos_10d / 10.0 as d1cl_pct_10d,
        d1cl_pos_20d / 20.0 as d1cl_pct_20d,
        d1cl_pos_50d / 50.0 as d1cl_pct_50d,
        d1cl_pos_100d / 100.0 as d1cl_pct_100d,
        d1cl_pos_200d / 200.0 as d1cl_pct_200d,

        -- d2cl percentages
        d2cl_pos_5d / 5.0 as d2cl_pct_5d,
        d2cl_pos_10d / 10.0 as d2cl_pct_10d,
        d2cl_pos_20d / 20.0 as d2cl_pct_20d,
        d2cl_pos_50d / 50.0 as d2cl_pct_50d,
        d2cl_pos_100d / 100.0 as d2cl_pct_100d,
        d2cl_pos_200d / 200.0 as d2cl_pct_200d,

        -- d3cl percentages
        d3cl_pos_5d / 5.0 as d3cl_pct_5d,
        d3cl_pos_10d / 10.0 as d3cl_pct_10d,
        d3cl_pos_20d / 20.0 as d3cl_pct_20d,
        d3cl_pos_50d / 50.0 as d3cl_pct_50d,
        d3cl_pos_100d / 100.0 as d3cl_pct_100d,
        d3cl_pos_200d / 200.0 as d3cl_pct_200d,

        -- d4cl percentages
        d4cl_pos_5d / 5.0 as d4cl_pct_5d,
        d4cl_pos_10d / 10.0 as d4cl_pct_10d,
        d4cl_pos_20d / 20.0 as d4cl_pct_20d,
        d4cl_pos_50d / 50.0 as d4cl_pct_50d,
        d4cl_pos_100d / 100.0 as d4cl_pct_100d,
        d4cl_pos_200d / 200.0 as d4cl_pct_200d

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