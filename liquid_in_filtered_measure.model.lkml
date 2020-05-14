connection: "thelook_events_redshift"

include: "/**/basic_users.view"

view: liquid_in_filtered_measure {
  extends: [basic_users]

  parameter: program_group {
    type: string
    allowed_value: {
      label: "Sunday 900pm"
      value: "Sunday 900pm"
    }
    allowed_value: {
      label: "Sunday 1000pm"
      value: "Sunday 1000pm"
    }
    allowed_value: {
      label: "Others"
      value: "Others"
    }
  }
  # dimension: title_kanji {
  #   type: string
  #   sql: ${TABLE}.TitleKanji ;;
  # }
  dimension: city {}
  dimension: selected_program_stuff_yes_no {
    type: yesno

    sql:
        {% assign param_value = program_group._parameter_value |replace: "'",'' %}
    {{param_value }}
{% if param_value == 'Sunday 900pm' %}
      %titleA%,%titleB%
      {% elsif param_value == 'Sunday 1000pm'  %}
      %titleA%,%titleC%
      {% else %}
      -NULL
      {% endif %}
    ;;
  }
  measure: p_all {
    type: average
    sql: ${TABLE}.age ;;
    filters: {
      # field: title_kanji
      field: city
      value: "
      {% if program_group._parameter_value contains 'Sunday 900pm' %}
      %titleA%,%titleB%
      {% elsif program_group._parameter_value == 'Sunday 1000pm'  %}
      %titleA%,%titleC%
      {% else %}
      -NULL
      {% endif %}"

    # field:selected_program_stuff_yes_no
    #   value: "Yes"
    }
  }
}

explore: liquid_in_filtered_measure {}
