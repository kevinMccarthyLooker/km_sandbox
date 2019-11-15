connection: "thelook_events_redshift"

include: "basic_users.view"

view: selected_month_offset_with_parameter {
  extends: [basic_users]
  parameter: month_selector {
    type: string
    suggest_dimension: created_month
  }
  dimension: selected_month {
    sql: {{month_selector._parameter_value}} ;;
  }
}

explore: selected_month_offset_with_parameter {}
