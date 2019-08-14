connection: "thelook_events_redshift"

include: "basic_users.view"

view: users__constants {
  extends: [basic_users]
  dimension: x {
    sql: @{owner} ;;
#     sql: {{ _explore._name}} ;;
  }
}
explore: users__constants {}
