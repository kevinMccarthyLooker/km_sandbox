view: basic_users {
  sql_table_name: public.users ;;

  dimension: primary_key {primary_key: yes sql:${id};;}

  dimension: id {type: number}
  dimension: age {type: number}
  dimension: city {}
  dimension: country {map_layer_name: countries}
  dimension: email {}
  dimension: first_name {}
  dimension: gender {}
  dimension: last_name {}
  dimension: latitude {type: number}
  dimension: longitude {type: number}
  dimension: location {
    type:location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }
  dimension: state {map_layer_name:us_states}
  dimension: traffic_source {}
  dimension: zip {type: zipcode}

  dimension_group: created {
    type: time
    timeframes: [raw,time,time_of_day,date,week,week_of_year,month,quarter,year]
    sql: ${TABLE}.created_at ;;
  }

  measure: count {
    label: "Count Users"
    type:count
  }

  measure: hour {
    type: date_time_of_day
    sql: max(${created_raw}) ;;
  }

#   drill_fields: [id]

}

view: time_of_date {
  derived_table: {
    sql: select 101 as time union all select 201;;
  }
  dimension: time {}
  measure: max_time {
    type: max
    sql: ${time} ;;
  }
}

# explore: time_of_date {
# #   join: basic_users {
# #     type: full_outer
# #     sql_on: ${time_of_date.time}=${basic_users.created_time_of_day} ;;
# #   }
# }

# view: test {
#you can get an error in this scenario... field_name = view_name.another_field_name (with _ instead of .)
#   extends: [basic_users]
#   dimension_group: test_basic {
#     type: time
#     timeframes: [raw, date]
#     sql: created_at ;;
#   }
#   dimension_group: test_test_basic {
#     type: time
#     timeframes: [raw, date]
#     sql: created_at ;;
#   }
#
# }
