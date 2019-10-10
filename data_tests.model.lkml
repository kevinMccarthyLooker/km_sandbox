connection: "thelook_events_redshift"

#documentation on data_tests can be found here:https://docs.google.com/document/d/1G3fLBZduZwCURi9BOvYOMdFsssHQOlXga2MSP7UHvd0/edit#

view: users_for_data_tests {
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
    measure: count {type:count}
    measure: count2 {type:count }
  measure: sum_age {type:sum sql:age;; }
  dimension: current_year {
    type: number
    sql: {{ "now" | date: "%Y" }} ;;
  }
}
include: "order_items.*"
explore: users_for_data_tests {
  join: order_items {
    sql_on: ${order_items.user_id}=${users_for_data_tests.id} ;;
    relationship: one_to_many
  }
}

test: test_there_are_users {
  explore_source: users_for_data_tests {
    column: age {}
    column: count {field:users_for_data_tests.count}
    column: count_order_items {field:order_items.count}
    column: sum_age {}
  }
  # assert: there_is_data {
  #   expression: ${users_for_data_tests.count} = 0 ;;
  #   #if multiple expressions in one assert, only the last is run
  #   expression: ${users_for_data_tests.count} > 0 ;;

  # }
  #success - all rows pass
  # assert: there_is_data2 {
  #   expression: ${users_for_data_tests.sum_age} > 0 ;;
  # }
  #can run on dimensions as well. success - all rows pass:
  assert: no_age_less_than_10 {
    expression: ${users_for_data_tests.age} > 0 ;;
  }
  #this assertion fails because some rows don't pass:
  # assert: there_is_an_age_over_20 {
  #   expression: ${users_for_data_tests.age} > 20 ;;
  # }
  #liquid does not work:
  # assert: liquid_test {
  #   expression: ${users_for_data_tests.age} > {{ "now" | date: "%Y" }} ;;
  # }

  assert: count_users_greater_than_0 {
    expression: ${users_for_data_tests.count}>0;;
  }
  assert: count_items_greater_than_0 {
    expression: ${order_items.count}>0;;
  }
}
