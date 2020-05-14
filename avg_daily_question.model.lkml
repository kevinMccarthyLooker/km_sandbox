connection: "thelook_events_redshift"

include: "/basic_users.view"

view: number_days {
derived_table: {
  sql:
  select datediff(days, max(case when {%condition date_filter%}created_at{%endcondition%} then created_at end),min(case when {%condition date_filter%} created_at{%endcondition%} then created_at end)) as days_in_range
  from public.users
  ;;
}
  filter: date_filter {
    type: date
  }

  measure: days_in_range {
    type: max
    # sql: datediff(days, max(case when {%condition date_filter%}${basic_users.created_raw}{%endcondition%} then ${basic_users.created_raw} end),min(case when {%condition date_filter%} ${created_raw}{%endcondition%} then ${created_raw} end));;
  }

  measure: daily_average {
    type: number
    sql: ${basic_users.count}*1.0/nullif(${days_in_range},0) ;;
  }
  # measure: last_day_in_range {
  #   type: date
  #   sql: max(case when {%condition date_filter%} ${created_date::date}{%endcondition%} then ${created_date:date} end);;
  # }
  # measure: min_day_in_range {
  #   type: date
  #   sql: min(case when {%condition date_filter%} ${created_raw::date}{%endcondition%} then ${created_raw::date} end);;
  # }
  # measure: days_in_range {
  #   type:
  # }
}
explore: avg_daily_question {
  view_name: basic_users
  join: number_days {
    relationship: one_to_one
    type: cross
    # type: full_outer
    # sql_on: 1=1 ;;
  }
}
