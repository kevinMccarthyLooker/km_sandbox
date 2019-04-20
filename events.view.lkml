view: events {
  sql_table_name: public.events ;;

##### FOLD: keys {
dimension: id {
#     primary_key: yes
  type: number sql: ${TABLE}.id ;;
}
dimension: primary_key {
  type: number
  primary_key: yes
  sql: ${id} ;;
}
dimension: session_id {
  type: string
  sql: ${TABLE}.session_id ;;
}
dimension: user_id {
  type: number
  # hidden: yes
  sql: ${TABLE}.user_id ;;
}
##}<fold keys

##### FOLD: dates {
  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }
#}<fold dates

##### FOLD: location {
dimension: city {
  type: string
  sql: ${TABLE}.city ;;
}
dimension: country {
  type: string
  map_layer_name: countries
  sql: ${TABLE}.country ;;
}
dimension: latitude {
  type: number
  sql: ${TABLE}.latitude ;;
}
dimension: longitude {
  type: number
  sql: ${TABLE}.longitude ;;
}
dimension: zip {
  type: zipcode
  sql: ${TABLE}.zip ;;
}
dimension: state {
  type: string
  sql: ${TABLE}.state ;;
}
#}<fold location

##### Fold: Other Fields {
dimension: browser {
  type: string
  sql:
  --{fold within sql
  -- pretending there's a long block of sql
  -- pretending there's a long block of sql
  -- pretending there's a long block of sql
  -- pretending there's a long block of sql
  -- pretending there's a long block of sql
    ${TABLE}.browser
  -- pretending there's a long block of sql
  -- pretending there's a long block of sql
  -- pretending there's a long block of sql
  -- pretending there's a long block of sql
  --}^fold within sql
  -- pretending there's a long block of sql
    ;;
}
dimension: event_type {
  type: string
  sql: ${TABLE}.event_type ;;
}
dimension: ip_address {
  type: string
  sql: ${TABLE}.ip_address ;;
}
dimension: os {
  type: string
  sql: ${TABLE}.os ;;
}
dimension: sequence_number {
  type: number
  sql: ${TABLE}.sequence_number ;;
}
dimension: traffic_source {
  type: string
  sql: ${TABLE}.traffic_source ;;
}
dimension: uri {
  type: string
  sql: ${TABLE}.uri ;;
}
#####}<fold other fields

##### Fold: Measures {
measure: count {
  type: number
  sql: sum(case when ${primary_key} is not null then 1 else null end) ;;
#     type: count
#     filters:{
#       field: primary_key
#       value: "NOT NULL"
#     }
  drill_fields: [id, users.id, users.first_name, users.last_name]
}
#}<fold measures
}
