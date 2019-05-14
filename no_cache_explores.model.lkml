connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project

explore: order_items_no_cache {
  view_name: order_items
  persist_for: "300 seconds"
}
