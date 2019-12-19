connection: "thelook_events_redshift"

include: "basic_users.*"

view: ruth_mcelroy_question_12192019_base {
  extends: [basic_users]
  parameter: parameter_example {
    allowed_value: {value:"a"}
    allowed_value: {value:"b"}
  }
  dimension: use_parameter_example {
    sql: {% if parameter_example._parameter_value == "'a'" %}'a was selected'{% else %}'b was selected'{% endif %} ;;
  }
}

explore: ruth_mcelroy_question_12192019_base {}

view: ndt_example_counts_by_age_lookup {
  derived_table: {
    explore_source: ruth_mcelroy_question_12192019_base {
      column: ndt_column_dimension_example__age {field:ruth_mcelroy_question_12192019_base.age}
      column: ndt_column_measure_example__count {field:ruth_mcelroy_question_12192019_base.count}
      column: test {field:ruth_mcelroy_question_12192019_base.use_parameter_example}
      bind_filters: {
        from_field:ndt_example_counts_by_age_lookup.parameter_example_in_the_ndt
        to_field:ruth_mcelroy_question_12192019_base.parameter_example
        }
    }
  }
  dimension: ndt_column_dimension_example__age {type:number}
  dimension: ndt_column_measure_example__count {type:number}
  dimension: test {}

  parameter: parameter_example_in_the_ndt {
    allowed_value: {value:"a"}
    allowed_value: {value:"b"}
  }
}

explore: ndt_example_counts_by_age_lookup {}
