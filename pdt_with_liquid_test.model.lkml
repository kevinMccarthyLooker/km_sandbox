connection: "thelook_events_redshift"

# include: "*.view.lkml"                # include all views in the views/ folder in this project
view: pdt_with_liquid_test {
  derived_table: {
    sql:  select '{{_connection._schema}}' as placeholder /*{{_connection._schema}}.test*/ ;;
    sql_trigger_value: select getdate();;
    distribution_style: all
  }

  dimension: placeholder {}
}
explore: pdt_with_liquid_test {}
