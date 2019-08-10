connection: "andy_db"

view: survey_percent_responses_example {
  sql_table_name: public.survey_results ;;
  dimension: id {primary_key:yes}
  dimension: respondent_name {}
  dimension: question {}
  dimension: answer {}
  measure: response_count {type:count}
  measure: total_responses_to_question {
    type: number
    sql: sum(count(*)) over(partition by ${question},${answer}) ;;
  }
  measure: percent_of_responses_to_question {
    type: number
    sql: ${response_count}/${total_responses_to_question} ;;
    value_format_name: percent_0
  }
}

explore: survey_percent_responses_example {}
