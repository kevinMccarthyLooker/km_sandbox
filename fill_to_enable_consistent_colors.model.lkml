connection: "thelook_events_redshift"

include: "basic_users.view"

# view: users_with_country_fill_filter {
#   extends: [basic_users]
#   f
# }


explore: basic_users {}


view: countries_list_from_users {
  derived_table: {
    explore_source: basic_users {
      column: country {field:basic_users.country}
    }
    persist_for: "24 hours"
    distribution_style: all
  }
  dimension: country {}
  filter: country_nullify_but_dont_filter {}

}

# explore: countries_list_from_users {} gives a list of all possible counters

explore: filled_countries {
  fields: [ALL_FIELDS*]
  from: countries_list_from_users
  view_name: countries_list_from_users
  view_label: "Basic Users"
  join: basic_users {
    view_label: "Basic Users"
    type: left_outer
    relationship: one_to_many
    sql_on:
${basic_users.country}=${countries_list_from_users.country}
and {%condition countries_list_from_users.country_nullify_but_dont_filter %}${basic_users.country}{%endcondition%}
;;
  }
}
