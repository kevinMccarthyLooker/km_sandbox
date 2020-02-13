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
    description: "{% if _user_attributes['first_name'] =='Kevin' %}hi kevin{% else%}{{_user_attributes['first_name']}}{%endif%}"
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

explore: test_ndt_source {
  view_name: basic_users
  join: order_items {
    sql_on: ${order_items.user_id}=${basic_users.id} ;;
    relationship: one_to_many
  }
}

view: test_ndt_source_ndt {
  derived_table: {
    explore_source: test_ndt_source {
      column: total_sales2 { field: order_items.total_sales2 }
      column: age { field: basic_users.age }
    }
  }
  dimension: age {
    type: number
  }
  measure: total_sales2 {
    type: sum
    # sql: ${TABLE}.total_sales2 ;;
  }
}
view: order_items_fields {
  measure: total_sales2 {
    type: number
    sql: ${basic_users.total_sales2} ;;
  }
}
explore: test_ndt_source_ndt {
  # from: test_ndt_source_ndt
  # view_name: basic_users
  # join: order_items {
  #   from: order_items_fields
  #   sql:  ;;
  # }
}

view: test_ndt_source_ndt2 {
  derived_table: {
    explore_source: test_ndt_source {
      column: total_sales2 { field: order_items.total_sales2 }
      column: age { field: basic_users.age }
    }
  }
  measure: total_sales2 {
    value_format: "$#,##0.00"
    type: sum
  }
  dimension: age {
    type: number
  }
}

explore: test_ndt_source_ndt2 {
  view_name: basic_users
}


view: tile_specific_age_and_gender {
# If necessary, uncomment the line below to include explore_source.
# include: "aaa_safe_basic_explores.model.lkml"

  derived_table: {
    explore_source: basic_users {
      column: age {}
      column: gender {}
      column: count {}
#       filters: {
#         field: basic_users.age
#         value: ">30"
#       }
#       filters: {
#         field: basic_users.state
#         value: ""
#       }
      column: state {}
    }
    # persist_for: "1 hour"
  }
  dimension: age {
    type: number
  }
  dimension: gender {}

  dimension: state {}
#   dimension: count {
#     type: number
#   }
  measure: count {
    type: sum
    sql: ${TABLE}.count ;;
    # tags: ["{{user_attributes['name']}}"]
  }

}

explore: tile_specific_age_and_gender {
  from: tile_specific_age_and_gender
  view_name: basic_users

}


include: "overlay.dashboard"
