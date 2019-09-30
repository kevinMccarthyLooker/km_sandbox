connection: "thelook_events_redshift"

include: "basic_users*"

# dimension: zone {
#   suggest_explore: zone_to_country_lookup_for_suggestions
#   suggest_dimension: zone_to_country_lookup_for_suggestions.zone
# }
# dimension: zone_filled_else_case_workaround {
#   sql: {{zone._sql | prepend: "'+" | append: "+'"}};;
# }
# #using case to support dimension fill, for now
# dimension: zone_filled {
#   case: {
#     when: {sql: ${TABLE}.zone = 'SAZ' ;; label: "SAZ"}
#     when: {sql: ${TABLE}.zone = 'MAZ' ;; label: "MAZ"}
#     when: {sql: ${TABLE}.zone = 'NAZ' ;; label: "NAZ"}
#     when: {sql: ${TABLE}.zone = 'EUR' ;; label: "EUR"}
#     when: {sql: ${TABLE}.zone = 'AFRICA' ;; label: "AFRICA"}
#     when: {sql: ${TABLE}.zone = 'APAC' ;; label: "APAC"}
#     when: {sql: ${TABLE}.zone = 'midam' ;; label: "MIDAM"}
#     else: "{{zone_filled_else_case_workaround._sql}}"
#   }
# }

#doesn't work with other filters...
view: fill_and_handle_others {
  extends: [basic_users]
  dimension: traffic_source_base  {sql: ${TABLE}.traffic_source ;;}
  dimension: traffic_source_fill_else_case_workaround {sql: {{traffic_source_base._sql | prepend: "'+" | append: "+'"}};;}
  # dimension: t {sql:{%if 1 == 0 %}{{traffic_source_fill_else_case_workaround._sql}}{%endif%};;}
  dimension: traffic_source {
    case: {
      # when: {sql: ${traffic_source_base} = 'Display' ;; label: "Display"}
      when: {sql: ${traffic_source_base} = 'Email' ;; label: "Email"}
      when: {sql: ${traffic_source_base} = 'Organic' ;; label: "Organic"}
      else: "{{traffic_source_fill_else_case_workaround._sql}}"
    }
  }
}

explore: fill_and_handle_others {}
