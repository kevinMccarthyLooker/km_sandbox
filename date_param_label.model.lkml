connection: "thelook_events_redshift"

include: "basic_users.*"

view: date_param_label {
  extends: [basic_users]

  parameter: date_filter {
    default_value: "2018-01-01"
    type: date
  }

  dimension: holder {
    hidden: yes
    sql:
    {% assign t = date_param_label.date_filter._parameter_value %}
    {% if t == '' %}
    {%else %}
      {% assign t = '2018-12-01' %}
    {% endif %}
    {% if testing_count_closed_one_day_ago._is_selected %}{{ t | date: '%s' | minus: 86400 | date: '%Y-%m-%d'}}{%else%}Testing Count Closed One Day Ago{%endif%} ;;
  }

  measure: testing_count_closed_one_day_ago{
#     label: "{% assign date = date_param_label.date_filter._parameter_value | date: '%s' %}
# {% assign seconds_in_a_day = 60 | times: 60 | times: 24 %}
# {% assign final_date = date: '%s' | plus: seconds | date: '%Y-%m-%d' %}
# {{ date_filter._parameter_value }} , {{final_date}}"
# label: "{% if testing_count_closed_one_day_ago._is_selected %}{% assign selected_date = date_param_label.date_filter._parameter_value %}{{ selected_date | date: '%s' | minus: 86400 | date: '%Y-%m-%d'}}{%else%}Testing Count Closed One Day Ago{%endif%}"

    label: "{% if testing_count_closed_one_day_ago._is_selected %}{{ date_filter._parameter_value | date: '%s' | minus: 86400 | date: '%Y-%m-%d'}}{%else%}Testing Count Closed One Day Ago{%endif%}"
# label: "{{holder._sql}}"
#
#   {% assign t = selected_date | strip | replace: 'TIMESTAMP ','' %}
#   {% assign t_length = t | size | minus: 2 %}
#   {% assign t2 = t | slice:1, t_length %}
#   t:{{t2}}
# {% assign t = selected_date | replace: 'TIMESTAMP ','' | date: '%Y-%m-%d'%}
# {% assign as_a_date2 = selected_date | replace: 'TIMESTAMP ','DATE ' | date: '%Y-%m-%d 00:00:00'%}
# {% assign as_a_date = selected_date | replace: 'TIMESTAMP ','' | date: '%Y-%m-%d'%}
# {% assign as_a_date = selected_date | replace: 'TIMESTAMP ',''%}
# {% assign as_a_date__date = as_a_date | slice:1, as_a_date_length %}
# as_a_date__date:{{ as_a_date__date}}
#     as_a_date__date:{{ as_a_date__date | date: '%Y-%m-%d'}}
# now:{{ 'now' | date: '%Y-%m-%d'}}
# "

# {{ 'now' | date: '%s' | minus: seconds_in_a_day | date: '%Y-%m-%d' }}
# {% assign a_date = as_a_date__date | date: '%Y-%m-%d' |%}
# {{a_date}}
# "
# {% assign as_a_date__date__seconds = as_a_date__date | date: '%Y-%m-%d' %}
# "
# as_a_date__date:{{as_a_date__date}}
# {% assign as_a_date__date__seconds = as_a_date__date | date: '%Y-%m-%d' %}
# "
# as_a_date__date__seconds:{{as_a_date__date__seconds}}
#  | date: '%Y-%m-%d'
# {% assign seconds_in_a_day = 60 | times: 60 | times: 24 %}
# {% assign final = as_a_date | date: '%s' | plus: seconds_in_a_day | date: '%Y-%m-%d' %}t:{{final}}"
    type: sum
#     drill_fields: [case_detail*]
    sql:
     CASE
      WHEN DATEADD(days,-1,CAST({% parameter date_filter %} as date)) = CAST(${created_date} AS DATE)
     THEN 1 else 0
     END ;;
  }
}

explore: date_param_label {}
