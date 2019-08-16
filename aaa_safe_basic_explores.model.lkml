connection: "thelook_events_redshift"

include: "basic_users.view"
include: "merge_filter_example.dashboard"
explore: basic_users {}

datagroup: test_datagroup {
  sql_trigger: select 1 ;;
}
