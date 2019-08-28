connection: "thelook_events_redshift"

include: "basic_users.*"

view: users__value_formats {
  extends: [basic_users]

  dimension: age {
    sql: ${TABLE}.age +0.5 ;;
  }

  dimension: age2 {
    type: number
    # value_format_name: "{%if 1 == 1 %}usd{% endif %}"
    # value_format_name: usd
    # value_format: "{%if 1 == 1 %}#.#####{% endif %}"
    sql: ${age} ;;
    # html: @{format_as_integer};;
    html: @{format_as_round_to_10s} ;;
  }
  dimension: age3 {
    type: number
#     label: "{%if 1 == 1 %}usd{% endif %}"
    # value_format_name: "{%if 1 == 1 %}usd{% endif %}"
    # value_format_name: usd
    # value_format: "{%if 1 == 1 %}#.#####{% endif %}"
    sql: ${age} ;;
    html:
    {% if '1'=='2' %}@{format_as_integer}
    {% else %}@{format_as_round_to_10s}
    {% endif %};;
  }
}

explore: users__value_formats {
}
