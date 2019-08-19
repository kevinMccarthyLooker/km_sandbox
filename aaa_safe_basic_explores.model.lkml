connection: "thelook_events_redshift"

include: "basic_users.view"
# include: "merge_filter_example.dashboard"
explore: basic_users {
  # persist_with: test_datagroup
}

view: users_with_running_total {
  extends: [basic_users]
  measure: running_total {
    direction: "column"
    type: running_total
    sql: ${count} ;;
  }
}
explore: users_with_running_total {}

# datagroup: test_datagroup {
#   sql_trigger: select count(*) from public.users ;;
#   max_cache_age: "24 hours"
# }
