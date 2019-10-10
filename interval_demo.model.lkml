connection: "thelook_events_redshift"

include: "order_items.*"

view: interval_demo {
  # extends: [order_items]
  derived_table: {
    sql:
    select 1 as id, '2018-01-25 00:00:00'::timestamp as created, '2019-01-26 00:00:00'::timestamp as shipped
    union all
    select 2 as id, '2018-01-25 00:00:00'::timestamp as created, '2019-01-26 00:00:01'::timestamp as shipped
    ;;
  }
  dimension: created {
    type: date_raw
  }
  dimension: shipped {
    type: date_raw
  }

  dimension_group: created_to_shipped_interval  {
    type: duration
    intervals: [day,hour,minute,month,quarter,second,week,year]
    sql_start: ${created} ;;
    sql_end: ${shipped} ;;
  }
  dimension: date_diff_direct  {

  type: number
    sql: datediff(Y,${created},${shipped}) ;;
    value_format_name: decimal_4
  }

  measure: duration_tot {
    label: "Duration (Tot Min)"
    type: sum
    sql: datediff(seconds,${created},${shipped});;
  }
}
explore: interval_demo {}
