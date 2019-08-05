connection: "thelook_events_redshift"

include: "basic_users.view"

view: users_for_dashboard_suggestions_leveraging_liquid {
  extends: [basic_users]
  parameter: dynamic_measure_selector {
    type: unquoted
    allowed_value: {
      label: "Average Age"
      value: "1"
    }
    allowed_value: {
      label: "Average IDs"
      value: "2"
    }
    default_value: "1"
  }

  measure: dynamic_measure {
    type: average
    sql:
    {% if dynamic_measure_selector._parameter_value == '1' %}
    ${age}
    {% elsif dynamic_measure_selector._parameter_value == '2' %}
    ${id}
    {% else %}
    ${age}
    {% endif %}
    ;;
  }

  dimension: city_suggest {
    type: string
    sql:
    {% if dynamic_measure_selector._parameter_value == '1' %}
    CASE WHEN ${city} IN ('Abbeville', 'Abootsley', 'Aberaeron') THEN ${city} ELSE NULL END
    {% elsif dynamic_measure_selector._parameter_value == '2' %}
    CASE WHEN ${city} IN ('Boston', 'Babylon') THEN ${city} ELSE NULL END
    {% else %}
    CASE WHEN ${city} IN ('Abbeville', 'Abootsley', 'Aberaeron') THEN ${city} ELSE NULL END
    {% endif %} ;;
    suggest_persist_for: "0 minutes"
  }

}

# view: order_items_for_dashboard_suggestions_leveraging_liquid {
#   sql_table_name: public.order_items ;;
#   dimension: id {
#     primary_key: yes
#   }
#   dimension: user_id {}



# }


explore: users {
  from: users_for_dashboard_suggestions_leveraging_liquid
  # join: order_items {
  #   from: order_items_for_dashboard_suggestions_leveraging_liquid
  #   sql_on: ${order_items.user_id}=${basic_users.id} ;;
  #   relationship: one_to_many
  # }
}
