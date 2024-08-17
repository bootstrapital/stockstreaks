with base_metrics as (

    select 
        ticker
        , calendar_dt
        , open
        , high
        , low
        , close
        , volume

        -- time-based attributes
        , date_part('day', calendar_dt) as day_of_month
        , date_part('dayofyear', calendar_dt) as day_of_year
        , date_part('week', calendar_dt) as week_of_year

        , date_part('dow', calendar_dt) as day_of_week_num -- Monday is 1
        , strftime(calendar_dt, '%A') as day_of_week_name
        , strftime(calendar_dt, '%a') as day_of_week_short

        , lead(calendar_dt, 1) over (partition by ticker order by calendar_dt desc) as yday1_date
        , date_part('dow', yday1_date) as yday1_num
        , strftime(yday1_date, '%A') as yday1_name
        , strftime(yday1_date, '%a') as yday1_shortname

        , lead(calendar_dt, 2) over (partition by ticker order by calendar_dt desc) as yday2_date
        , date_part('dow', yday2_date) as yday2_num
        , strftime(yday2_date, '%A') as yday2_name
        , strftime(yday2_date, '%a') as yday2_shortname

        , lead(calendar_dt, 3) over (partition by ticker order by calendar_dt desc) as yday3_date
        , date_part('dow', yday3_date) as yday3_num
        , strftime(yday3_date, '%A') as yday3_name
        , strftime(yday3_date, '%a') as yday3_shortname

        , lead(calendar_dt, 4) over (partition by ticker order by calendar_dt desc) as yday4_date
        , date_part('dow', yday4_date) as yday4_num
        , strftime(yday4_date, '%A') as yday4_name
        , strftime(yday4_date, '%a') as yday4_shortname

        , lead(calendar_dt, 5) over (partition by ticker order by calendar_dt desc) as yday5_date
        , date_part('dow', yday5_date) as yday5_num
        , strftime(yday5_date, '%A') as yday5_name
        , strftime(yday5_date, '%a') as yday5_shortname

        , date_trunc('week', calendar_dt) as week_start
        , date_trunc('month', calendar_dt) as month_start
        , strftime(date_trunc('week', calendar_dt), '%Y %b %d') as week_start_display
        , strftime(date_trunc('month', calendar_dt), '%Y %b %d') as month_start_display

        -- lead functions
        -- We want to use current row as "today" and compare it to the previous row (when sorting desc)
        , lead(open, 1) over (partition by ticker order by calendar_dt desc) as yday1_open
        , lead(open, 2) over (partition by ticker order by calendar_dt desc) as yday2_open
        , lead(open, 3) over (partition by ticker order by calendar_dt desc) as yday3_open
        , lead(open, 4) over (partition by ticker order by calendar_dt desc) as yday4_open
        , lead(open, 5) over (partition by ticker order by calendar_dt desc) as yday5_open

        , lead(close, 1) over (partition by ticker order by calendar_dt desc) as yday1_close
        , lead(close, 2) over (partition by ticker order by calendar_dt desc) as yday2_close
        , lead(close, 3) over (partition by ticker order by calendar_dt desc) as yday3_close
        , lead(close, 4) over (partition by ticker order by calendar_dt desc) as yday4_close
        , lead(close, 5) over (partition by ticker order by calendar_dt desc) as yday5_close

        , lead(high, 1) over (partition by ticker order by calendar_dt desc) as yday1_high
        , lead(high, 2) over (partition by ticker order by calendar_dt desc) as yday2_high
        , lead(high, 3) over (partition by ticker order by calendar_dt desc) as yday3_high
        , lead(high, 4) over (partition by ticker order by calendar_dt desc) as yday4_high
        , lead(high, 5) over (partition by ticker order by calendar_dt desc) as yday5_high

        , lead(low, 1) over (partition by ticker order by calendar_dt desc) as yday1_low
        , lead(low, 2) over (partition by ticker order by calendar_dt desc) as yday2_low
        , lead(low, 3) over (partition by ticker order by calendar_dt desc) as yday3_low
        , lead(low, 4) over (partition by ticker order by calendar_dt desc) as yday4_low
        , lead(low, 5) over (partition by ticker order by calendar_dt desc) as yday5_low

        , lead(volume, 1) over (partition by ticker order by calendar_dt desc) as yday1_volume
        , lead(volume, 2) over (partition by ticker order by calendar_dt desc) as yday2_volume
        , lead(volume, 3) over (partition by ticker order by calendar_dt desc) as yday3_volume
        , lead(volume, 4) over (partition by ticker order by calendar_dt desc) as yday4_volume
        , lead(volume, 5) over (partition by ticker order by calendar_dt desc) as yday5_volume

        , volume - yday1_volume as yday1_volume_diff
        , volume - yday2_volume as yday2_volume_diff
        , volume - yday3_volume as yday3_volume_diff
        , volume - yday4_volume as yday4_volume_diff
        , volume - yday5_volume as yday5_volume_diff

    from {{ ref('stg_daily_prices') }}

    order by ticker, calendar_dt desc

)

