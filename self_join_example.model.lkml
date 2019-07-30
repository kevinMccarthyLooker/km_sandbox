connection: "thelook_events_redshift"

view: data {
  derived_table: {
    sql:
    select 1000 as id, 1 as value
    union all
    select 1001 as id, 2 as value
    ;;
  }
  dimension: id {type:number primary_key:yes}
  dimension: value {type:number}

  measure: total_value {
    type: sum
    sql: ${value} ;;
  }

#   measure: calculation {
#     type: number
#     sql: ${total_value}*1.0/nullif(${data_alias.total_value},0) ;;
#     value_format_name: decimal_1
#   }

}

view: cross_view_comparison {
  #no table
  measure: measure_input {sql:${data.total_value};;}
  measure: calculation {
    type: number
    sql: ${measure_input}*1.0/nullif(${data_alias.total_value},0) ;;
    value_format_name: decimal_1
  }
}



explore: data {
  join: data_alias {
    from: data
    sql_on: ${data_alias.id}-1=${data.id} ;;
    relationship: one_to_one
  }
  join: cross_view_comparison {
    sql:  ;;
    relationship: one_to_one
  }

}

explore: data2 {
  from: data
  view_name: data
}
