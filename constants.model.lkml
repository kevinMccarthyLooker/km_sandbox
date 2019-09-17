connection: "thelook_events_redshift"

include: "basic_users.view"

view: users__constants {
  extends: [basic_users]
  dimension: x {
    label: "@{owner}"
    sql: @{owner} ;;
  }


  dimension: y {
    sql:
    @{trim_quotes_begin}@{test_var}@{trim_quotes_end} ;;
  }
}
explore: users__constants {}
explore: BAD {from:users__constants}
