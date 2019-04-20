connection: "thelook_events_redshift"
include: "order_items.view"
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

access_grant: user_is_kevin {
  user_attribute: id
  allowed_values: ["19"]
}
explore: order_items {
  join:users_for_conditional_visibility_example  {
    relationship: many_to_one
    sql_on: ${users_for_conditional_visibility_example.id}=${order_items.user_id} ;;
  }
  join:users_for_conditional_visibility_example_visible  {
    relationship: many_to_one
    required_access_grants: [user_is_kevin]
    sql_on: ${users_for_conditional_visibility_example_visible.id}=${order_items.user_id} ;;
  }
}

view: users_for_conditional_visibility_example {
  sql_table_name: public.users ;;
  dimension: id   {hidden:yes primary_key:yes}
  dimension: age  {hidden:yes type:number}
  measure: count  {hidden:yes type:count}
}
view: users_for_conditional_visibility_example_visible {
  extends: [users_for_conditional_visibility_example]
  dimension: id   {hidden:no}
  dimension: age  {hidden:no}
  measure: count  {hidden:no}

}
