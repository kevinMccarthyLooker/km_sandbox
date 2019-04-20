connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


# my folding practice {

view: users__folding {
  sql_table_name: public.users ;;
  dimension: id {
    sql: ${TABLE}.id ;;
  }
  dimension: age {}
}

view: order_items_folding {
  sql_table_name: public.order_items ;;
  dimension: id {}
  dimension: order_id {}
  dimension: user_id {}
}

explore: order_items_folding {
  join: users__folding {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items_folding.user_id}=${users__folding.id} ;;
  }
}

# } end folding practice
