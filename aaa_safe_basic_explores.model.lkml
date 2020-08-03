connection: "thelook_events_redshift"

include: "basic_users.view"
explore: basic_users {
  sql_always_where: {%condition basic_users.city_2%}city{%endcondition%} ;;
}

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


#olga Dernovska test 8/3
# view: subtotal_over {}
view: subtotal_over {
  sql_table_name: (select '' as row_type union select null as row_type) ;; #This sql table name is used to create a duplicate copy of the data. When rowType is null, fields from this view will resolve to 'SUBTOTAL'

  #used in sql parameters below to re-assign values to 'SUBTOTAL' on subtotal rows
  dimension: row_type_checker {
    hidden:yes
    sql: ${TABLE}.row_type ;;
  }
  # used for readability in sql_where of nested subtotal join
  dimension: row_type_description {
    hidden:yes
    sql:coalesce(${TABLE}.row_type,'SUBTOTAL');;
  }

#######################################
### Example String Based Dimensions ###
  dimension: gender {
#     order_by_field: product_order
    # For subtotal rows: show 'SUBTOTAL'.  For nulls, show '∅' (supports intuitive sorting).  Otherwise use raw base table field's data. Note, concatenation with '${row_type_checker}' is used to concisely force subtotal rows to evaluate to null, which is then converted to 'SUBTOTAL'
    sql: coalesce(cast(coalesce(cast(${basic_users.gender} as varchar),'∅')||${row_type_checker} as varchar),'SUBTOTAL');;
  }
}
explore: basic_users_subtotal {
  view_name: basic_users
#Join the subtotaling view using a cross join.
  join: subtotal_over {
    type: cross
    relationship: one_to_many
  }
}
