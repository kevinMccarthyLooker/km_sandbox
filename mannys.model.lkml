connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

view: users_for_manny_question {
  sql_table_name: public.users ;;
  dimension: country {}
  dimension: state {}
  parameter: select_field {
    allowed_value: {label:"country" value:"country"}
    allowed_value: {label:"state" value:"state"}
  }

  dimension: dynamic_field {
    label_from_parameter: select_field
    sql: {% if select_field._parameter_value == "'country'" %}${country}{%else%}${state}{%endif%} ;;
  }
  measure: count {
    type: count
  }
}

explore: users_for_manny_question {}
