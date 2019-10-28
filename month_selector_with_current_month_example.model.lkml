connection: "thelook_events_redshift"

include: "*basic_users.view"

view: month_selector_with_current_month_example {
  extends: [basic_users]
  parameter: month_selector {
    suggest_explore: special_month_selector
    suggest_dimension: special_month_selector.selection_value
  }
}

explore: month_selector_with_current_month_example {


  sql_always_where:
  {% if month_selector_with_current_month_example.month_selector._parameter_value == "'Current Month'" %}
  ${month_selector_with_current_month_example.created_raw}< '{{ 'now' | date: '%Y-%m-%d' }}'
  {% else %}
  ${month_selector_with_current_month_example.created_raw}<{% parameter month_selector_with_current_month_example.month_selector %}
  {% endif %}
  ;;

}
# {% parameter month_selector_with_current_month_example.month_selector %}

view: special_month_selector {
  derived_table: {
    sql:
select concat(TO_CHAR(DATE_TRUNC('month', created_at ), 'YYYY-MM'),'-01') as selection_value from public.users
union all
select 'Current Month' as selection_value
;;
  }
  dimension: selection_value {}
}
explore: special_month_selector {}
