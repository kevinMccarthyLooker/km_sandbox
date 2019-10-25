include: "basic_users.*"
include: "order_items.*"

connection: "thelook_events_redshift"

view: sequence_test__users {extends: [basic_users]}
view: sequence_test__items {extends: [order_items]
  dimension: created_date2 {
    sql: ${created_date} ;;
  }
  }
explore: sequence_test {
  from: sequence_test__items
  view_name: sequence_test__items
  join: sequence_test__users {
    relationship: many_to_one
    sql_on: ${sequence_test__items.user_id}=${sequence_test__users.id} ;;
  }
  join: ranker_input {
    sql_on:
    ${sequence_test__items.created_date}=${ranker_input.other_key::date}
    and
    ${sequence_test__users.age}=${ranker_input.row_number_over}
    and
    ${sequence_test__items.created_date2}=${ranker_input.sort_field}
    ;;
    relationship: one_to_one
  }
}


view: ranker_input {
  derived_table: {
    explore_source: sequence_test {
      timezone: "America/Los_Angeles"
      column: row_number_over {field:sequence_test__users.age}
      column: other_key {field:sequence_test__items.created_date}
      column: sort_field {field:sequence_test__items.created_date2}
      derived_column: sequence_number {sql:ROW_NUMBER() OVER(PARTITION BY row_number_over ORDER BY sort_field);;}
    }
  }
  dimension: row_number_over {}
  dimension: other_key {type:date}
  dimension: sequence_number {}
  dimension: sort_field {}

}
