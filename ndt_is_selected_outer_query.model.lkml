connection: "thelook_events_redshift"

include: "basic_users.view"

view:  ndt_is_selected_outer_query_users{
  extends: [basic_users]
  dimension: test {
    sql: {% if t2._is_filtered %}1{%else%}0{%endif%} ;;
  }
  filter: t2 {sql:1=1;;}
}

explore: ndt_is_selected_outer_query_users {}

view: ndt {
  derived_table: {
    explore_source: ndt_is_selected_outer_query_users {
      column: test {field:ndt_is_selected_outer_query_users.test}
      filters: {field:ndt_is_selected_outer_query_users.age value:"20"}
      bind_filters: {from_field:ndt.t to_field:ndt_is_selected_outer_query_users.t2}
    }


  }
  filter: t {
    default_value: "0"
    sql:{% if ndt_is_selected_outer_query_users.age._is_selected %}1{%else%}0{%endif%};;}
  dimension: hi {sql:'hi';;}
  dimension: test {}
}

explore: ndt_is_selected_outer_query_users_with_ndt {
  # always_filter: {
  #   filters: {
  #     field:ndt.t
  #     value: "x"
  #   }
  # }
  view_name: ndt_is_selected_outer_query_users
  join: ndt {
    type: cross
    relationship: one_to_one
  }
}
