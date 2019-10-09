connection: "thelook_events_redshift"

# include: "*.view.lkml"                       # include all views in this project
view: field_sort_testing {
  derived_table: {sql:select 1 as field_1, 2 as field_2, 3 as field_3;;}
  # dimension: field_1 {}
  # dimension: field_2 {}
  # dimension: field_3 {}
  dimension: a_field_1 {
    label: "Field 1"
    sql: ${TABLE}.field_1 ;;
  }
  dimension: field_2 {
    label: "Field 2"
    sql: ${TABLE}.field_2 ;;
  }
  dimension: a_field_3 {
    label: "Field 3"
    sql: ${TABLE}.field_3 ;;
  }

}
explore: field_sort_testing {}
