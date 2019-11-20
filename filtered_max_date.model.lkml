connection: "thelook_events_redshift"

include: "basic_users.*"
# include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

view: filtered_max_date {
  extends: [basic_users]
  measure: max {
    type: max
    sql: ${created_raw} ;;
    filters: {
      field: state
      value: "New Jersey,Massachusetts"
    }
    html:{{value}};;
  }
  measure: date_of_max {
    type: date
    sql: ${max} ;;
  }
}
explore: filtered_max_date {}
