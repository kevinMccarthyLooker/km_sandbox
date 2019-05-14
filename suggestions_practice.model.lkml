connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project


view: suggestions_source {
  derived_table: {
    sql:
    select 2 as number union all
    select 1 as number
    ;;
  }
  dimension: number {}
}

view: main {
  derived_table: {
    sql:
    select 'a' as letter union all
    select 'b' as letter
    ;;
  }
  dimension: letter {
    suggest_explore: suggestions_source
    suggest_dimension: suggestions_source.number
  }
}

explore: suggestions_source {}



explore: main {}
