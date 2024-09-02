-- This model aggregates road conditions data by road and condition type, providing insights into the severity and frequency of issues

with aggregated_conditions as (
    select
        road_id,
        condition_type,
        count(*) as condition_count,
        avg(severity) as avg_severity,
        min(recorded_at) as first_recorded,
        max(recorded_at) as last_recorded
    from {{ ref('staging_road_conditions') }}
    group by road_id, condition_type
)

select
    road_id,
    condition_type,
    condition_count,
    avg_severity,
    first_recorded,
    last_recorded
from aggregated_conditions
