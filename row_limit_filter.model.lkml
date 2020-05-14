connection: "thelook_events_redshift"

include: "/**/basic_users.view"

view: row_limit_filter {
  extends: [basic_users]

  measure: row_number {
    type: number
    sql: row_number() over() ;;

  }
}
explore: row_limit_filter {}
