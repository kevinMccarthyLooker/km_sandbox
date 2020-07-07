view: basic_users {
  sql_table_name: public.users ;;
  dimension: primary_key {primary_key: yes sql:${id};;}
  dimension: id {
    type: number
  }
  dimension: age {type: number}
  dimension: city {}
  dimension: city_with_comma {
    sql: concat(${city},',') ;;
  }
  dimension: country {map_layer_name: countries}
  dimension_group: created {
    type: time
    timeframes: [raw,time,date,week,month,quarter,year]
    sql: ${TABLE}.created_at ;;
  }
#   dimension: created_raw_visible {
#     label: "Created Raw"
#     group_label: "Created Date"
#     group_item_label: "Raw"
#     sql: ${created_raw} ;;
#     datatype: datetime
#     type: date_time
#     convert_tz: no
#   }
  dimension: email {}
  dimension: first_name {}
  dimension: gender {}
  dimension: last_name {}
  dimension: latitude {type: number}
  dimension: longitude {type: number}
  dimension: state {map_layer_name:us_states}
  dimension: traffic_source {}
  dimension: zip {type: zipcode}
  measure: count2 {type:count}
  measure: count {
    label: "Count Users"
    type:count
#     html:
#     {% if count_percent_of_previous._value > 0.5 %}high{%else%}low{%endif%}{{value}} ;;
# #     html: {% if users.count_percent_of_previous._rendered_value > 0.5 %}high{%else%}low{%endif%} ;;
    }
#   measure: count2 {type:count }
#   measure: count_percent_of_previous {
#     type: percent_of_previous
#     sql: ${count} ;;
# #     direction: ""
#   }

# measure: count2 {
#   type: count
#   html: <script type="text/javascript">
#   t document.getElementById("foo").setAttribute("href", _spPageContextInfo.siteAbsoluteUrl);
# </script> ;;
drill_fields: [id]
# }

  measure: date_measure {
    type: date
    sql: ${created_raw} ;;
  }
  measure: date_max {
    type: date
#     filters: {field:gender value:"Male"}
    sql: max(${created_raw}) ;;

  }
  measure: date_measure2 {
    type: date
    sql: ${date_max} ;;
  }
  dimension: date_as_string {
    sql: ${TABLE}.created_at ;;
  }
  dimension: val {
    sql: '1' ;;
#     html: {{date_as_string._value}} ;;
    html:
    date_as_string:{{date_as_string._value}}
    {% assign yesterday_var = date_as_string._value  | date: "%d" %}
    {{yesterday_var}}
    {% assign max_date_var = date_as_string._value | date: "%d" %}
    {{max_date_var}}
    {% if max_date_var == yesterday_var %}
t
    {% else %}
t2
    {% endif %};;
  }

}
