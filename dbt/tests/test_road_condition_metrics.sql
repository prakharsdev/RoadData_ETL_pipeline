-- Test to ensure that no road has a severe condition percentage over 100%

select *
from {{ ref('road_condition_metrics') }}
where severe_condition_percentage > 100
