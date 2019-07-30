connection: "thelook_events_redshift"

view: dummy_base {
  derived_table: {
    sql: select null as t ;;
  }
}

view: favazza_users {
  sql_table_name: public.users ;;
  dimension: id {primary_key: yes sql:favazza_users.id;;}
  dimension: age {type:number sql:favazza_users.age;;}
  dimension: gender {sql:favazza_users.gender;;}
  set: regular {fields:[id,age]}
  set: restricted {fields:[gender]}
}

access_grant: favazza_users_restricted_fields {
  user_attribute: brand
  allowed_values: ["%"]
}

explore: favazza {
  from: dummy_base
  view_name: dummy_base
  join: favazza_users {
    fields: [favazza_users.regular*]
    type: cross
    relationship: one_to_one
  }
  join: favazza_users_restricted_fields {
    required_access_grants: [favazza_users_restricted_fields]
    view_label: "Favazza Users"
    from: favazza_users
    fields: [favazza_users_restricted_fields.restricted*]
    sql:  ;;
  relationship: one_to_one
  }
}
