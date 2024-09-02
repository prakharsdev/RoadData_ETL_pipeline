-- This final model provides a comprehensive road safety report by combining road conditions and traffic sign metrics

with road_safety as (
    select
        rc.road_id,
        rc.condition_type,
        rc.severe_condition_percentage,
        ts.signs_per_km
    from {{ ref('road_condition_metrics') }} rc
    left join {{ ref('traffic_sign_density') }} ts
    on rc.road_id = ts.road_id
)

select
    road_id,
    condition_type,
    severe_condition_percentage,
    signs_per_km,
    case 
        when severe_condition_percentage > 20 then 'High Risk'
        when severe_condition_percentage > 10 then 'Moderate Risk'
        else 'Low Risk'
    end as risk_level
from road_safety
order by risk_level desc
