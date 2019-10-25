connection: "thelook_events_redshift"

include: "basic_users.view"

view: month_number_as_nulls {

  extends: [basic_users]

  dimension: quarter {
    convert_tz: no
    type: date_quarter
  }

  dimension: month_number {
    type: date_month_num
    convert_tz: no
    sql: ${created_raw} ;;
  }
  dimension: month_number_of_quarter {
    type: number
    sql: ${month_number}-(floor((${month_number}-1)/3) * 3) ;;
  }

  measure: month1_total {
    type: number
    sql: sum(case when ${month_number_of_quarter}=1 then 1 else null end) ;;
  }
  measure: month2_total {
  type: number
    sql: sum(case when ${month_number_of_quarter}=2 then 1 else null end) ;;
  }
  measure: month3_total {
  type: number
    sql: sum(case when ${month_number_of_quarter}=3 then 1 else null end) ;;
  }
  measure: q_total_nullify_if_monthly_total_is_null {
    type: number
    sql:
    ${month1_total}+
    ${month2_total}+
    ${month3_total};;
  }
}
explore: month_number_as_nulls {}
