connection: "thelook_events_redshift"

include: "/basic_users.view.lkml"

view: +basic_users {
  measure: drill_holder {
    type: max
    sql: 1 ;;
    drill_fields: [age,count]
  }
  parameter: percent_multiplier_selector {
    type: number
    default_value: "100"
  }
  dimension: percent_multiplier {
    type: number
    sql:
    {% assign percent_multiplier_selector__numeric = users.percent_multiplier_selector._parameter_value | plus: 0 %}
    {% if percent_multiplier_selector__numeric >= 100 %}
    1
    {% elsif percent_multiplier_selector__numeric > 0 %}
    {{percent_multiplier_selector__numeric}}/100.0
    {% else %}
    0
    {% endif %}
    ;;
  }
  dimension: use_percent_multiplier {
    type: number
    sql: 2*${percent_multiplier} ;;
  }

  measure: example_field_that_uses_custom_drill_2 {
    type: count
    html:
    {%assign search_string = 'f[users.created_date]='%}
   search_string: {{search_string}}
    {%assign created_filter_first = drill_holder._link |split: search_string | first %}
   created_filter_first: {{created_filter_first}}
    {%assign created_filter_last = drill_holder._link |split: search_string | last %}
   created_filter_last: {{created_filter_last}}

    {%assign til_next_and = created_filter_last |split: '&' | first %}
   til_next_and: {{til_next_and}}
    {%assign after_next_and = created_filter_last |split: '&' | last %}
   til_next_and: {{after_next_and}}

    {%assign final_updated_string = created_filter_first|append:'!'|append:search_string|append:'!'|append:manipulated %}


    {% assign from_fields_begin = drill_holder._link | split: 'fields=' | last %}
    {% assign fields = from_fields_begin | split: '&' | first %}
    {{fields}}

    {% assign from_filters = drill_holder._link | split: 'amp;f' | last %}
    {% assign filters_only = from_filters | split: 'amp;query_timezone' | first %} {%comment %} need to watch out for others {%endcomment%}
    {{from_filters}}
    <br>
    {{filters_only}}


    <br>
    {%assign created_filter_first = drill_holder._link |split: 'f[users.created_date]=' | first %}
    first:{{created_filter_first}}
    <br>
    {%assign created_filter_last = drill_holder._link |split: 'f[users.created_date]=' | last %}
    last:{{created_filter_last}}
    <br>
    {%assign created_filter_value = created_filter_last |split: '&amp;' | first %}
    {%assign created_filter_remainder = created_filter_last |split: '&amp;' | last %}
    value:{{created_filter_value}}
    <br>
    {%assign manipulated_value = created_filter_value | split:'' | last | plus: 1 %}
    manipulated_value:{{manipulated_value}}
    <br>
    {%assign manipulated_value_date = created_filter_value | slice:0,9 |append: manipulated_value%}
    manipulated_value_date:{{ manipulated_value_date}}
    <br>
    {%assign rebuild_target_url = created_filter_first | append: 'f[users.created_date]=' |append: manipulated_value_date | append: created_filter_last %}
    {{rebuild_target_url}}
    ;;


  }
#     {% assign filters = from_filters_begin | split: '&' | first %}
}
explore: users {
  from: basic_users
  view_name: users
}
