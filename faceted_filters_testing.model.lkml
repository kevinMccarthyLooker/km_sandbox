connection: "thelook_events_redshift"

include: "basic_users.*"

view:faceted_filters_testing1 {
  derived_table: {sql:select * from public.users where city like 'A%';;}
  extends: [basic_users]
}
explore: faceted_filters_testing1 {}

view:faceted_filters_testing2 {
  extends: [basic_users]

  dimension: city_with_special_suggestions {
    suggest_dimension: faceted_filters_testing1.city
    suggest_explore: faceted_filters_testing1
    sql: ${city} ;;
  }
}
explore: faceted_filters_testing2 {}
