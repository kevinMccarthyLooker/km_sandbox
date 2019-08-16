connection: "thelook_events_redshift"

include: "basic_users.view"

view: users__constants {
  extends: [basic_users]
  dimension: x {
    label: "@{owner}"
    sql: @{owner} ;;
  }
}
explore: users__constants {}
explore: BAD {from:users__constants}
