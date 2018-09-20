view: trank {
derived_table: {sql:
  select 1 as value union all
  select 2 as value union all
  select 4 as value;;
  }
dimension: value {}
measure: test_rank {
  sql: row_number() over({% if value._in_query == true %}partition by ${value}{% endif %}) ;;
}
measure: row_total_calc {
  sql: sum(${value}) over(rows between 1 preceding and current row) ;;
}
}
