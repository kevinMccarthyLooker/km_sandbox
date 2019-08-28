connection: "thelook_events_redshift"

include: "basic_users.*"

view: users__date_start_sql_table_name {
  extends: [basic_users]
  sql_table_name:
  (select * from public.users
  where
  created_at>
  coalesce({% date_start users__date_start_sql_table_name.created_special %},'1900-01-01')
  );;
  dimension: created_special {
    type: date
    sql: ${TABLE}.created_at ;;
  }
}
explore: users__date_start_sql_table_name {}
