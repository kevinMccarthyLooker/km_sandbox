connection: "thelook_events_redshift"

include: "basic_users.view"
# include: "merge_filter_example.dashboard"


## 7/15 working on bryan's better link generation
## findings:
### Can't do any of this except in the html/render layer
### Can't pass html from one field to another
### Bryan used constants, but how would we make those fully generic
view: +basic_users {
  measure: drill_link_listener {
    # hidden: yes
    type: sum
    sql: 1 ;;
    drill_fields: []
  }
  measure: drill_link_listener_link {
    type: sum
    sql: 1 ;;
    html: {{basic_users.drill_link_listener._link}} ;;
  }

  measure: html_checker {
    type: sum
    sql: 1 ;;
    html:  {{drill_link_listener_link._rendered_value}};;
  }
}


include: "test_thin*"
explore: basic_users {
  # persist_with: test_datagroup
}

view: users_with_running_total {
  extends: [basic_users]
  measure: running_total {
    description: "{% if _user_attributes['first_name'] =='Kevin' %}hi kevin{% else%}{{_user_attributes['first_name']}}{%endif%}"
    direction: "column"
    type: running_total
    sql: ${count} ;;
  }
}
explore: users_with_running_total {}

# datagroup: test_datagroup {
#   sql_trigger: select count(*) from public.users ;;
#   max_cache_age: "24 hours"
# }
include: "order_items.*"
include: "inventory_items.*"
explore: order_items {
  join: users {
    from: basic_users
    sql_on: ${users.id}=${order_items.user_id} ;;
    relationship: many_to_one
  }
  join: inventory_items {
    sql_on: ${inventory_items.id}=${order_items.inventory_item_id} ;;
    relationship: many_to_one
  }
}

explore: basic_users_x {
  from: basic_users
  sql_always_where: {{_user_attributes['name']}} ;;
}

view: date_test {
  extends: [basic_users]
  dimension: my_date {
    type: date
    datatype: epoch
    sql: '2099-01-01'::date ;;
  }
}
explore: date_test {}


# include: "overlay.dashboard"
#
# view: basic_users {
#
#   dimension: special_case_when_for_city {
#     case: {
#       when: {sql:${city}='Boston';; label:"AAwesome"}
#       when: {sql:${city}='New York';; label:"AAwesome"}
#       else: "{{city_sql_holder._sql}}"
#     }
#   }
#
#   dimension: city_sql_holder {
#     sql: ' || {{city._sql}} || ';;
#   }
#
#   parameter: multy_contains {}
#
#   dimension: multy_contains_result {
#     type: yesno
#     sql: ${city} like {{multy_contains._parameter_value}} ;;
#   }
#
#
#
#
#
#
#
#
#   sql_table_name: public.users ;;
#   dimension: primary_key {primary_key: yes sql:${id};;}
#   dimension: id {
#     type: number
#   }
#   dimension: age {type: number}
#   dimension: city {}
#   dimension: city_with_comma {
#     sql: concat(${city},',') ;;
#   }
#   dimension: country {map_layer_name: countries}
#   dimension_group: created {
#     type: time
#     timeframes: [raw,time,date,week,month,quarter,year]
#     sql: ${TABLE}.created_at ;;
#   }
# #   dimension: created_raw_visible {
# #     label: "Created Raw"
# #     group_label: "Created Date"
# #     group_item_label: "Raw"
# #     sql: ${created_raw} ;;
# #     datatype: datetime
# #     type: date_time
# #     convert_tz: no
# #   }
#   dimension: email {}
#   dimension: first_name {}
#   dimension: gender {}
#   dimension: last_name {}
#   dimension: latitude {type: number}
#   dimension: longitude {type: number}
#   dimension: state {map_layer_name:us_states}
#   dimension: traffic_source {}
#   dimension: zip {type: zipcode
#     html: {{rendered_value}} || {{city._rendere_value}};;
#   }
#   measure: count2 {type:count}
#   measure: count {
#     label: "Count Users"
#     type:count
# #     html:
# #     {% if count_percent_of_previous._value > 0.5 %}high{%else%}low{%endif%}{{value}} ;;
# # #     html: {% if users.count_percent_of_previous._rendered_value > 0.5 %}high{%else%}low{%endif%} ;;
#   }
# #   measure: count2 {type:count }
# #   measure: count_percent_of_previous {
# #     type: percent_of_previous
# #     sql: ${count} ;;
# # #     direction: ""
# #   }
#
# # measure: count2 {
# #   type: count
# #   html: <script type="text/javascript">
# #   t document.getElementById("foo").setAttribute("href", _spPageContextInfo.siteAbsoluteUrl);
# # </script> ;;
#   drill_fields: [id]
# # }
#
#   measure: date_measure {
#     type: date
#     sql: ${created_raw} ;;
#   }
#   measure: date_max {
#     type: date
# #     filters: {field:gender value:"Male"}
#     sql: max(${created_raw}) ;;
#
#   }
#   measure: date_measure2 {
#     type: date
#     sql: ${date_max} ;;
#   }
#   dimension: date_as_string {
#     sql: ${TABLE}.created_at ;;
#   }
#   dimension: val {
#     sql: '1' ;;
# #     html: {{date_as_string._value}} ;;
#     html:
#     date_as_string:{{date_as_string._value}}
#     {% assign yesterday_var = date_as_string._value  | date: "%d" %}
#     {{yesterday_var}}
#     {% assign max_date_var = date_as_string._value | date: "%d" %}
#     {{max_date_var}}
#     {% if max_date_var == yesterday_var %}
# t
#     {% else %}
# t2
#     {% endif %};;
#   }
#
# }
#
#
# view: +basic_users {
#   dimension: special_case_when_for_city {
#     case: {
#       when: {sql:${city}='Seattle';; label:"AAwesome"}
#       when: {sql:${city}='Atlanta';; label:"AAwesome"}
#       else: "{{city_sql_holder._sql}}"
#     }
#   }
# }
