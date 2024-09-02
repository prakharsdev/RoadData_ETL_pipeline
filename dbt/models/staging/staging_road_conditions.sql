-- This model stages the raw road conditions data from Google Cloud Storage

with raw_road_conditions as (
    select
        id,
        road_id,
        condition_type,
        severity,
        recorded_at,
        gps_coordinates,
        metadata,
        ingestion_time
    from {{ source('raw', 'road_conditions') }}
)

select 
    id,
    road_id,
    trim(lower(condition_type)) as condition_type,
    severity,
    recorded_at,
    st_geogpoint(gps_coordinates[0], gps_coordinates[1]) as location,
    metadata,
    ingestion_time
from raw_road_conditions
where ingestion_time > current_date() - interval '7 days'
