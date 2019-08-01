connection: "thelook_events_redshift"

view: users_for_suggest_explore_example20190801 {
  sql_table_name: public.users ;;
  dimension: first_name {
    suggest_explore: users2
    suggest_dimension: users2.first_name_for_suggestions
  }
  dimension: first_name_for_suggestions {
    sql: ${first_name};;
  }
}

explore: users_for_suggest_explore_example20190801 {}

explore: suggestions_builder {
  from: users_for_suggest_explore_example20190801
}
