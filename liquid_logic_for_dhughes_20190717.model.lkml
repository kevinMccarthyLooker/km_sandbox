connection: "thelook_events_redshift"
view: users_for_liquid_test {
  sql_table_name: public.users ;;
  dimension: age {}
  dimension: id {}
}
view: order_items_for_liquid_test {
  sql_table_name: public.order_items ;;
  dimension: id {}
  dimension: user_id {}
  dimension: liquid_test {
    sql:
    {%if order_items_for_liquid_test.id._is_selected %}
      {%if users_for_liquid_test.id._is_selected %}
      'scenario1'
      {% else %}
      'do something'
      {% endif %}
    {%else%}
    'scenario2'
    {% endif %}
    ;;
  }
}
explore: order_items_for_liquid_test {
  join: users_for_liquid_test {
    sql_on: ${users_for_liquid_test.id}=${order_items_for_liquid_test.user_id} ;;
    relationship: many_to_one
    type: left_outer
  }
}
