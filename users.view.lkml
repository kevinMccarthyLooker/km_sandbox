include: "functions.*"
include: "gender_user_dt.view.lkml"
view: users {
  sql_table_name: public.users ;;

  dimension: id {
#     primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: primary_key {
    primary_key: yes
    type: number
    sql: ${id};;
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
  #testing

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
      year,
      week_of_year
    ]
    sql: ${TABLE}.created_at ;;
#     convert_tz: no
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
    sql: floor(${TABLE}.latitude*100)/100+0.00000000000001 ;;
#     sql: ${TABLE}.latitude ;;
  }
#40.72245315260115,-74.01622844950676 ...
  dimension: longitude {
    type: number
    sql: floor(${TABLE}.longitude*100)/100+0.00000000000001 ;;
#     sql: ${TABLE}.longitude ;;
  }
#
  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude};;
  }



  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: us_states
#     map_layer_name: us_states # doesn't match to our map layer keys?
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
    map_layer_name: us_zipcode_tabulation_areas
  }

  measure: count {
    type: count
    filters:{
      field: primary_key
      value: "NOT NULL"
    }
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }

#   measure: count2 {
#     type: number
#     drill_fields: [id, first_name, last_name, events.count, order_items.count]
#     sql: power(sum(1),3) ;;
#   }

  parameter: week_of_year_parameter {
    type: number
  }

  dimension: satisfies_parameter {
    type: yesno
    sql: ${created_week_of_year}<={% parameter week_of_year_parameter %} ;;
  }
  measure: count__filtered_on_week{
    type: number
#     filters: {field:satisfies_parameter value:"Yes"}
#     sql:
#     case when max(${created_week_of_year})<= {% parameter week_of_year_parameter %} then
#     sum(count(case when ${created_week_of_year}<={% parameter week_of_year_parameter %} then 1 else null end)) over (
#     {% if first_name._is_selected %}PARTITION BY ${first_name}{% endif %}
#     {% if state._is_selected %}PARTITION BY ${state}{% endif %}
#     /*order by ${created_week}*/
#     order by ${state}
#     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
#     else null end
#     ;;

# for running total with week showing
#     sql:
#     case when
#     sum(count(case when ${created_week_of_year}<={% parameter week_of_year_parameter %} then 1 else null end)) over (
#     {% if first_name._is_selected %}PARTITION BY ${first_name}{% endif %}
#     {% if state._is_selected %}PARTITION BY ${state}{% endif %}
#     {% if location._is_selected %}PARTITION BY ${location}{% endif %}
#
#     {% if state._is_selected %}order by ${state}{% endif %}
#     {% if location._is_selected %}order by ${location}{% endif %}
#     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
#     >0
#     then
#     sum(count(case when ${created_week_of_year}<={% parameter week_of_year_parameter %} then 1 else null end)) over (
#     {% if first_name._is_selected %}PARTITION BY ${first_name}{% endif %}
#     {% if state._is_selected %}PARTITION BY ${state}{% endif %}
#     {% if location._is_selected %}PARTITION BY ${location}{% endif %}
#
#     order by
#     {% if state._is_selected %}order by ${state}{% endif %}
#     {% if location._is_selected %}order by ${location}{% endif %}
#     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
#     )
#     else null end
#     ;;
sql:

count(case when ${created_week_of_year}<={% parameter week_of_year_parameter %} then 1 else null end)

;;
  }


  measure: revenue__filtered_on_week{
    description: "modified to support map radius"
    type: number
    sql:sum(case when ${created_week_of_year}<={% parameter week_of_year_parameter %} then ${order_items.sale_price} else null end)
    /20
    ;;
  }

  measure: revenue__filtered_on_week_female{
    description: "modified to support map radius"
    type: sum
    filters: {field:satisfies_parameter value:"Yes"}
    filters: {field:gender value:"Female"}
    sql:${order_items.sale_price}
          /20
          ;;
          sql_distinct_key: ${order_items.id} ;;
  }
  measure: revenue__filtered_on_week_male{
    description: "modified to support map radius"
    type: sum
    filters: {field:satisfies_parameter value:"Yes"}
    filters: {field:gender value:"Male"}

    sql:${order_items.sale_price}
          /20
          ;;
    sql_distinct_key: ${order_items.id} ;;
  }


  measure: t2 {
    type: number
    sql: sum(1) over (rows between unbounded preceding and current row) ;;
  }

  measure: t {
    type: running_total
    sql: ${count__filtered_on_week} ;;
  }

  measure: total_age {
    type: sum
    sql: ${age} ;;
  }

  measure: running_count {
    type: running_total
    direction: "column"
    sql: ${count} ;;
  }

  measure: running_count_mod {
    type: number
    sql: case when ${count} is not null then ${running_count} else null end ;;
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

  filter: user_id {
    type: string

  }

  dimension: product_list {
    type: string
#     sql:  select min(${first_name}) from order_items left join users on order_items.user_id=users.id where order_items.product_id /*b-{% condition product_category %}*/{% endcondition %}/*-e*/;;
    sql: (select listagg(users.first_name,',') from public.order_items left join inventory_items on inventory_items.id=order_items.inventory_item_id left join users on order_items.user_id=users.id where cast(inventory_items.product_id as varchar) /*b-{% condition user_id %}*/{% endcondition %}/*-e*/;;
  }
#test grab sql
#   dimension: grab_sql_of_a_filter_field {}


parameter: friendly_created_date_filter {
  type: string
  allowed_value: {
    label:"Yesterday"
    value: "Yesterday"
  }
  allowed_value: {
    label:"Last 1 Week"
    value: "Last_1_Week"
  }
  default_value: "none_selected"
}

dimension_group: now_time_holder {
  type: time
  timeframes: [raw,date,month,year]
  sql: GETDATE() ;;
}
  dimension: range_end {
    type: date
    sql:
    dateadd(day,
    1,GETDATE()) ;;
  }
# dimension: in_last_7_days{
#   type: yesno
#   sql: (${created_raw}>=dateadd(day,-6, ${now_time_holder_date}) and ${created_raw}<dateadd(day,1,${now_time_holder_date}));;
# }
dimension_group: range_start {
  type: time
  timeframes: [raw,date,month,year]
  sql:
  dateadd(day,
  {% if friendly_created_date_filter._parameter_value == "'Yesterday'" %} -1 {% endif %}
  {% if friendly_created_date_filter._parameter_value == "'Last_1_Week'" %} -6 {% endif %}
  ,${now_time_holder_date}) ;;
}


filter: hidden_filter {
  type: date
  default_value: "the past 7 days"
}

dimension: in_query_or_test {
  sql:
  {% assign first_part = false %}
  {% assign second_part = false %}
  {% assign first_or_second = false %}
  {% if users.created_date._in_query %}date{% endif %}
  {% if users.created_month._in_query %}month{% endif %}
  {% if users.created_year._in_query %}2{% endif %}
  {% if (users.created_date._in_query or users.created_month._in_query) %}  first is true {% assign first_part = true %}{% endif %}
  {% if (users.created_year._in_query) %}  2nd is true {% assign second_part = true %}{% endif %}
  {% if (users.created_date._in_query OR users.created_month._in_query) AND (users.created_year._in_query)  %}test logic output{% endif %} /*evaluates to true */
  {% if second_part or first_part %}{% assign first_or_second = true %}{% endif %}
  {% if first_part %}
    {% if second_part %}

    {% endif %}
  {% endif %}
  f:{{first_part}}
  S:{{second_part}}
  {{first_or_second}}
  ;;
}

  dimension: in_query_or_test_example {
    sql:
      {% assign first_part = false %}
      {% if users.created_date._in_query or users.created_month._in_query %}{% assign first_part = true %}{% endif %}

      {% assign second_part = false %}
      {% if users.created_year._in_query %}{% assign second_part = true %}{% endif %}

      {% assign first_and_second = false %}
      {% if first_part and second_part %}/* do something cool */{% endif %}
      ;;
  }

  dimension: test_faceted_filters {
    sql: '1' ;;
#     suggest_explore: gender_user_dt
#     suggest_dimension: gender_user_dt.value
    suggest_persist_for: "0 minutes"
#     suggest_explore:users
    suggest_dimension: for_suggestions
  }


  dimension: t1 {
    suggest_persist_for: "0 minutes"
    sql: {% condition users.gender %}${gender}{% endcondition %} ;;
  }

  dimension: for_suggestions {
    suggest_persist_for: "0 minutes"
#     case when {% condition users.gender %}${gender}{% endcondition %} then ${first_name} else null end ;;
    sql:
    {{t1._sql}}
    {% assign t = t1._sql %}
    case when  {{t}} then ${first_name} else null end ;;

  }

dimension: test_link {
  sql: '1' ;;
  link: {
    label: "test google with line break"
    url:
    "https://google{% comment %}
    {% endcomment %}.{% comment %}
    {% endcomment %}com"
  }
}


dimension: city2 {
  sql: {{city._sql}} ;;
}
dimension: city3 {
  sql: {{city2._sql}} ;;
}
dimension: city_concat {
  sql: ${city}||'test' ;;
}
dimension: city_concat2 {
  sql: {{city_concat._sql}} ;;
}

parameter: date_param {
  label: "param"
  type: date
}

dimension: date_start_exposure {
#   sql: {% condition created_date %}'t' {% endcondition%}
# sql: {% date_param._parameter_value %}
sql:  {% parameter date_param %}

  ;;
}

dimension: in_query_test {
  type: string
  sql: {{users.city._in_query}}
  {% if users.city._in_query %}
  1=1
  {% else %}
  eval to false
  {% endif %}
  ;;
}
}
