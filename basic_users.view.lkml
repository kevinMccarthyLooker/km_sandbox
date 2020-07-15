view: basic_users {
  sql_table_name: public.users ;;

  dimension: primary_key {primary_key: yes sql:${id};;}

  dimension: id {type: number}
  dimension: age {type: number}
  dimension: city {}
  dimension: country {map_layer_name: countries}
  dimension: email {}
  dimension: first_name {}
  dimension: gender {}
  dimension: last_name {}
  dimension: latitude {type: number}
  dimension: longitude {type: number}
  dimension: state {map_layer_name:us_states}
  dimension: traffic_source {}
  dimension: zip {type: zipcode}

  dimension_group: created {
    type: time
    timeframes: [raw,time,date,week,month,quarter,year]
    sql: ${TABLE}.created_at ;;
  }

  measure: count {
    label: "Count Users"
    type:count
  }

  drill_fields: [id]
}
