connection: "thelook_events_redshift"

include: "user_creation_support.view.lkml"
include: "user_creation_support2.view.lkml"
explore: user_creation_support2 {}

include: "trank.view.lkml"
explore: trank {}

#
# # include all the views
# include: "*.view"
#
# # include all the dashboards
# include: "*.dashboard"
#
# datagroup: km_sandbox_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }
#
# persist_with: km_sandbox_default_datagroup
#
# # explore: order_items_symm_aggs {
# #   view_name: order_items
# #   join: users {
# #     type: left_outer
# #     sql_on: ${order_items.user_id} = ${users.id} ;;
# #     relationship: many_to_one
# #   }
# # }
#
# explore: users_explore {
#   view_name: users
#   from: users
# }
#
# explore: order_items_dynamic_labels_testing {}
#
# explore: order_items {
#   view_label: "test-user_attribtes['emai']"
#   join: users {
#     type: left_outer
#     sql_on: ${order_items.user_id} = ${users.id} ;;
#     relationship: one_to_one
#   }
#
# #   join: double_count_checker {
# #     sql_on: ${double_count_checker.users_id}=${order_items.user_id} ;;
# #     relationship: one_to_one
# #   }
#
#
# #   join: inventory_items {
# #     type: left_outer
# #     sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
# #     relationship: many_to_one
# #
# #
# #   join: products {
# #     type: left_outer
# #     sql_on: ${inventory_items.product_id} = ${products.id} ;;
# #     relationship: many_to_one
# #   }
# #
# #   join: distribution_centers {
# #     type: left_outer
# #     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
# #     relationship: many_to_one
# #   }
# # }
# #
# # explore: products {
# #   join: distribution_centers {
# #     type: left_outer
# #     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
# #     relationship: many_to_one
# #   }
#
# join: ndt {
#   sql_on: ${ndt.users_id}=${users.id} ;;
#   type: left_outer
#   relationship: one_to_one
# }
#
# }
# #
# # explore: users {}
#
# # If necessary, uncomment the line below to include explore_source.
# # include: "km_sandbox.model.lkml"
#
# view: ndt {
#   derived_table: {
#     explore_source: order_items {
#       column: users_id { field: order_items.user_id }
#       column: users_id_count { field: users.count }
#       column: count {}
# #       filters: {
# #         field: order_items.user_id
# # #         value: "66354,86143"
# # #         value: "_filters['ndt.users_id']"
# #           value: "{% parameter ndt.users_id %}"
# #       }
#       bind_filters: {
#         to_field: order_items.user_id
#         from_field: ndt.users_id
#       }
#     }
#   }
#   dimension: users_id {type: number primary_key:yes}
#   dimension: users_id_count {type: number}
#   measure: total_users_id_count {type:sum sql:${users_id_count};;}
# #   dimension: count {type: number}
#   measure: age_corrected {type:number sql:sum(${users.age}/(1.0*${users_id_count}));;value_format_name:decimal_0}
# }
include: "functions.*"
#
include:"create_users_data.view.lkml"

explore: create_users_data {}
include: "order_items.view"
include: "users.view"
explore: order_items2 {
  view_name: order_items
  join: functions               {fields:[]                    sql:;;relationship:one_to_one}
  always_join: [users]
  join: users {
    sql_on: ${order_items.user_id}=${users.id} ;;
    relationship: many_to_one
  }

}
include: "summary_measures.view"
include: "variables_and_templates.view"
# explore: users_summary_measures {
#   join: variables_and_templates {sql:;;relationship:one_to_one}
#
# }

explore: users {
  join: variables_and_templates {                        sql:;;relationship:one_to_one}
  join: demo_summary_measures   {from:summary_measures   sql:;;relationship:one_to_one fields:[gender_summary,age_summary,full_name_summary]}
  join: city_summary_measures   {from:summary_measures   sql:;;relationship:one_to_one fields:[city_summary]}
  join: functions               {fields:[function_add,safe_divide]                    sql:;;relationship:one_to_one}
}


explore: functions {
  join: function_use {sql:;; relationship:one_to_one}
}
