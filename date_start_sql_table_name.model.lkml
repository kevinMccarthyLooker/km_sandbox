connection: "thelook_events_redshift"

include: "basic_users.*"

view: users__date_start_sql_table_name {
  extends: [basic_users]
  sql_table_name:
  (select * from public.users
  where
  created_at>
  {% date_start users__date_start_sql_table_name.created_special %}
  );;
  dimension: created_special {
    type: date
    sql: ${TABLE}.created_at ;;
  }
}
explore: users__date_start_sql_table_name {}
