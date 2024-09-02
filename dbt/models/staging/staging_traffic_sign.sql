-- This model stages the raw traffic sign data, normalizing and preparing it for further transformations

with raw_traffic_signs as (
    select
        sign_id,
        road_id,
        sign_type,
        sign_subtype,
        gps_coordinates,
        detected_at,
        metadata,
        ingestion_time
    from {{ source('raw', 'traffic_signs') }}
)

select
    sign_id,
    road_id,
    trim(lower(sign_type)) as sign_type,
    trim(lower(sign_subtype)) as sign_subtype,
    st_geogpoint(gps_coordinates[0], gps_coordinates[1]) as location,
    detected_at,
    metadata,
    ingestion_time
from raw_traffic_signs
where ingestion_time > current_date() - interval '30 days'
