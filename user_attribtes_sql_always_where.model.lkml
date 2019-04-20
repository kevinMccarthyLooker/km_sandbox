connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project

explore: orders {
  sql_always_where:
  {% assign test_id_string = _user_attributes['first_name'] | append: '' %}
  {% if test_id_string == '' %}
  ${orders.id} = 7
  {% else %}
  ${orders.id} = '{{ _user_attributes['first_name'] }}'
  {% endif %};;


}
view: orders {
  derived_table:{sql: select order_id as id, count(*) as order_item_count from public.order_items group by 1 ;;}
  dimension: id {}
  dimension: order_item_count {}
  dimension: att {
    type: string
    sql: '{{_user_attributes['my_tables']}}' ;;
  }
  dimension: att_my_tables {
    type: string
    sql: '{{_user_attributes['my_tables']}}' ;;
  }
  dimension: att_id {
    type: string
    sql: '{{_user_attributes['id']}}' ;;
  }

}
