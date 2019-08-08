connection: "thelook_events_redshift"

include: "basic_users.view"
include: "order_items.view"

view: users__pivot_without_measure_name {
  view_label: "Users"
  extends: [basic_users]
  measure: a_count_with_no_name {
    view_label: "{%if a_count_with_no_name._in_query%}{%else%}Users{%endif%}"
    label: "{%if a_count_with_no_name._in_query%}{%else%}Special{%endif%}"
    sql: cast(${count} + (${count}*(random()-0.5)) as integer) ;;
    type: number
  }
}

explore: users__pivot_without_measure_name {
  join: order_items {
    sql_on: ${order_items.user_id}=${users__pivot_without_measure_name.id} ;;
    type: left_outer
    relationship: one_to_many
  }
}
