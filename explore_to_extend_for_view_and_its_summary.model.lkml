connection: "thelook_events_redshift"

include: "/**/basic_users.*"
include: "/**/order_items.*"

explore: order_items {
  extends: [join_order_items_to_users]
  view_name: order_items
  from: order_items
}

explore: basic_users {}

view: user_summary {
  derived_table: {
    explore_source:order_items {
      column: user_id {field:order_items.user_id}
      column: lifetime_order_count {field:order_items.count}
    }
  }
  dimension: user_id {}
  dimension: primary_key {primary_key:yes sql:${user_id};;}
  dimension: lifetime_order_count {type:number}
}

view: dummy_base {}
view: base_for_join_to_users {
  dimension: user_id_foreign_key {}
}
explore: joins_to_users {
  extension: required
  view_name: base_for_join_to_users
  join: basic_users {
    # sql_on: ${base_for_join_to_users.user_id_foreign_key} = ${basic_users.primary_key} ;;
    sql_on:  ;;#the above didnt work
    relationship: many_to_one #might should be one_to_one... would need to update join
  }
  join: user_summary {
    # sql_on: ${base_for_join_to_users.user_id_foreign_key} = ${user_summary.primary_key} ;;
    sql_on:  ;;#the above didnt work
    relationship: many_to_one #might should be one_to_one... would need to update join
  }
}


view: base_for_join_from_order_items_to_users {
  extends: [base_for_join_to_users]
  dimension: user_id_foreign_key {sql:${order_items.user_id};;}
}
explore: join_order_items_to_users {
  extension: required
  extends: [joins_to_users]
  from: base_for_join_from_order_items_to_users
}
