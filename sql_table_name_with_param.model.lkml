connection: "thelook_events_redshift"

include: "*.view.lkml"
# include all views in this project

explore: users_dynamic_sql_table_name {
  sql_always_where: {% assign t='where' %} {{t}} ;;
}

view: users_dynamic_sql_table_name {
  sql_table_name:
  (select * from {% condition users_dynamic_sql_table_name.city %}--{% endcondition %}
  );;
  dimension: city {
    sql: {% assign t='select' %}${TABLE}.city or {{t}} ;;
  }
}
