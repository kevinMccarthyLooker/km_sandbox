connection: "thelook_events_redshift"

view: users_for_date_suggestions {
  derived_table: {
    sql:
    select * from public.users where date(created_at)= '2019-01-01' or date(created_at)= '2019-02-02'
     ;;

  }
  dimension_group: created {
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.created_at ;;
  }
  dimension: created_date_string {
    type: string
    sql: ${created_date} ;;
  }
}
explore: users_for_date_suggestions {}
