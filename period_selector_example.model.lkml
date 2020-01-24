connection: "thelook_events_redshift"

include: "basic_users.*"

view: period_selector_example {
  extends: [basic_users]

  dimension: periods_since {
    type: number
    sql: floor(datediff(days,{% parameter period_start_date %},${created_date})/{% parameter period_length_select %}.0) ;;
    value_format_name: decimal_0
  }
  parameter: period_start_date {
    type: date
    default_value: "2020-01-01"
  }
  parameter: period_length_select {
    type: number
    default_value: "28"
  }
}

explore: period_selector_example {}
