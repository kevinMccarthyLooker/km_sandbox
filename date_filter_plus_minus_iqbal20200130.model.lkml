connection: "thelook_events_redshift"

include: "/basic_users.view.lkml"

view: date_filter_plus_minus_iqbal20200130 {
  extends: [basic_users]
  filter: date_time_filter_for_plus_minus {
    type: date_time
    sql: t{% date_start date_time_filter_for_plus_minus %},t2 {% date_end date_time_filter_for_plus_minus %} ;;
    # sql: {{_filters['date_time_filter_for_plus_minus']}} ;;
  }
}
explore: date_filter_plus_minus_iqbal20200130 {}
