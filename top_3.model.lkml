connection: "thelook_events_redshift"

include: "basic_users.*"

view: top_3 {
  extends: [basic_users]
  measure: top_3_zips {
    type: number
    sql: row_number() over() ;;
  }
}
explore: top_3 {}
