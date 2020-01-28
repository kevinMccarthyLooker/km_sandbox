connection: "thelook_events_redshift"

#beginning challenge:
#report on ecommerce sales alongside web event traffic

view: empty_base {
  derived_table: {sql: select null::integer as null_placeholder from (select null)t where 1=0 ;;}
  dimension: null_placeholder {}
}

#basic view declarations
view: users {
  sql_table_name: public.users ;;

  dimension: id {type: number primary_key:yes}

  dimension: first_name {}
  dimension: last_name {}
  dimension: email {}
  dimension: age {}
  dimension: city {}
  dimension: state {}
  dimension: country {}
  dimension: zip {}
  dimension: gender {}
  dimension: traffic_source {}

  dimension_group: created_at {type: time timeframes:[date,month]}
  dimension: latitude {type: number}
  dimension: longitude {type: number}
  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  measure: count {type: count}
}


view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {primary_key: yes type: number}

  dimension: order_id {type: number}
  dimension: user_id {type: number}
  dimension: inventory_item_id {type: number}
  dimension: status {}
  dimension_group: created_at {type: time timeframes:[date,month]}
  dimension_group: returned_at {type: time timeframes:[date,month]}
  dimension_group: shipped_at {type: time timeframes:[date,month]}
  dimension_group: delivered_at {type: time timeframes:[date,month]}

  dimension: sale_price {type: number}

  measure: count {type: count}
  measure: total_sale_price {type:sum}
}

#next: add inventory Items view

view: events {
  sql_table_name:public.events;;

  dimension: id {primary_key: yes type: number}

  dimension: user_id {type: number}
  dimension: session_id {}
  dimension: sequence_number {type: number}
  dimension: ip_address {}
  dimension: city {}
  dimension: state {}
  dimension: country {}
  dimension: zip {}
  dimension: latitude {type: number}
  dimension: longitude {type: number}
  dimension: os {}
  dimension: browser {}
  dimension: traffic_source {}
  dimension: uri {}
  dimension: event_type {}

  dimension_group: created_at {type: time timeframes:[date,month]}

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  measure: count {type:count}
}


## Basic explores
explore: order_items_base {
  view_name: order_items
  join: users {
    sql_on: ${order_items.user_id}=${users.id} ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: events_base {
  view_name: events
  join: users {
    sql_on: ${events.user_id}=${users.id} ;;
    relationship: many_to_one
    type: left_outer
  }
}

## NDTs to create fact tables.  Get All dimension Keys and KPIS
view: order_items_sales_ndt {
  derived_table: {
    explore_source: order_items_base {
      column: users_id {field:users.id}
      # column: order_id {field:order_items.order_id}
      column: inventory_item_id {field:order_items.inventory_item_id}
      column: order_created_at_date {field:order_items.created_at_date}

      column: count_sales {field:order_items.count}
      # bind_all_filters: yes
      bind_filters: {from_field: users.age               to_field: users.age}
      bind_filters: {from_field: users.city              to_field: users.city}
      bind_filters: {from_field: users.first_name        to_field: users.first_name}
      bind_filters: {from_field: users.last_name         to_field: users.last_name}
      bind_filters: {from_field: users.email             to_field: users.email}
      bind_filters: {from_field: users.state             to_field: users.state}
      bind_filters: {from_field: users.country           to_field: users.country}
      bind_filters: {from_field: users.zip               to_field: users.zip}
      bind_filters: {from_field: users.gender            to_field: users.gender}
      bind_filters: {from_field: users.traffic_source    to_field: users.traffic_source}

      bind_filters: {from_field: users.created_at_date   to_field: users.created_at_date}
      bind_filters: {from_field: users.created_at_month  to_field: users.created_at_month}
      bind_filters: {from_field: users.latitude          to_field: users.latitude}
      bind_filters: {from_field: users.longitude         to_field: users.longitude}
      bind_filters: {from_field: users.location          to_field: users.location}
    }
  }
  dimension: users_id {hidden:yes}
  dimension: inventory_item_id {hidden:yes}
  dimension: order_created_at_date {type:date hidden:yes}

  dimension: count_sales {hidden:yes}

  measure: total_count_sales {type:sum sql:${count_sales};;}
}

view: events_ndt {
  derived_table: {
    explore_source: events_base {
    # explore_source: blended {
      column: users_id {field:users.id }
      column: event_created_at_date {field:events.created_at_date}
      column: count_events {field:events.count}
      # bind_all_filters: yes
      bind_filters: {from_field: users.age               to_field: users.age}
      bind_filters: {from_field: users.city              to_field: users.city}
      bind_filters: {from_field: users.first_name        to_field: users.first_name}
      bind_filters: {from_field: users.last_name         to_field: users.last_name}
      bind_filters: {from_field: users.email             to_field: users.email}
      bind_filters: {from_field: users.state             to_field: users.state}
      bind_filters: {from_field: users.country           to_field: users.country}
      bind_filters: {from_field: users.zip               to_field: users.zip}
      bind_filters: {from_field: users.gender            to_field: users.gender}
      bind_filters: {from_field: users.traffic_source    to_field: users.traffic_source}

      bind_filters: {from_field: users.created_at_date   to_field: users.created_at_date}
      bind_filters: {from_field: users.created_at_month  to_field: users.created_at_month}
      bind_filters: {from_field: users.latitude          to_field: users.latitude}
      bind_filters: {from_field: users.longitude         to_field: users.longitude}
      bind_filters: {from_field: users.location          to_field: users.location}
    }
  }
  dimension: users_id {hidden:yes}
  dimension: event_created_at_date {type:date hidden:yes}
  dimension: count_events {hidden:yes}
  measure: total_count_events {type:sum sql:${count_events};;}
}

view: coalesce_dimensions {
  dimension: users_id {sql:coalesce(${order_items_sales_ndt.users_id},${events_ndt.users_id});;}
  # dimension: order_id {type: number sql:coalesce(${order_items_sales_ndt.order_id});;}
  dimension: inventory_item_id {type: number sql:coalesce(${order_items_sales_ndt.inventory_item_id});;}
  dimension: created_at_date {sql:coalesce(${order_items_sales_ndt.order_created_at_date},${events_ndt.event_created_at_date});;}
}

explore: blended {
  # view_name: order_items_sales_ndt
  view_name: empty_base

  join: coalesce_dimensions {sql:;; relationship:one_to_one}

  #will need to hide measures from the original table
  join: order_items_sales_ndt {
    sql: full outer join order_items_sales_ndt on ${empty_base.null_placeholder} = ${order_items_sales_ndt.users_id};;
    relationship: one_to_one
  }
  join: events_ndt {
    sql: full outer join events_ndt on ${empty_base.null_placeholder} = ${events_ndt.users_id};;
    relationship: one_to_one
  }

  #will need to hide measures from the original table
  join: users {
    sql_on: ${coalesce_dimensions.users_id}=${users.id} ;;
    relationship: many_to_one
  }
}



##test explores:
#explore: order_items_sales_ndt {}
#explore: events_ndt {}
