connection: "thelook_events_redshift"

#define an access grant that can be used to restrict access to various objects
access_grant: restricted_data_access {
  user_attribute: can_access_sensitive_data
  allowed_values: ["Yes"]
}


view: users {
  sql_table_name: public.users ;;
  dimension: id{primary_key:yes}
  dimension: state {}
  dimension: traffic_source {}
}

#restricted table
view: users_id_to_name_lookup {
  derived_table: {sql:select id, last_name, email from public.users;;}
  dimension: id{primary_key:yes}
  dimension: last_name {}
  dimension: email {}
}


explore: users {

  join: users_id_to_name_lookup {
    required_access_grants: [restricted_data_access]
    sql_on: ${users.id}=${users_id_to_name_lookup.id} ;;
    type: inner
    relationship: one_to_one
  }

}
