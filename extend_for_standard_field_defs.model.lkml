connection: "thelook_events_redshift"
explore: date_field_standards     {}
# explore: created_at_standard_date {}
explore: users__to_extend {}
view: date_field_standards {
  derived_table: {sql:select * from public.users limit 1;;}
  dimension: standard_date_input {
    sql: date('2018-01-01') ;;
  }
  dimension_group: standardized_dates  {
    type: time
    timeframes: [raw,date,year]
    sql: ${standard_date_input} ;;
  }
}

view: created_at_standard_date {
  extends: [date_field_standards]
  dimension: standard_date_input {
    sql:  '2019-01-01';;
  }
  dimension:standardized_dates{}
}

view: users__to_extend {
  extends: [date_field_standards,created_at_standard_date]
  dimension: another_field {}
  dimension: standard_date_input {
    sql:  ${users__to_extend.created_at};;
  }

  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {}
  measure: count {type:count}

  dimension: created_at {
    type: date_raw
    sql: ${TABLE}.created_at ;;
  }

}
