-- This model calculates the density of traffic signs per kilometer for each road

with sign_density as (
    select
        road_id,
        count(*) as sign_count,
        (max(st_length(road_geometry)) / 1000) as road_length_km
    from {{ ref('staging_traffic_signs') }}
    group by road_id
)

select
    road_id,
    sign_count,
    road_length_km,
    round((sign_count::float / road_length_km), 2) as signs_per_km
from sign_density
