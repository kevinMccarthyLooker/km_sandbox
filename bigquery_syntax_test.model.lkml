connection: "biquery_publicdata_standard_sql"
view: usa_summary_1880_2015 {
  sql_table_name: `fh-bigquery.popular_names.usa_summary_1880_2015`
    ;;

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: number {
    type: number
    sql: ${TABLE}.number ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

view: rank_name {
  derived_table: {
    sql: select name, row_number() over(order by count_records desc) as rank from
          (select name, count(*) from `fh-bigquery.popular_names.usa_summary_1880_2015` group by name
          ) a;;
  }
  dimension: name {}
  dimension: rank {type:number}
}

explore: usa_summary_1880_2015 {
  join: rank_name {
    type: left_outer
    sql_on: ${rank_name.name}=${usa_summary_1880_2015.name} ;;
    relationship: many_to_one
  }
}
