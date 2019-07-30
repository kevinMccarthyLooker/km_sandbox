connection: "thelook_events_redshift"

view: users {
  sql_table_name: public.users ;;
  filter:the_filter{}
  dimension: the_dimension {
    label: "{{_filters['the_filter']}}"
    view_label: "{{_filters['the_filter']}}"
    sql: 1 ;;
  }
}
explore: users {}
