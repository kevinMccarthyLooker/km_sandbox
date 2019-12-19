connection: "thelook_events_redshift"

include: "basic_users.*"                   # include all views in this project
view: liquid_drops {
  extends: [basic_users]

  dimension: test_value_with_apostrophe_and_underscore {
    sql: 'hi_hi''hi' ;;
  }

  measure: full_reference_in_liquid {
    type: number
    sql: {% assign x = '${sum_age_to_be_used_hidden}' %}'{{ x | replace:"age","replaced"}}' ;;
  }

  measure: filter_link {
    type: count_distinct
#     hidden: yes
    drill_fields: []
    sql: ${TABLE}.id ;;
  }

  measure: sum_age_to_be_used_hidden {
    type: sum
    sql: ${age} ;;
  }
  measure: avg_age_to_be_used_hidden {
    type: average
    sql: ${age} ;;
  }

  measure: view_info {
    type: max
    sql: 1 ;;
    html:
    view:{{liquid_drops}}<br>
    view._name:{{liquid_drops._name}}<br>
    view[]:{{liquid_drops[]}}<br>
    view:{{liquid_drops  | join: ', '}}<br>
    view:{{_view}}<br>

    model name:{{_model['_name']}}<br>
    {% assign xs = '_,_title,_connection,_value,_all,_name,_test,_fields,_views' | split:','%}
    {% for x in xs %}
      {{x}}:{{_model[x]}}<br>
    {% endfor %}
    query_sql:{{_query[]}}<br>

    {% for x in xs %}
      {{x}}:{{_query[x]}}<br>
    {% endfor %}
    {% assign z = _model[] where:"title","Foo" %}
    {{z['_name'] | join: ',' | append :'t'}}
    {% for q in z %}
      q:{{q}}    <br>
    {% endfor %}
    uas:{{_user_attributes[]}}
    ;;
  }

  measure: single_column_formats_other_data {
    required_fields: [sum_age_to_be_used_hidden,avg_age_to_be_used_hidden]
    type: max
    sql: 1 ;;
    html:

    <table  align="center" width="100%">

    <tr style="text-align:right;">
      <tr>
      <th>Month</th>
      <th>Savings</th>
      </tr>
      <td style="text-align:right;width:100px">
        sum age:{{sum_age_to_be_used_hidden._rendered_value}}
      </td>
      <td style="text-align:right">
        avg age:{{avg_age_to_be_used_hidden._rendered_value}}
      </td>
    </tr>
    <tr style="text-align:left">
      <td style="text-align:left">
        sum age:{{sum_age_to_be_used_hidden._rendered_value}}
      </td>
      <td style="text-align:left">
        avg age:{{avg_age_to_be_used_hidden._rendered_value}}
      </td>
    </tr>
    </table>

    ;;
  }

  dimension: filters_drop {

    sql: 1;;
#     html:
#       {% assign url_split_at_f = filter_link._link | split: '&amp;f' %}
#       {% assign user_filters = '' %}
#       {% assign continue_loop = true %}
#
#       {% for url_part in url_split_at_f offset:1 %}
#         {% if continue_loop %}
#           {% if url_part contains '&amp;sorts' %}
#             {% assign part_split_at_sorts = url_part | split: '&amp;sorts' %}
#             {% assign last_filter = part_split_at_sorts | first %}
#             {% assign user_filters = user_filters | append:'&f' %}
#             {% assign user_filters = user_filters | append:last_filter %}
#             {% assign continue_loop = false %}
#           {% else %}
#             {% assign user_filters = user_filters | append:'&amp;f' %}
#             {% assign user_filters = user_filters | append:url_part %}
#           {% endif %}
#         {% endif %}
#       {% endfor %}
#
#       {% assign user_filters = user_filters | replace: 'f[orders.created_date]', 'Created Date' %}
#       {% assign user_filters = user_filters | replace: 'f[users.is_first_timer]', 'First Time Buyer' %}
#       {% assign user_filters = user_filters | replace: 'f[products.category]', 'Category' %}
# ;;

#     html: {% assign x = _filters[] %} ;;
    html:
    {% assign test = '1,2' |split:','%}
    {{_filters['liquid_drops.last_name']}}
    size:{{_filters['liquid_drops.last_name'] | size}}
    {%for filter in _filters[] %}
    x
    {%endfor%}
    ;;



#     html:{{_filters[]}};;
#     {{_query._query_timezone}}
# {{_query._filters}}
#
#         {% assign x = _filters[] %}
#
#     {% assign x1 = x %}
#         {%for xs in x %}
#         ss
#     {%endfor%}
#     {% assign x2 = _filters[] | last %}

#     }0{{_filters[]}}-0. 1{{_filters[]}}-1
  }

  dimension: row_values_raw {
    sql: 1 ;;
    html: {{row[]}} ;;
  }

  dimension: filter_values_raw {
    sql: 1 ;;
    html: {{_filters[] }} ;;#throws and error
  }

  dimension: row_values {
    sql: 1 ;;
    html:
<div style='font-size:6px'>
{% assign field_and_values_string = row[] | append:'' %}
{% assign field_and_values_size = field_and_values_string | size | minus:2 %}
{% assign field_and_values_trimmed = field_and_values_string | slice:1,field_and_values_size %}
{% assign field_and_values_array = field_and_values_trimmed | split: ',' %}
{% for field in field_and_values_array %}
  {% assign field_name = field | split: '"=>"'|first %}
  {{field_name}}<br>
{% endfor %}
</div>
    ;;
  }
  dimension: row_values2 {
    sql: 1 ;;
    html:
    <div style='font-size:10px'>
    {% assign field_array = row[] %}
    {% for field in field_array %}
      {%assign x = field | split:',' | first |append:''|replace:'[','' |replace:']','' | replace:'"',''] | strip %}
      {%assign y = field | split:',' | last |append:''|replace:'[','' |replace:']','' ] | strip %}
      {% assign z = x | append: '=' |append:y%}
      {{z}}<br>
    {% endfor %}
    </div>
        ;;#{{x}}-{{y}}-
  }
  dimension: link2 {
    sql: 1 ;;
    html:
    <div style='font-size:10px'>
    {% assign field_array = row[] %}
    {% assign url_filters_formatted ='' %}
    {% for field in field_array %}
      {% assign x = field | split:',' | first |append:''|replace:'[','' |replace:']','' | replace:'"',''] | strip %}

      {% assign y = field | split:',' | last |append:''|replace:'[','' |replace:']','' ] | strip %}
      {% assign z = x| append: '=' |append:y%}
      {% assign input = z%}
      {% assign output = ''%}
      @{field_to_filter_name_mapping}
      {% assign z = output %}
      {% assign url_filters_formatted = url_filters_formatted |append:'&' | append:z %}
    {% endfor %}
    <a href='https://profservices.dev.looker.com/dashboards/olFX8h1bkraeyHbHiVcU1L?{{url_filters_formatted}}'>link</a>
    </div>
        ;;#{{x}}-{{y}}-
