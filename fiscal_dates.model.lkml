connection: "thelook_events_redshift"

include: "/basic_users.view"

#for testing the explore
explore: fiscal_dates {from: basic_users}

#applying the block
view: +basic_users {
  extends: [financial_calendar_extension]
}

#block definition below
#base field variable set in manifest...# constant: my_base_field_for_financial_calendar {value: "${created_raw}"}
#Note: uses expression for date_add
#assumes all dialects can use same case when syntax
#doesn't label Fiscal quarter like 'FQ 1' as yet, just uses numbers
view: financial_calendar_extension {
  extension: required
  dimension_group: base_date {
    hidden: yes
    type: time
    timeframes: [raw,date,year]
    sql: @{my_base_field_for_financial_calendar} ;;
  }

  dimension: jan_1_day {
    hidden: yes
    type: date
    sql: ${base_date_year::date} ;;
  }

  dimension: jan_1_day_of_week_index {
    hidden: yes
    type: date_day_of_week_index
    sql: ${base_date_year::date} ;;
  }

  dimension: week1_day1 {
    hidden: yes
    type: date
    expression:if(${jan_1_day_of_week_index}=0,${jan_1_day},add_days((7-${jan_1_day_of_week_index}),${jan_1_day}));;
  }

  dimension: days_since_week1_day1 {
    hidden: yes
    type: duration_day
    sql_start: ${week1_day1::date} ;;
    sql_end:${base_date_date::date}  ;;
  }

  dimension: financial_year {
    type: number
    sql: ${base_date_year} - case when ${days_since_week1_day1}<0 then 1 else 0 end;;
  }

  dimension: financial_quarter {
    type: number
    sql:
    case
      when ${days_since_week1_day1}<0 or ${days_since_week1_day1}>=3*7*(5+4+4) then 4
      else ${days_since_week1_day1}/(7*(5+4+4))+1
    end ;;
  }

  dimension: financial_month {
    type: number
    sql:
    case
     when ${days_since_week1_day1}<0 then 12
     when ${days_since_week1_day1}<5*7 then 1
     when ${days_since_week1_day1}<(5+4)*7 then 2
     when ${days_since_week1_day1}<(5+4+4)*7 then 3
     when ${days_since_week1_day1}<(5+4+4+5)*7 then 4
     when ${days_since_week1_day1}<(5+4+4+5+4)*7 then 5
     when ${days_since_week1_day1}<(5+4+4+5+4+4)*7 then 6
     when ${days_since_week1_day1}<(5+4+4+5+4+4+5)*7 then 7
     when ${days_since_week1_day1}<(5+4+4+5+4+4+5+4)*7 then 8
     when ${days_since_week1_day1}<(5+4+4+5+4+4+5+4+4)*7 then 9
     when ${days_since_week1_day1}<(5+4+4+5+4+4+5+4+4+5)*7 then 10
     when ${days_since_week1_day1}<(5+4+4+5+4+4+5+4+4+5+4)*7 then 11
     else 12
    end
      ;;
  }

###for validation support
  measure: count_distinct_days {
    type: count_distinct
    sql: ${base_date_date} ;;
  }
  measure: range_days {
    type: string
    sql: min(${base_date_date}) || '-' || max(${base_date_date}) ;;
  }
}
