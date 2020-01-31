connection: "thelook_events_redshift"

view: scott_percent_of_total_20200201 {
  derived_table: {
    sql:
Select 'PA' as state,'Philadelphia' as city,5 as responses union all
select 'PA','Bensalem',1  union all
select 'NJ','Delran',17  union all
select 'NJ','Hillsborough',1  union all
select 'DE','Middletown',6  union all
select 'DE','Newark',4  union all
select 'TX','Austin',9
    ;;

  }
  dimension: state {}
  dimension: city {}
  dimension: responses {type:number}
  measure: total_responses {
    type: sum
    sql: ${responses} ;;
  }
}


view: grand_total {
  derived_table: {
    explore_source: scott_percent_of_total_20200201 {
      column: total_total_responses {field:scott_percent_of_total_20200201.total_responses}
      bind_all_filters: yes
    }
  }
  dimension: total_total_responses {type:number}
  measure: percent_of_grand_total_responses {
    type: number
    sql: ${scott_percent_of_total_20200201.total_responses}*1.0/nullif(sum(${total_total_responses}),0) ;;
    value_format_name: percent_1
  }
}

explore: scott_percent_of_total_20200201 {
  join: grand_total {
    type: cross
    relationship: many_to_one
  }
}
