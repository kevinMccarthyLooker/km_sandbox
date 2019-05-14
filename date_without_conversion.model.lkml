connection: "thelook_events_redshift"
view: users {
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension_group: created {
    type: time
    timeframes: [raw,date,month]
#     sql: date(${TABLE}.created_at) ;;
    sql: '2018-01-01' ;;
    datatype: date
    convert_tz: no
  }

dimension: date_manual {
#   type: string
  type: date
  sql: date(${TABLE}.created_at) ;;
}
# dimension: date_manual_order_by {
#   type:
# }
}

explore: users {}
