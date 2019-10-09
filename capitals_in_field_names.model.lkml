connection: "thelook_events_redshift"

include: "basic_users.*"

view: capitals_in_field_names {
  extends: [basic_users]
  measure: Count_capital {
    type: number
    sql: ${count} ;;
  }
}

explore: capitals_in_field_names {}
