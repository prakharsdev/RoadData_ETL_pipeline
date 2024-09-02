-- This model summarizes traffic sign data, providing a count of each type of sign per road

with sign_summary as (
    select
        road_id,
        sign_type,
        count(*) as sign_count
    from {{ ref('staging_traffic_signs') }}
    group by road_id, sign_type
)

select
    road_id,
    sign_type,
    sign_count
from sign_summary
