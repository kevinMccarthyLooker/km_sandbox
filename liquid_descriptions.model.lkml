connection: "thelook_events_redshift"

include: "basic_users.*"

view: liquid_descriptions {
  extends: [basic_users]
  parameter: test {}
  dimension: field_with_liquid_description {
    description: "
    {{ test._parameter_value}}
    -
    {{_user_attributes['name']}}"
    sql: 1 ;;
  }
}
explore: liquid_descriptions {}

# view: v2 {
#   derived_table: {
#     explore_source: liquid_descriptions {
#       column: age {}
#       column: count {}

#     }
#   }
#   dimension: age {}
#   dimension: count {}
# }

# explore: v2 {}

# view: v3 {
#   derived_table: {
#     sql: select * from {{v2._sql}} v2;;

#   }
#   dimension: age {}
#   dimension: count {}
# }

# explore: v3 {}
