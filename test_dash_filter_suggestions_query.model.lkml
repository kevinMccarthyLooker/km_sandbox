connection: "thelook_events_redshift"

include: "/**/basic_users.view"
include: "/**/order_items.view"



view: test_dash_filter_suggestions_query_users {
  extends: [basic_users]
  dimension: city {
    suggest_persist_for: "0 minutes"
  }
}
view: test_dash_filter_suggestions_query_order_items  {
  extends: [order_items]

}

explore: test_dash_filter_suggestions_query_order_items {

  join: test_dash_filter_suggestions_query_users {
    relationship: one_to_one
    type: inner
    sql_on: ${test_dash_filter_suggestions_query_users.id}=${test_dash_filter_suggestions_query_order_items.user_id} ;;
  }
  # sql_always_where: 1=1 ;;
  sql_always_having: ${test_dash_filter_suggestions_query_order_items.count}>1 ;;
}
