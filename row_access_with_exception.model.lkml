connection: "thelook_events_redshift"

view: users {
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: first_name {}
}

view: use_this_to_invoke_exception_to_row_level_restriction {
  #made this field a parameter only to make clear it's a special thing.. but anything from this view will cause the exception to be invoked
  parameter: invoke_exception {
    #hidden: yes # unhide this to use on your special tile, then hide before pushing to production
    type: unquoted
    allowed_value: {label:"Yes" value:"Yes"}
  }
}

explore: users {
  sql_always_where:
(${users.first_name} ilike '{{_user_attributes['first_name']}}'
or
{% if use_this_to_invoke_exception_to_row_level_restriction._in_query %}true{% else %}false{% endif %} );;

  join: use_this_to_invoke_exception_to_row_level_restriction {sql:;;relationship:one_to_one}
}
