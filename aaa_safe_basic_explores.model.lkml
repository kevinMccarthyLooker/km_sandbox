connection: "thelook_events_redshift"

include: "basic_users.view"
explore: basic_users {}

include: "order_items.view"
include: "inventory_items.view"
explore: order_items {
  join: users {
    from: basic_users
    sql_on: ${users.id}=${order_items.user_id} ;;
    relationship: many_to_one
  }
  join: inventory_items {
    sql_on: ${inventory_items.id}=${order_items.inventory_item_id} ;;
    relationship: many_to_one
  }
}
