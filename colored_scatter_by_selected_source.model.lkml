connection: "thelook_events_redshift"

include: "basic_users.view"

view: basic_with_colored_scatter {
  extends: [basic_users]
  filter: select_traffic_source {
    suggest_dimension: traffic_source
  }
  dimension: is_selected_traffic_source {
    type: yesno
    sql: {%condition select_traffic_source %}${traffic_source}{%endcondition%} ;;
  }
  measure: count_selected_traffic_source_only {
    type: count
    filters:  {
      field: is_selected_traffic_source
      value: "Yes"
    }
  }


}
explore: basic_with_colored_scatter {}
