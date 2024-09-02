-- This final model generates a compliance report showing areas where traffic signs may need maintenance or replacement

with compliance as (
    select
        ts.road_id,
        ts.sign_type,
        count(*) as total_signs,
        sum(case when metadata ->> 'is_damaged' = 'true' then 1 else 0 end) as damaged_signs
    from {{ ref('staging_traffic_signs') }} ts
    group by ts.road_id, ts.sign_type
)

select
    road_id,
    sign_type,
    total_signs,
    damaged_signs,
    round((damaged_signs::float / total_signs) * 100, 2) as damage_percentage
from compliance
where damage_percentage > 10
order by damage_percentage desc
