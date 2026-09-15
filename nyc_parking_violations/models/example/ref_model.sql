SELECT Count(*) AS violation_count
FROM {{ref('first_model')}}
