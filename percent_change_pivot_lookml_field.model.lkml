connection: "thelook_events_redshift"

include: "basic_users.*"

view: percent_change_pivot_lookml_field {
  extends: [basic_users]
  measure: percent_change_from_previous {
    type: percent_of_previous
    sql: ${count} ;;
  }
}

explore: percent_change_pivot_lookml_field {}
