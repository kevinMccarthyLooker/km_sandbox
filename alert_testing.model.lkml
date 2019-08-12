connection: "thelook_events_redshift"

include: "basic_users.view"

explore: basic_users {}

datagroup: alert_trigger_test1__outlier_on_count_by_age{
  sql_trigger:
with data as
(
SELECT
  basic_users.age AS age,
  COUNT(*) AS user_count,
  row_number() over(ORDER BY COUNT(*) DESC) as row
FROM public.users  AS basic_users

-- where age>20

GROUP BY 1
ORDER BY 2 DESC
LIMIT 2
)
select
-- max(user_count)-min(user_count) as top_value_difference_from_second,
case when max(user_count)-min(user_count) >1000 then 1 else 0 end as threshold

from data
  ;;
}
