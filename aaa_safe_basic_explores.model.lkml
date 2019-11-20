connection: "thelook_events_redshift"

include: "basic_users.view"
# include: "merge_filter_example.dashboard"

include: "test_thin*"
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
include: "order_items.*"
include: "inventory_items.*"
explore: order_items {
  join: users {
    from: basic_users
    sql_on: ${users.id}=${order_items.user_id} ;;
    relationship: many_to_one
  }
  join: inventory_items {
    sql_on: ${inventory_items.id}=${order_items.inventory_item_id} ;;
    relationship: many_to_one
  }
}

explore: basic_users_x {
  from: basic_users
  sql_always_where: {{_user_attributes['name']}} ;;
}

include: "overlay.dashboard"
