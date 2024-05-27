with data as (

    select * from {{ ref('stg_raw__history') }}

)

select 
    *,
    close/open - 1 as daily_performance

from data