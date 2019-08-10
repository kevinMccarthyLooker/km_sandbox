connection: "andy_db"

view: survey_percent_responses_example {
  sql_table_name: public.survey_results ;;
  dimension: id {primary_key:yes}
  dimension: respondent_name {}
  dimension: question {}
  dimension: answer {}
  dimension: gender {
    case: {
      when: {label:"female" sql:${respondent_name}='Miley Cyrus';;}
      when: {label:"female" sql:${respondent_name}='Kesha';;}
      when: {label:"female" sql:${respondent_name}='Mother Theresa';;}
      else: "male"
    }
  }
  measure: response_count {type:count}
  measure: total_responses_with_this_response_to_this_question {
    type: number
    sql: sum(count(*)) over(partition by ${question},${answer}) ;;
  }
  measure: this_group_as_a_percentage_of_all_that_have_this_response_to_this_question {
    type: number
    sql: ${response_count}/${total_responses_with_this_response_to_this_question} ;;
    value_format_name: percent_0
  }

########
# subtotal of respondents (across all answers)
  measure: total_responses_to_this_question_by_this_group__any_answer {
    type: number
    sql: sum(count(*)) over(partition by
    /*all fields except answer included here*/
    {%if id._is_selected %}${id},{%endif%}
    {%if respondent_name._is_selected %}${respondent_name},{%endif%}
    {%if question._is_selected %}${question},{%endif%}
    --${answer}
    {%if gender._is_selected %}${gender},{%endif%}
    1
    ) ;;
  }
  measure: percent_of_responses_by_this_group_that_have_this_answer{
    type: number
    sql: ${response_count}/${total_responses_to_this_question_by_this_group__any_answer} ;;
    value_format_name: percent_0
  }
}

explore: survey_percent_responses_example {}
#######################
## another attempt... using one_to_one self join

# explore: survey_percent_responses_example__self_join {
#   from: survey_percent_responses_example
#   join: survey_percent_responses_example_total{
#     from: survey_percent_responses_example
#     sql_table_name:
# select
# respondent_name,
# question
# /*,answer*/
# from public.survey_results
#     ;;
#     sql_on:
#     ${survey_percent_responses_example__self_join.respondent_name}=${survey_percent_responses_example_total.respondent_name} and
#     ${survey_percent_responses_example__self_join.question}=${survey_percent_responses_example_total.question}
#     ;;
#     relationship: one_to_one
#     type: left_outer
#   }
# }
