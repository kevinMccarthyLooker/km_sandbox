connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project


view: to_be_extended__provides_count_measure_and_maybe_other_goodies {
  dimension: primary_key {
    primary_key: yes
    hidden: yes
  }
  measure: count {
    type: number
    sql: count(${primary_key}) ;;
  }
}


view: example_real_view__users {
  sql_table_name: public.users ;;
  extends: [to_be_extended__provides_count_measure_and_maybe_other_goodies]
  dimension: id {}
  dimension: primary_key {sql:${id};;}
  #measure: count {} #need not define this as it is coming in via extension
}

explore: example_real_view__users {}