, interday_performance as (

    select
        ticker
        , calendar_dt

        -- open to open
        , open / yday1_open - 1 as d1oo
        , open / yday2_open - 1 as d2oo
        , open / yday3_open - 1 as d3oo
        , open / yday4_open - 1 as d4oo
        , open / yday5_open - 1 as d5oo

        , case when d1oo > 0 then 1 else 0 end as d1oo_pos
        , case when d2oo > 0 then 1 else 0 end as d2oo_pos
        , case when d3oo > 0 then 1 else 0 end as d3oo_pos
        , case when d4oo > 0 then 1 else 0 end as d4oo_pos
        , case when d5oo > 0 then 1 else 0 end as d5oo_pos

        -- open to close
        , open / yday1_close - 1 as d1oc
        , open / yday2_close - 1 as d2oc
        , open / yday3_close - 1 as d3oc
        , open / yday4_close - 1 as d4oc
        , open / yday5_close - 1 as d5oc

        , case when d1oc > 0 then 1 else 0 end as d1oc_pos
        , case when d2oc > 0 then 1 else 0 end as d2oc_pos
        , case when d3oc > 0 then 1 else 0 end as d3oc_pos
        , case when d4oc > 0 then 1 else 0 end as d4oc_pos
        , case when d5oc > 0 then 1 else 0 end as d5oc_pos

        -- open to high
        , open / yday1_high - 1 as d1oh
        , open / yday2_high - 1 as d2oh
        , open / yday3_high - 1 as d3oh
        , open / yday4_high - 1 as d4oh
        , open / yday5_high - 1 as d5oh

        , case when d1oh > 0 then 1 else 0 end as d1oh_pos
        , case when d2oh > 0 then 1 else 0 end as d2oh_pos
        , case when d3oh > 0 then 1 else 0 end as d3oh_pos
        , case when d4oh > 0 then 1 else 0 end as d4oh_pos
        , case when d5oh > 0 then 1 else 0 end as d5oh_pos

        -- open to low
        , open / yday1_low - 1 as d1ol
        , open / yday2_low - 1 as d2ol
        , open / yday3_low - 1 as d3ol
        , open / yday4_low - 1 as d4ol
        , open / yday5_low - 1 as d5ol

        , case when d1ol > 0 then 1 else 0 end as d1ol_pos
        , case when d2ol > 0 then 1 else 0 end as d2ol_pos
        , case when d3ol > 0 then 1 else 0 end as d3ol_pos
        , case when d4ol > 0 then 1 else 0 end as d4ol_pos
        , case when d5ol > 0 then 1 else 0 end as d5ol_pos

        -- close to open
        , close / yday1_open - 1 as d1co
        , close / yday2_open - 1 as d2co
        , close / yday3_open - 1 as d3co
        , close / yday4_open - 1 as d4co
        , close / yday5_open - 1 as d5co

        , case when d1co > 0 then 1 else 0 end as d1co_pos
        , case when d2co > 0 then 1 else 0 end as d2co_pos
        , case when d3co > 0 then 1 else 0 end as d3co_pos
        , case when d4co > 0 then 1 else 0 end as d4co_pos
        , case when d5co > 0 then 1 else 0 end as d5co_pos

        -- close to close
        , close / yday1_close - 1 as d1cc
        , close / yday2_close - 1 as d2cc
        , close / yday3_close - 1 as d3cc
        , close / yday4_close - 1 as d4cc
        , close / yday5_close - 1 as d5cc

        , case when d1cc > 0 then 1 else 0 end as d1cc_pos
        , case when d2cc > 0 then 1 else 0 end as d2cc_pos
        , case when d3cc > 0 then 1 else 0 end as d3cc_pos
        , case when d4cc > 0 then 1 else 0 end as d4cc_pos
        , case when d5cc > 0 then 1 else 0 end as d5cc_pos

        -- close to high
        , close / yday1_high - 1 as d1ch
        , close / yday2_high - 1 as d2ch
        , close / yday3_high - 1 as d3ch
        , close / yday4_high - 1 as d4ch
        , close / yday5_high - 1 as d5ch

        , case when d1ch > 0 then 1 else 0 end as d1ch_pos
        , case when d2ch > 0 then 1 else 0 end as d2ch_pos
        , case when d3ch > 0 then 1 else 0 end as d3ch_pos
        , case when d4ch > 0 then 1 else 0 end as d4ch_pos
        , case when d5ch > 0 then 1 else 0 end as d5ch_pos

        -- close to low
        , close / yday1_low - 1 as d1cl
        , close / yday2_low - 1 as d2cl
        , close / yday3_low - 1 as d3cl
        , close / yday4_low - 1 as d4cl
        , close / yday5_low - 1 as d5cl

        , case when d1cl > 0 then 1 else 0 end as d1cl_pos
        , case when d2cl > 0 then 1 else 0 end as d2cl_pos
        , case when d3cl > 0 then 1 else 0 end as d3cl_pos
        , case when d4cl > 0 then 1 else 0 end as d4cl_pos
        , case when d5cl > 0 then 1 else 0 end as d5cl_pos

        -- volume to volume
        , volume / yday1_volume - 1 as d1vv
        , volume / yday2_volume - 1 as d2vv
        , volume / yday3_volume - 1 as d3vv
        , volume / yday4_volume - 1 as d4vv
        , volume / yday5_volume - 1 as d5vv

        , case when d1vv > 0 then 1 else 0 end as d1vv_pos
        , case when d2vv > 0 then 1 else 0 end as d2vv_pos
        , case when d3vv > 0 then 1 else 0 end as d3vv_pos
        , case when d4vv > 0 then 1 else 0 end as d4vv_pos
        , case when d5vv > 0 then 1 else 0 end as d5vv_pos

        -- vol diffs
        , yday1_volume_diff as d1_vol_diff
        , yday2_volume_diff as d2_vol_diff
        , yday3_volume_diff as d3_vol_diff
        , yday4_volume_diff as d4_vol_diff
        , yday5_volume_diff as d5_vol_diff

        , case when d1_vol_diff > 0 then 1 else 0 end as d1_vol_diff_pos
        , case when d2_vol_diff > 0 then 1 else 0 end as d2_vol_diff_pos
        , case when d3_vol_diff > 0 then 1 else 0 end as d3_vol_diff_pos
        , case when d4_vol_diff > 0 then 1 else 0 end as d4_vol_diff_pos
        , case when d5_vol_diff > 0 then 1 else 0 end as d5_vol_diff_pos

    from base_metrics

    order by ticker, calendar_dt desc

)

