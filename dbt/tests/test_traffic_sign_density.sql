-- Test to ensure that the sign density does not exceed a realistic maximum (e.g., 1000 signs per km)

select *
from {{ ref('traffic_sign_density') }}
where signs_per_km > 1000
