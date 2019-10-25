view: basic_users {
  sql_table_name: public.users ;;
  dimension: id {
    primary_key: yes
    type: number
  }
  dimension: age {type: number}
  dimension: city {}
  dimension: country {map_layer_name: countries}
  dimension_group: created {
    type: time
    timeframes: [raw,time,date,week,month,quarter,year]
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }
  dimension: email {}
  dimension: first_name {}
  dimension: gender {}
  dimension: last_name {}
  dimension: latitude {type: number}
  dimension: longitude {type: number}
  dimension: state {}
  dimension: traffic_source {}
  dimension: zip {type: zipcode}
  measure: count {type:count
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
}
