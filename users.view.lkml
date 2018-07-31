include: "functions.*"
view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    link: {
      url: "https://profservices.dev.looker.com/dashboards/31"
      label: "https://profservices.dev.looker.com/dashboards/31"
    }
    link: {
      url: "/dashboards/31"
      label: "/dashboards/31"
    }

  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: ${first_name}||' - '||${last_name} ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }

  measure: total_age {
    type: sum
    sql: ${age} ;;
  }



    #testing html inheritance
dimension: html_sql {
  type: string
  sql: '<a href="#drillmenu" target="_self">
    {% if 'GBP' contains 'GBP' %}
    <font>&#163;rendered_value</font>
    {% else %}
    <font>&#8364;rendered_value</font>
    {% endif %}
    </a>' ;;
}

  dimension: state2 {
    type: string
    sql: ${state} ;;
#     html: test ;;
    html:
    <a href="#drillmenu" target="_self">
    {% if 'GBP' contains 'GBP' %}
    <font>&#163;{{ rendered_value }}</font>
    {% else %}
    <font>&#8364;{{ rendered_value }}</font>
    {% endif %}
    </a>;;
  }
  dimension: state3 {
    type: string
    sql: '1' ;;
    html: {{ html_sql._sql | replace: "<a h","" }};;
  }

  #breaks down because you ._sql renders with curly brakets if/when the underlying fied has them
#   measure: avg_age {
#     type: number
#     sql: {{ functions.safe_divide._sql | replace: 'Replace_Parameter_1',age._sql | replace: 'Replace_Parameter_2',coun(id._sql) }} ;;
# #       sql: {{ functions.function_add._sql | replace:'Replace_Parameter_1','4' | replace:'Replace_Parameter_2','5'}} ;;
# #     sql: {{ functions.safe_divide._sql }};;
# #     sql: {{ functions.function_add._sql | replace:'Replace_Parameter_1','4' | replace:'Replace_Parameter_2','5'}} ;;
# # sql: {{ functions.function_add._sql }} ;;
#   }

}
