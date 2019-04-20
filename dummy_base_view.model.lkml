connection: "thelook_events_redshift"

##dummy to be used as base view
view: dummy {derived_table: {sql: select null as placeholder ;;}}
## the view that we could re-use
view: users_for_dummy_base_view_demo {
  dimension: id {primary_key:yes}
  dimension: age {type:number sql:{{_field._name | split: '.' | first }}.age;;}
}
### explore
explore: explore_title {
  from: dummy
  join: users {
#     sql_table_name: public.users ;;
    from:users_for_dummy_base_view_demo
    type: cross
    relationship: one_to_one
  }
}
