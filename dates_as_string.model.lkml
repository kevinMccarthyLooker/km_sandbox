connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project

view: example {
derived_table:{
sql:
with example as
(
select '2015-01-01 01'::text as date_example
)
select cast(date_example||':00:00' as timestamp) as timestampified from example;;
}
dimension_group: timestampified {
  type: time
  timeframes: [raw,hour,date]
  sql: ${TABLE}.timestampified ;;
}
filter: t {
  type: date_time
  sql: /* ;;
}
}
explore: example {
  # sql_always_where:

  # {% assign t2 = _filters['example.t'] %}
  # {% assign t2_through_hour = t2 | slice: 11, 15 %}
  # {{t2_through_hour}}
  # ;;
  sql_always_where: {%condition example.t%}''*/{%endcondition%} ;;
}