, window_counts as (

    -- Counts of days where the metric is greater than 0 (`_pos_`)

    select
        ticker
        , calendar_dt

        -- d1oo
        , sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1oo_pos_5d
        , sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1oo_pos_10d
        , sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1oo_pos_20d
        , sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1oo_pos_50d
        , sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1oo_pos_100d
        , sum(case when d1oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1oo_pos_200d

        -- d2oo
        , sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2oo_pos_5d
        , sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2oo_pos_10d
        , sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2oo_pos_20d
        , sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2oo_pos_50d
        , sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2oo_pos_100d
        , sum(case when d2oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2oo_pos_200d

        -- d3oo
        , sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3oo_pos_5d
        , sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3oo_pos_10d
        , sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3oo_pos_20d
        , sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3oo_pos_50d
        , sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3oo_pos_100d
        , sum(case when d3oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3oo_pos_200d

        -- d4oo
        , sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4oo_pos_5d
        , sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4oo_pos_10d
        , sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4oo_pos_20d
        , sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4oo_pos_50d
        , sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4oo_pos_100d
        , sum(case when d4oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4oo_pos_200d

        -- d5oo
        , sum(case when d5oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5oo_pos_5d
        , sum(case when d5oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5oo_pos_10d
        , sum(case when d5oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5oo_pos_20d
        , sum(case when d5oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5oo_pos_50d        
        , sum(case when d5oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5oo_pos_100d
        , sum(case when d5oo > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5oo_pos_200d

        -- d1oc
        , sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1oc_pos_5d
        , sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1oc_pos_10d
        , sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1oc_pos_20d
        , sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1oc_pos_50d
        , sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1oc_pos_100d
        , sum(case when d1oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1oc_pos_200d

        -- d2oc
        , sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2oc_pos_5d
        , sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2oc_pos_10d
        , sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2oc_pos_20d
        , sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2oc_pos_50d
        , sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2oc_pos_100d
        , sum(case when d2oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2oc_pos_200d

        -- d3oc
        , sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3oc_pos_5d
        , sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3oc_pos_10d
        , sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3oc_pos_20d
        , sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3oc_pos_50d
        , sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3oc_pos_100d
        , sum(case when d3oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3oc_pos_200d

        -- d4oc
        , sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4oc_pos_5d
        , sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4oc_pos_10d
        , sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4oc_pos_20d
        , sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4oc_pos_50d
        , sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4oc_pos_100d
        , sum(case when d4oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4oc_pos_200d

        -- d5oc
        , sum(case when d5oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5oc_pos_5d
        , sum(case when d5oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5oc_pos_10d
        , sum(case when d5oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5oc_pos_20d
        , sum(case when d5oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5oc_pos_50d
        , sum(case when d5oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5oc_pos_100d
        , sum(case when d5oc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5oc_pos_200d

        -- d1oh
        , sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1oh_pos_5d
        , sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1oh_pos_10d
        , sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1oh_pos_20d
        , sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1oh_pos_50d
        , sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1oh_pos_100d
        , sum(case when d1oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1oh_pos_200d

        -- d2oh
        , sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2oh_pos_5d
        , sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2oh_pos_10d
        , sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2oh_pos_20d
        , sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2oh_pos_50d
        , sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2oh_pos_100d
        , sum(case when d2oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2oh_pos_200d

        -- d3oh
        , sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3oh_pos_5d
        , sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3oh_pos_10d
        , sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3oh_pos_20d
        , sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3oh_pos_50d
        , sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3oh_pos_100d
        , sum(case when d3oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3oh_pos_200d

        -- d4oh
        , sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4oh_pos_5d
        , sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4oh_pos_10d
        , sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4oh_pos_20d
        , sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4oh_pos_50d
        , sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4oh_pos_100d
        , sum(case when d4oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4oh_pos_200d

        -- d5oh
        , sum(case when d5oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5oh_pos_5d
        , sum(case when d5oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5oh_pos_10d
        , sum(case when d5oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5oh_pos_20d
        , sum(case when d5oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5oh_pos_50d
        , sum(case when d5oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5oh_pos_100d
        , sum(case when d5oh > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5oh_pos_200d

        -- d1ol
        , sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1ol_pos_5d
        , sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1ol_pos_10d
        , sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1ol_pos_20d
        , sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1ol_pos_50d
        , sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1ol_pos_100d
        , sum(case when d1ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1ol_pos_200d

        -- d2ol
        , sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2ol_pos_5d
        , sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2ol_pos_10d
        , sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2ol_pos_20d
        , sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2ol_pos_50d
        , sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2ol_pos_100d
        , sum(case when d2ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2ol_pos_200d

        -- d3ol
        , sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3ol_pos_5d
        , sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3ol_pos_10d
        , sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3ol_pos_20d
        , sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3ol_pos_50d
        , sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3ol_pos_100d
        , sum(case when d3ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3ol_pos_200d

        -- d4ol
        , sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4ol_pos_5d
        , sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4ol_pos_10d
        , sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4ol_pos_20d
        , sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4ol_pos_50d
        , sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4ol_pos_100d
        , sum(case when d4ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4ol_pos_200d

        -- d5ol
        , sum(case when d5ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5ol_pos_5d
        , sum(case when d5ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5ol_pos_10d
        , sum(case when d5ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5ol_pos_20d
        , sum(case when d5ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5ol_pos_50d
        , sum(case when d5ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5ol_pos_100d
        , sum(case when d5ol > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5ol_pos_200d

        -- d1co
        , sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1co_pos_5d
        , sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1co_pos_10d
        , sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1co_pos_20d
        , sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1co_pos_50d
        , sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1co_pos_100d
        , sum(case when d1co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1co_pos_200d

        -- d2co
        , sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2co_pos_5d
        , sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2co_pos_10d
        , sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2co_pos_20d
        , sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2co_pos_50d
        , sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2co_pos_100d
        , sum(case when d2co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2co_pos_200d

        -- d3co
        , sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3co_pos_5d
        , sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3co_pos_10d
        , sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3co_pos_20d
        , sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3co_pos_50d
        , sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3co_pos_100d
        , sum(case when d3co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3co_pos_200d

        -- d4co
        , sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4co_pos_5d
        , sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4co_pos_10d
        , sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4co_pos_20d
        , sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4co_pos_50d
        , sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4co_pos_100d       
        , sum(case when d4co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4co_pos_200d

        -- d5co
        , sum(case when d5co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5co_pos_5d
        , sum(case when d5co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5co_pos_10d
        , sum(case when d5co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5co_pos_20d
        , sum(case when d5co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5co_pos_50d
        , sum(case when d5co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5co_pos_100d
        , sum(case when d5co > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5co_pos_200d

        -- d1cc
        , sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1cc_pos_5d
        , sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1cc_pos_10d
        , sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1cc_pos_20d
        , sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1cc_pos_50d
        , sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1cc_pos_100d
        , sum(case when d1cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1cc_pos_200d

        -- d2cc
        , sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2cc_pos_5d
        , sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2cc_pos_10d
        , sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2cc_pos_20d
        , sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2cc_pos_50d
        , sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2cc_pos_100d
        , sum(case when d2cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2cc_pos_200d

        -- d3cc
        , sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3cc_pos_5d
        , sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3cc_pos_10d
        , sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3cc_pos_20d
        , sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3cc_pos_50d
        , sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3cc_pos_100d
        , sum(case when d3cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3cc_pos_200d

        -- d4cc
        , sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4cc_pos_5d
        , sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4cc_pos_10d
        , sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4cc_pos_20d
        , sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4cc_pos_50d
        , sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4cc_pos_100d
        , sum(case when d4cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4cc_pos_200d

        -- d5cc
        , sum(case when d5cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5cc_pos_5d
        , sum(case when d5cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5cc_pos_10d
        , sum(case when d5cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5cc_pos_20d
        , sum(case when d5cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5cc_pos_50d
        , sum(case when d5cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5cc_pos_100d
        , sum(case when d5cc > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5cc_pos_200d

        -- d1ch
        , sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1ch_pos_5d
        , sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1ch_pos_10d
        , sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1ch_pos_20d
        , sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1ch_pos_50d
        , sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1ch_pos_100d
        , sum(case when d1ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1ch_pos_200d

        -- d2ch
        , sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2ch_pos_5d
        , sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2ch_pos_10d
        , sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2ch_pos_20d
        , sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2ch_pos_50d
        , sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2ch_pos_100d
        , sum(case when d2ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2ch_pos_200d

        -- d3ch
        , sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3ch_pos_5d
        , sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3ch_pos_10d
        , sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3ch_pos_20d
        , sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3ch_pos_50d
        , sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3ch_pos_100d
        , sum(case when d3ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3ch_pos_200d

        -- d4ch
        , sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4ch_pos_5d
        , sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4ch_pos_10d
        , sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4ch_pos_20d
        , sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4ch_pos_50d
        , sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4ch_pos_100d
        , sum(case when d4ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4ch_pos_200d

        -- d5ch
        , sum(case when d5ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5ch_pos_5d
        , sum(case when d5ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5ch_pos_10d
        , sum(case when d5ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5ch_pos_20d
        , sum(case when d5ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5ch_pos_50d
        , sum(case when d5ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5ch_pos_100d
        , sum(case when d5ch > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5ch_pos_200d

        -- d1cl
        , sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1cl_pos_5d
        , sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1cl_pos_10d
        , sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1cl_pos_20d
        , sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1cl_pos_50d
        , sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1cl_pos_100d
        , sum(case when d1cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1cl_pos_200d

        -- d2cl
        , sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2cl_pos_5d
        , sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2cl_pos_10d
        , sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2cl_pos_20d
        , sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2cl_pos_50d
        , sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2cl_pos_100d
        , sum(case when d2cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2cl_pos_200d

        -- d3cl
        , sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3cl_pos_5d
        , sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3cl_pos_10d
        , sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3cl_pos_20d
        , sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3cl_pos_50d
        , sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3cl_pos_100d
        , sum(case when d3cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3cl_pos_200d

        -- d4cl
        , sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4cl_pos_5d
        , sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4cl_pos_10d
        , sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4cl_pos_20d
        , sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4cl_pos_50d
        , sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4cl_pos_100d
        , sum(case when d4cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4cl_pos_200d

        -- d5cl
        , sum(case when d5cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5cl_pos_5d
        , sum(case when d5cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5cl_pos_10d
        , sum(case when d5cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5cl_pos_20d
        , sum(case when d5cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5cl_pos_50d
        , sum(case when d5cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5cl_pos_100d
        , sum(case when d5cl > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5cl_pos_200d

        -- d1vv
        , sum(case when d1vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1vv_pos_5d
        , sum(case when d1vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1vv_pos_10d
        , sum(case when d1vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1vv_pos_20d
        , sum(case when d1vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1vv_pos_50d
        , sum(case when d1vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1vv_pos_100d
        , sum(case when d1vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1vv_pos_200d

        -- d2vv
        , sum(case when d2vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2vv_pos_5d
        , sum(case when d2vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2vv_pos_10d
        , sum(case when d2vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2vv_pos_20d
        , sum(case when d2vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2vv_pos_50d
        , sum(case when d2vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2vv_pos_100d
        , sum(case when d2vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2vv_pos_200d

        -- d3vv
        , sum(case when d3vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3vv_pos_5d
        , sum(case when d3vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3vv_pos_10d
        , sum(case when d3vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3vv_pos_20d
        , sum(case when d3vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3vv_pos_50d
        , sum(case when d3vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3vv_pos_100d
        , sum(case when d3vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3vv_pos_200d

        -- d4vv
        , sum(case when d4vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4vv_pos_5d
        , sum(case when d4vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4vv_pos_10d
        , sum(case when d4vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4vv_pos_20d
        , sum(case when d4vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4vv_pos_50d
        , sum(case when d4vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4vv_pos_100d
        , sum(case when d4vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4vv_pos_200d

        -- d5vv
        , sum(case when d5vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5vv_pos_5d
        , sum(case when d5vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5vv_pos_10d
        , sum(case when d5vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5vv_pos_20d
        , sum(case when d5vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5vv_pos_50d
        , sum(case when d5vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5vv_pos_100d
        , sum(case when d5vv > 0 then 1 else 0 end) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5vv_pos_200d

        -- d1 vol diffs
        , sum(d1_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d1_vol_diff_5d
        , sum(d1_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d1_vol_diff_10d
        , sum(d1_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d1_vol_diff_20d
        , sum(d1_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d1_vol_diff_50d
        , sum(d1_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d1_vol_diff_100d
        , sum(d1_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d1_vol_diff_200d

        -- d2 vol diffs
        , sum(d2_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d2_vol_diff_5d
        , sum(d2_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d2_vol_diff_10d
        , sum(d2_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d2_vol_diff_20d
        , sum(d2_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d2_vol_diff_50d
        , sum(d2_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d2_vol_diff_100d
        , sum(d2_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d2_vol_diff_200d

        -- d3 vol diffs
        , sum(d3_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d3_vol_diff_5d
        , sum(d3_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d3_vol_diff_10d
        , sum(d3_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d3_vol_diff_20d
        , sum(d3_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d3_vol_diff_50d
        , sum(d3_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d3_vol_diff_100d
        , sum(d3_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d3_vol_diff_200d

        -- d4 vol diffs
        , sum(d4_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d4_vol_diff_5d
        , sum(d4_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d4_vol_diff_10d
        , sum(d4_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d4_vol_diff_20d
        , sum(d4_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d4_vol_diff_50d
        , sum(d4_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d4_vol_diff_100d
        , sum(d4_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d4_vol_diff_200d

        -- d5 vol diffs
        , sum(d5_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 4 following) as d5_vol_diff_5d
        , sum(d5_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 9 following) as d5_vol_diff_10d
        , sum(d5_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 19 following) as d5_vol_diff_20d
        , sum(d5_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 49 following) as d5_vol_diff_50d
        , sum(d5_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 99 following) as d5_vol_diff_100d
        , sum(d5_vol_diff) over (partition by ticker order by calendar_dt desc rows between current row and 199 following) as d5_vol_diff_200d

    from interday_performance

)

, window_performance as (

    select
        ticker,
        calendar_dt,

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

        -- d5oo percentages
        d5oo_pos_5d / 5.0 as d5oo_pct_5d,
        d5oo_pos_10d / 10.0 as d5oo_pct_10d,
        d5oo_pos_20d / 20.0 as d5oo_pct_20d,
        d5oo_pos_50d / 50.0 as d5oo_pct_50d,
        d5oo_pos_100d / 100.0 as d5oo_pct_100d,
        d5oo_pos_200d / 200.0 as d5oo_pct_200d,

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

        -- d5oc percentages
        d5oc_pos_5d / 5.0 as d5oc_pct_5d,
        d5oc_pos_10d / 10.0 as d5oc_pct_10d,
        d5oc_pos_20d / 20.0 as d5oc_pct_20d,
        d5oc_pos_50d / 50.0 as d5oc_pct_50d,
        d5oc_pos_100d / 100.0 as d5oc_pct_100d,
        d5oc_pos_200d / 200.0 as d5oc_pct_200d,

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

        -- d5oh percentages
        d5oh_pos_5d / 5.0 as d5oh_pct_5d,
        d5oh_pos_10d / 10.0 as d5oh_pct_10d,
        d5oh_pos_20d / 20.0 as d5oh_pct_20d,
        d5oh_pos_50d / 50.0 as d5oh_pct_50d,
        d5oh_pos_100d / 100.0 as d5oh_pct_100d,
        d5oh_pos_200d / 200.0 as d5oh_pct_200d,

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

        -- d5ol percentages
        d5ol_pos_5d / 5.0 as d5ol_pct_5d,
        d5ol_pos_10d / 10.0 as d5ol_pct_10d,
        d5ol_pos_20d / 20.0 as d5ol_pct_20d,
        d5ol_pos_50d / 50.0 as d5ol_pct_50d,
        d5ol_pos_100d / 100.0 as d5ol_pct_100d,
        d5ol_pos_200d / 200.0 as d5ol_pct_200d,

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

        -- d5co percentages
        d5co_pos_5d / 5.0 as d5co_pct_5d,
        d5co_pos_10d / 10.0 as d5co_pct_10d,
        d5co_pos_20d / 20.0 as d5co_pct_20d,
        d5co_pos_50d / 50.0 as d5co_pct_50d,
        d5co_pos_100d / 100.0 as d5co_pct_100d,
        d5co_pos_200d / 200.0 as d5co_pct_200d,

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

        -- d5cc percentages
        d5cc_pos_5d / 5.0 as d5cc_pct_5d,
        d5cc_pos_10d / 10.0 as d5cc_pct_10d,
        d5cc_pos_20d / 20.0 as d5cc_pct_20d,
        d5cc_pos_50d / 50.0 as d5cc_pct_50d,
        d5cc_pos_100d / 100.0 as d5cc_pct_100d,
        d5cc_pos_200d / 200.0 as d5cc_pct_200d,

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

        -- d5ch percentages
        d5ch_pos_5d / 5.0 as d5ch_pct_5d,
        d5ch_pos_10d / 10.0 as d5ch_pct_10d,
        d5ch_pos_20d / 20.0 as d5ch_pct_20d,
        d5ch_pos_50d / 50.0 as d5ch_pct_50d,
        d5ch_pos_100d / 100.0 as d5ch_pct_100d,
        d5ch_pos_200d / 200.0 as d5ch_pct_200d,

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
        d4cl_pos_200d / 200.0 as d4cl_pct_200d,

        -- d5cl percentages
        d5cl_pos_5d / 5.0 as d5cl_pct_5d,
        d5cl_pos_10d / 10.0 as d5cl_pct_10d,
        d5cl_pos_20d / 20.0 as d5cl_pct_20d,
        d5cl_pos_50d / 50.0 as d5cl_pct_50d,
        d5cl_pos_100d / 100.0 as d5cl_pct_100d,
        d5cl_pos_200d / 200.0 as d5cl_pct_200d,

        -- avg vol diff
        d1_vol_diff_5d / 5.0 as d1_avg_vol_diff_5d,
        d1_vol_diff_10d / 10.0 as d1_avg_vol_diff_10d,
        d1_vol_diff_20d / 20.0 as d1_avg_vol_diff_20d,
        d1_vol_diff_50d / 50.0 as d1_avg_vol_diff_50d,
        d1_vol_diff_100d / 100.0 as d1_avg_vol_diff_100d,
        d1_vol_diff_200d / 200.0 as d1_avg_vol_diff_200d,

        d2_vol_diff_5d / 5.0 as d2_avg_vol_diff_5d,
        d2_vol_diff_10d / 10.0 as d2_avg_vol_diff_10d,
        d2_vol_diff_20d / 20.0 as d2_avg_vol_diff_20d,
        d2_vol_diff_50d / 50.0 as d2_avg_vol_diff_50d,
        d2_vol_diff_100d / 100.0 as d2_avg_vol_diff_100d,
        d2_vol_diff_200d / 200.0 as d2_avg_vol_diff_200d,

        d3_vol_diff_5d / 5.0 as d3_avg_vol_diff_5d,
        d3_vol_diff_10d / 10.0 as d3_avg_vol_diff_10d,
        d3_vol_diff_20d / 20.0 as d3_avg_vol_diff_20d,
        d3_vol_diff_50d / 50.0 as d3_avg_vol_diff_50d,
        d3_vol_diff_100d / 100.0 as d3_avg_vol_diff_100d,
        d3_vol_diff_200d / 200.0 as d3_avg_vol_diff_200d,

        d4_vol_diff_5d / 5.0 as d4_avg_vol_diff_5d,
        d4_vol_diff_10d / 10.0 as d4_avg_vol_diff_10d,
        d4_vol_diff_20d / 20.0 as d4_avg_vol_diff_20d,
        d4_vol_diff_50d / 50.0 as d4_avg_vol_diff_50d,
        d4_vol_diff_100d / 100.0 as d4_avg_vol_diff_100d,
        d4_vol_diff_200d / 200.0 as d4_avg_vol_diff_200d,

        d5_vol_diff_5d / 5.0 as d5_avg_vol_diff_5d,
        d5_vol_diff_10d / 10.0 as d5_avg_vol_diff_10d,
        d5_vol_diff_20d / 20.0 as d5_avg_vol_diff_20d,
        d5_vol_diff_50d / 50.0 as d5_avg_vol_diff_50d,
        d5_vol_diff_100d / 100.0 as d5_avg_vol_diff_100d,
        d5_vol_diff_200d / 200.0 as d5_avg_vol_diff_200d

    from window_counts

)

, cumulative_positives as (

    select
        ticker
        , calendar_dt

        -- open to open cumulative sums
        , sum(d1oo_pos) over (partition by ticker order by calendar_dt) as d1oo_pos_cumsum
        , sum(d2oo_pos) over (partition by ticker order by calendar_dt) as d2oo_pos_cumsum
        , sum(d3oo_pos) over (partition by ticker order by calendar_dt) as d3oo_pos_cumsum
        , sum(d4oo_pos) over (partition by ticker order by calendar_dt) as d4oo_pos_cumsum
        , sum(d5oo_pos) over (partition by ticker order by calendar_dt) as d5oo_pos_cumsum
        
        -- open to open reset groups
        , sum(case when d1oo_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d1oo_reset
        , sum(case when d2oo_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d2oo_reset
        , sum(case when d3oo_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d3oo_reset
        , sum(case when d4oo_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d4oo_reset
        , sum(case when d5oo_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d5oo_reset

        -- open to close cumulative sums
        , sum(d1oc_pos) over (partition by ticker order by calendar_dt) as d1oc_pos_cumsum
        , sum(d2oc_pos) over (partition by ticker order by calendar_dt) as d2oc_pos_cumsum
        , sum(d3oc_pos) over (partition by ticker order by calendar_dt) as d3oc_pos_cumsum
        , sum(d4oc_pos) over (partition by ticker order by calendar_dt) as d4oc_pos_cumsum
        , sum(d5oc_pos) over (partition by ticker order by calendar_dt) as d5oc_pos_cumsum

        -- open to close reset groups
        , sum(case when d1oc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d1oc_reset
        , sum(case when d2oc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d2oc_reset
        , sum(case when d3oc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d3oc_reset
        , sum(case when d4oc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d4oc_reset
        , sum(case when d5oc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d5oc_reset

        -- open to high cumulative sums
        , sum(d1oh_pos) over (partition by ticker order by calendar_dt) as d1oh_pos_cumsum
        , sum(d2oh_pos) over (partition by ticker order by calendar_dt) as d2oh_pos_cumsum
        , sum(d3oh_pos) over (partition by ticker order by calendar_dt) as d3oh_pos_cumsum
        , sum(d4oh_pos) over (partition by ticker order by calendar_dt) as d4oh_pos_cumsum
        , sum(d5oh_pos) over (partition by ticker order by calendar_dt) as d5oh_pos_cumsum

        -- open to high reset groups
        , sum(case when d1oh_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d1oh_reset
        , sum(case when d2oh_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d2oh_reset
        , sum(case when d3oh_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d3oh_reset
        , sum(case when d4oh_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d4oh_reset
        , sum(case when d5oh_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d5oh_reset

        -- open to low cumulative sums
        , sum(d1ol_pos) over (partition by ticker order by calendar_dt) as d1ol_pos_cumsum
        , sum(d2ol_pos) over (partition by ticker order by calendar_dt) as d2ol_pos_cumsum
        , sum(d3ol_pos) over (partition by ticker order by calendar_dt) as d3ol_pos_cumsum
        , sum(d4ol_pos) over (partition by ticker order by calendar_dt) as d4ol_pos_cumsum
        , sum(d5ol_pos) over (partition by ticker order by calendar_dt) as d5ol_pos_cumsum

        -- open to low reset groups
        , sum(case when d1ol_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d1ol_reset
        , sum(case when d2ol_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d2ol_reset
        , sum(case when d3ol_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d3ol_reset
        , sum(case when d4ol_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d4ol_reset
        , sum(case when d5ol_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d5ol_reset

        -- close to open cumulative sums
        , sum(d1co_pos) over (partition by ticker order by calendar_dt) as d1co_pos_cumsum
        , sum(d2co_pos) over (partition by ticker order by calendar_dt) as d2co_pos_cumsum
        , sum(d3co_pos) over (partition by ticker order by calendar_dt) as d3co_pos_cumsum
        , sum(d4co_pos) over (partition by ticker order by calendar_dt) as d4co_pos_cumsum
        , sum(d5co_pos) over (partition by ticker order by calendar_dt) as d5co_pos_cumsum
        
        -- close to open reset groups
        , sum(case when d1co_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d1co_reset
        , sum(case when d2co_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d2co_reset
        , sum(case when d3co_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d3co_reset
        , sum(case when d4co_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d4co_reset
        , sum(case when d5co_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d5co_reset

        -- close to close cumulative sums
        , sum(d1cc_pos) over (partition by ticker order by calendar_dt) as d1cc_pos_cumsum
        , sum(d2cc_pos) over (partition by ticker order by calendar_dt) as d2cc_pos_cumsum
        , sum(d3cc_pos) over (partition by ticker order by calendar_dt) as d3cc_pos_cumsum
        , sum(d4cc_pos) over (partition by ticker order by calendar_dt) as d4cc_pos_cumsum
        , sum(d5cc_pos) over (partition by ticker order by calendar_dt) as d5cc_pos_cumsum

        -- close to close reset groups
        , sum(case when d1cc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d1cc_reset
        , sum(case when d2cc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d2cc_reset
        , sum(case when d3cc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d3cc_reset
        , sum(case when d4cc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d4cc_reset
        , sum(case when d5cc_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d5cc_reset

        -- close to high cumulative sums
        , sum(d1ch_pos) over (partition by ticker order by calendar_dt) as d1ch_pos_cumsum
        , sum(d2ch_pos) over (partition by ticker order by calendar_dt) as d2ch_pos_cumsum
        , sum(d3ch_pos) over (partition by ticker order by calendar_dt) as d3ch_pos_cumsum
        , sum(d4ch_pos) over (partition by ticker order by calendar_dt) as d4ch_pos_cumsum
        , sum(d5ch_pos) over (partition by ticker order by calendar_dt) as d5ch_pos_cumsum

        -- close to high reset groups
        , sum(case when d1ch_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d1ch_reset
        , sum(case when d2ch_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d2ch_reset
        , sum(case when d3ch_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d3ch_reset
        , sum(case when d4ch_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d4ch_reset
        , sum(case when d5ch_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d5ch_reset

        -- close to low cumulative sums
        , sum(d1cl_pos) over (partition by ticker order by calendar_dt) as d1cl_pos_cumsum
        , sum(d2cl_pos) over (partition by ticker order by calendar_dt) as d2cl_pos_cumsum
        , sum(d3cl_pos) over (partition by ticker order by calendar_dt) as d3cl_pos_cumsum
        , sum(d4cl_pos) over (partition by ticker order by calendar_dt) as d4cl_pos_cumsum
        , sum(d5cl_pos) over (partition by ticker order by calendar_dt) as d5cl_pos_cumsum

        -- close to low reset groups
        , sum(case when d1cl_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d1cl_reset
        , sum(case when d2cl_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d2cl_reset
        , sum(case when d3cl_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d3cl_reset
        , sum(case when d4cl_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d4cl_reset
        , sum(case when d5cl_pos = 0 then 1 else 0 end) over (partition by ticker order by calendar_dt) as d5cl_reset

    from interday_performance

)

, interday_streaks as (

    select
        ticker
        , calendar_dt

        , d1oo_pos_cumsum - coalesce(first_value(d1oo_pos_cumsum) over (partition by ticker, d1oo_reset order by calendar_dt), 0) as d1oo_streak
        , d2oo_pos_cumsum - coalesce(first_value(d2oo_pos_cumsum) over (partition by ticker, d2oo_reset order by calendar_dt), 0) as d2oo_streak
        , d3oo_pos_cumsum - coalesce(first_value(d3oo_pos_cumsum) over (partition by ticker, d3oo_reset order by calendar_dt), 0) as d3oo_streak
        , d4oo_pos_cumsum - coalesce(first_value(d4oo_pos_cumsum) over (partition by ticker, d4oo_reset order by calendar_dt), 0) as d4oo_streak
        , d5oo_pos_cumsum - coalesce(first_value(d5oo_pos_cumsum) over (partition by ticker, d5oo_reset order by calendar_dt), 0) as d5oo_streak

        , d1oc_pos_cumsum - coalesce(first_value(d1oc_pos_cumsum) over (partition by ticker, d1oc_reset order by calendar_dt), 0) as d1oc_streak
        , d2oc_pos_cumsum - coalesce(first_value(d2oc_pos_cumsum) over (partition by ticker, d2oc_reset order by calendar_dt), 0) as d2oc_streak
        , d3oc_pos_cumsum - coalesce(first_value(d3oc_pos_cumsum) over (partition by ticker, d3oc_reset order by calendar_dt), 0) as d3oc_streak
        , d4oc_pos_cumsum - coalesce(first_value(d4oc_pos_cumsum) over (partition by ticker, d4oc_reset order by calendar_dt), 0) as d4oc_streak
        , d5oc_pos_cumsum - coalesce(first_value(d5oc_pos_cumsum) over (partition by ticker, d5oc_reset order by calendar_dt), 0) as d5oc_streak

        , d1oh_pos_cumsum - coalesce(first_value(d1oh_pos_cumsum) over (partition by ticker, d1oh_reset order by calendar_dt), 0) as d1oh_streak
        , d2oh_pos_cumsum - coalesce(first_value(d2oh_pos_cumsum) over (partition by ticker, d2oh_reset order by calendar_dt), 0) as d2oh_streak
        , d3oh_pos_cumsum - coalesce(first_value(d3oh_pos_cumsum) over (partition by ticker, d3oh_reset order by calendar_dt), 0) as d3oh_streak
        , d4oh_pos_cumsum - coalesce(first_value(d4oh_pos_cumsum) over (partition by ticker, d4oh_reset order by calendar_dt), 0) as d4oh_streak
        , d5oh_pos_cumsum - coalesce(first_value(d5oh_pos_cumsum) over (partition by ticker, d5oh_reset order by calendar_dt), 0) as d5oh_streak

        , d1ol_pos_cumsum - coalesce(first_value(d1ol_pos_cumsum) over (partition by ticker, d1ol_reset order by calendar_dt), 0) as d1ol_streak
        , d2ol_pos_cumsum - coalesce(first_value(d2ol_pos_cumsum) over (partition by ticker, d2ol_reset order by calendar_dt), 0) as d2ol_streak
        , d3ol_pos_cumsum - coalesce(first_value(d3ol_pos_cumsum) over (partition by ticker, d3ol_reset order by calendar_dt), 0) as d3ol_streak
        , d4ol_pos_cumsum - coalesce(first_value(d4ol_pos_cumsum) over (partition by ticker, d4ol_reset order by calendar_dt), 0) as d4ol_streak
        , d5ol_pos_cumsum - coalesce(first_value(d5ol_pos_cumsum) over (partition by ticker, d5ol_reset order by calendar_dt), 0) as d5ol_streak

        , d1co_pos_cumsum - coalesce(first_value(d1co_pos_cumsum) over (partition by ticker, d1co_reset order by calendar_dt), 0) as d1co_streak
        , d2co_pos_cumsum - coalesce(first_value(d2co_pos_cumsum) over (partition by ticker, d2co_reset order by calendar_dt), 0) as d2co_streak
        , d3co_pos_cumsum - coalesce(first_value(d3co_pos_cumsum) over (partition by ticker, d3co_reset order by calendar_dt), 0) as d3co_streak
        , d4co_pos_cumsum - coalesce(first_value(d4co_pos_cumsum) over (partition by ticker, d4co_reset order by calendar_dt), 0) as d4co_streak
        , d5co_pos_cumsum - coalesce(first_value(d5co_pos_cumsum) over (partition by ticker, d5co_reset order by calendar_dt), 0) as d5co_streak

        , d1cc_pos_cumsum - coalesce(first_value(d1cc_pos_cumsum) over (partition by ticker, d1cc_reset order by calendar_dt), 0) as d1cc_streak
        , d2cc_pos_cumsum - coalesce(first_value(d2cc_pos_cumsum) over (partition by ticker, d2cc_reset order by calendar_dt), 0) as d2cc_streak
        , d3cc_pos_cumsum - coalesce(first_value(d3cc_pos_cumsum) over (partition by ticker, d3cc_reset order by calendar_dt), 0) as d3cc_streak
        , d4cc_pos_cumsum - coalesce(first_value(d4cc_pos_cumsum) over (partition by ticker, d4cc_reset order by calendar_dt), 0) as d4cc_streak
        , d5cc_pos_cumsum - coalesce(first_value(d5cc_pos_cumsum) over (partition by ticker, d5cc_reset order by calendar_dt), 0) as d5cc_streak

        , d1ch_pos_cumsum - coalesce(first_value(d1ch_pos_cumsum) over (partition by ticker, d1ch_reset order by calendar_dt), 0) as d1ch_streak
        , d2ch_pos_cumsum - coalesce(first_value(d2ch_pos_cumsum) over (partition by ticker, d2ch_reset order by calendar_dt), 0) as d2ch_streak
        , d3ch_pos_cumsum - coalesce(first_value(d3ch_pos_cumsum) over (partition by ticker, d3ch_reset order by calendar_dt), 0) as d3ch_streak
        , d4ch_pos_cumsum - coalesce(first_value(d4ch_pos_cumsum) over (partition by ticker, d4ch_reset order by calendar_dt), 0) as d4ch_streak
        , d5ch_pos_cumsum - coalesce(first_value(d5ch_pos_cumsum) over (partition by ticker, d5ch_reset order by calendar_dt), 0) as d5ch_streak

        , d1cl_pos_cumsum - coalesce(first_value(d1cl_pos_cumsum) over (partition by ticker, d1cl_reset order by calendar_dt), 0) as d1cl_streak
        , d2cl_pos_cumsum - coalesce(first_value(d2cl_pos_cumsum) over (partition by ticker, d2cl_reset order by calendar_dt), 0) as d2cl_streak
        , d3cl_pos_cumsum - coalesce(first_value(d3cl_pos_cumsum) over (partition by ticker, d3cl_reset order by calendar_dt), 0) as d3cl_streak
        , d4cl_pos_cumsum - coalesce(first_value(d4cl_pos_cumsum) over (partition by ticker, d4cl_reset order by calendar_dt), 0) as d4cl_streak
        , d5cl_pos_cumsum - coalesce(first_value(d5cl_pos_cumsum) over (partition by ticker, d5cl_reset order by calendar_dt), 0) as d5cl_streak

    from cumulative_positives

)

select
    base_metrics.*
    , interday_performance.* exclude (ticker, calendar_dt)
    , window_counts.* exclude (ticker, calendar_dt)
    , window_performance.* exclude (ticker, calendar_dt)
    , interday_streaks.* exclude (ticker, calendar_dt)
    
from base_metrics
    left join interday_performance using (ticker, calendar_dt)
    left join window_counts using (ticker, calendar_dt)
    left join window_performance using (ticker, calendar_dt)
    left join interday_streaks using (ticker, calendar_dt)

order by ticker, calendar_dt desc