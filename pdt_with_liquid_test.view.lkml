view: pdt_with_liquid_test {
  derived_table: {
    sql:  select 1 as placeholder  {{_connection._schema}}.test ;;

  }
  dimension: placeholder {}
}
