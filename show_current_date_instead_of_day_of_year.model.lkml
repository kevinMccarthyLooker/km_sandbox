connection: "thelook_events_redshift"

include: "basic_users.*"

view: show_current_date_instead_of_day_of_year {
  extends: [basic_users]
  dimension: date_raw {
    type: date_raw
    sql: ${created_raw} ;;
  }
  dimension: date_date_of_year {
    type: date_day_of_year
    sql: ${date_raw} ;;
  }
  dimension: date {
    type: date
    sql: ${date_raw} ;;
  }
  measure: max_date {
    type: date
    sql: max(${date_raw}) ;;
  }
}
explore: show_current_date_instead_of_day_of_year {}