#         {% assign x = output %}
        #
  }


  dimension: pass_all_filters {
    sql: 1 ;;
    html:
    <div style='font-size:6x'>
    {% assign field_and_values_string = row[] | append:'' %}
    {% assign field_and_values_size = field_and_values_string | size | minus:2 %}
    {% assign field_and_values_trimmed = field_and_values_string | slice:1,field_and_values_size %}
    {% assign field_and_values_array = field_and_values_trimmed | split: ',' %}
    {% assign url_filters_formatted ='' %}
    {% for field in field_and_values_array %}
      {% assign field_name = field | split: '=>'|first |append:'' %}
      {% assign field_name_size = field_name | size | minus:6 %}
      {% assign field_name = field_name | slice: 6,field_name_size %}
      {% assign field_value = field | split: '=>'|last |append:'' %}

      {% assign field_value = field | split: '=>'|last |append:'' %}
      {% assign field_value_size = field_value | size | minus:6 %}
      {% assign field_value = field_value | slice: 6,field_value_size %}

      {{field_name}}--{{field_value}}<br>
      {% assign url_filters_formatted = url_filters_formatted | append:field_name | append:'=' | append: field_value %}
    {% endfor %}
    <a href='https://profservices.dev.looker.com/dashboards/olFX8h1bkraeyHbHiVcU1L?{{url_filters_formatted}}'>link</a>
    </div>
        ;;
  }
}

explore: liquid_drops {}
