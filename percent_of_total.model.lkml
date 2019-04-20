connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

named_value_format: percent_with_decimal {value_format:"#.0\%"}
view: users__percent_of_total {
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {type:number}
  measure: age_percent_of_total {
    type: percent_of_total
    sql: ${age} ;;
  }
  measure: age_percent_of_total_value {
    type: percent_of_total
    sql: ${age} ;;
    # html: {{value}} ;;
    value_format_name: percent_with_decimal
  }
}
explore: users__percent_of_total {}
