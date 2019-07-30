connection: "thelook_events_redshift"

# view: users_require_field_to_be_selected_on_explore {
#   sql_table_name: public.users ;;
#   dimension: to_be_required {
#     sql: 1 ;;
#   }
#   dimension: requires_another_field {
#     required_fields: [to_be_required]
#     sql: true ;;
#   }
#   dimension: age {
#     type: number
#   }
# }
# view: t2 {}
# explore: users_require_field_to_be_selected_on_explore {
#   access_filter: {
#     field: age
#     user_attribute: brand
#   }
#   sql_always_where: ${users_require_field_to_be_selected_on_explore.requires_another_field} ;;
#   always_join: [t2]
#   join: t2 {
#     sql: ${users_require_field_to_be_selected_on_explore.requires_another_field} ;;
#   }
# }
