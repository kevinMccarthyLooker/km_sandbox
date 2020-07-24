connection: "thelook_events_redshift"

include: "/basic_users.view"

#for testing the explore
explore: fiscal_dates {from: basic_users}

### anything i wanted to add for testing here {
view: +basic_users {
  dimension_group: test_date_type_input {
    type: time
    timeframes: [raw,date]
    datatype: date
    sql: cast(${created_raw} as date) ;;
  }
}
### } end - anything i wanted to add for testing here

#applying the block
view: +basic_users {
  extends: [financial_calendar_extension]

#here what you configure the block on
  dimension_group: base_date {sql:${test_date_type_input_raw};;} # also considering having them fill constant: my_base_field_for_financial_calendar {value: "${created_raw}"} , but that would be difficult to apply multiple times in an instance
#And perhaps we should we give them access to configure the output fields like this
  dimension: financial_week_of_year {group_label:"Special Group Label"}
  dimension: financial_year {group_label:"Created Date"}
  dimension: financial_quarter {group_label:"Created Date"}
  dimension: financial_month {group_label:"Created Date"}
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
#     sql: @{my_base_field_for_financial_calendar} ;;
    sql: OVERRIDE_ME ;;
  }

### 01 Get the first monday of the corresponding year as the key to subsequent calculations {
  dimension: jan_1_day {
#     hidden: yes
    convert_tz: no #base field would've already been converted
    type: date
    sql: ${base_date_year::date} ;;
  }

  dimension: jan_1_day_of_week_index {
#     hidden: yes
    convert_tz: no #base field would've already been converted
    type: date_day_of_week_index
    sql: ${base_date_year::date} ;;
  }

  dimension: week1_day1 {
    hidden: yes
    convert_tz: no #base field would've already been converted
    type: date
    expression:if(${jan_1_day_of_week_index}=0,${jan_1_day},add_days((7-${jan_1_day_of_week_index}),${jan_1_day}));;
  }

  dimension: days_since_week1_day1 {
    hidden: yes
    convert_tz: no #base field would've already been converted
    type: duration_day
    sql_start: ${week1_day1::date} ;;
    sql_end:${base_date_date::date}  ;;
  }
### } end section 01

### 02 All this to figure out if the first few days of the year should be week 52 or 53 {
  dimension: jan_1_day_one_year_prior {
#     hidden: yes
    convert_tz: no #base field would've already been converted
    type: date_year
    expression: add_years(-1,${jan_1_day}) ;;
  }

  dimension: jan_1_day_of_week_index_one_year_prior {
    hidden: yes
    convert_tz: no #base field would've already been converted
    type: date_day_of_week_index
    sql: ${jan_1_day_one_year_prior::date} ;;
  }

  dimension: week1_day1_one_year_prior {
    hidden: yes
    convert_tz: no #base field would've already been converted
    type: date
    expression:if(${jan_1_day_of_week_index_one_year_prior}=0,${jan_1_day_one_year_prior},add_days((7-${jan_1_day_of_week_index_one_year_prior}),${jan_1_day_one_year_prior}));;
  }

  dimension: days_since_week1_day1_one_year_prior {
    type: duration_day
    convert_tz: no #base field would've already been converted
    sql_start:${week1_day1_one_year_prior::date}  ;;
    sql_end:${base_date_date::date}  ;;
  }
### } end section 02

### 03 Calculate and show the fiscal calendar features {
  dimension: financial_week_of_year {
    type: number
    sql:
    case
      when ${days_since_week1_day1}<0 then ${days_since_week1_day1_one_year_prior}/7+1
      else ${days_since_week1_day1}/7+1
    end;;
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
      else ${days_since_week1_day1}/(7*(4+4+5))+1
    end ;;
  }

  #can this be more efficient?
  dimension: financial_month {
    type: number
    sql:
    case
     when ${days_since_week1_day1} is null then null
     when ${days_since_week1_day1}<0 then 12
     when ${days_since_week1_day1}<4*7 then 1
     when ${days_since_week1_day1}<(4+4)*7 then 2
     when ${days_since_week1_day1}<(4+4+5)*7 then 3
     when ${days_since_week1_day1}<(4+4+5+4)*7 then 4
     when ${days_since_week1_day1}<(4+4+5+4+4)*7 then 5
     when ${days_since_week1_day1}<(4+4+5+4+4+5)*7 then 6
     when ${days_since_week1_day1}<(4+4+5+4+4+5+4)*7 then 7
     when ${days_since_week1_day1}<(4+4+5+4+4+5+4+4)*7 then 8
     when ${days_since_week1_day1}<(4+4+5+4+4+5+4+4+5)*7 then 9
     when ${days_since_week1_day1}<(4+4+5+4+4+5+4+4+5+4)*7 then 10
     when ${days_since_week1_day1}<(4+4+5+4+4+5+4+4+5+4+4)*7 then 11
     else 12
    end
      ;;
  }
###}end section 03

### 04 For validation support {
  measure: count_distinct_days {
    type: count_distinct
    sql: ${base_date_date} ;;
  }
  measure: range_days {
    type: string
    sql: min(${base_date_date}) || '-' || max(${base_date_date}) ;;
  }
  measure: min_date {
    convert_tz: no
    type: date
    sql: min(${base_date_date});;
  }
  measure: max_date {
    convert_tz: no
    type: date
    sql:max(${base_date_date}) ;;
  }
  measure: min_day_of_year {
    convert_tz: no
    type: date_day_of_year
    sql: min(${base_date_date});;
  }
  measure: max_day_of_year {
    convert_tz: no
    type: date_day_of_year
    sql:max(${base_date_date}) ;;
  }
### } end section 04
}
