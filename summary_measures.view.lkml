include: "users.view"
#based on ideas from https://fabio-looker.github.io/look-at-me-sideways/rules.html
view: summary_measures {
  #special view has no source table, and is joined with a pseudo join (sql:;;)
  measure: gender_summary {sql:{{ variables_and_templates.TEMPLATE_summary._sql | replace: 'TEMPLATE_SQL_PLACEHOLDER', users.gender._sql }};;}
  measure: age_summary    {sql:{{ variables_and_templates.TEMPLATE_summary._sql | replace: 'TEMPLATE_SQL_PLACEHOLDER', users.age._sql }};;}
  measure: city_summary   {sql:{{ variables_and_templates.TEMPLATE_summary._sql | replace: 'TEMPLATE_SQL_PLACEHOLDER', users.city._sql }};;}
  measure: full_name_summary   {sql:{{ variables_and_templates.TEMPLATE_summary._sql | replace: 'TEMPLATE_SQL_PLACEHOLDER', users.full_name._sql }};;}


#   measure: avg_age {
#     type: number
#     sql: {{ functions.safe_divide._sql | replace: 'Replace_Parameter_1',total_age._sql | replace: 'Replace_Parameter_2',count._sql }} ;;
#   }

}
















#older versions
# measure: age_summary_orig {
#   type: string
#   sql: '{{ _field._name }} - Value Range: '||min(${age})||' - '||max(${age})||'| Count Distinct:' || count(distinct ${age}) || '| Null Count:'||count(*)-${count} ;;
# }
#
#   measure: age_summary2 {
#     type: string
#     sql:
#     {% assign base_SQL = city._sql %}
#     {% assign base_name = city._name | remove: _view._name | remove: '.' %}
#     'Value Summary for [{{ base_name }}]: '||min({{base_SQL}})||' - '||max({{base_SQL}})||'| Count Distinct:' || count(distinct {{base_SQL}}) || '| Null Count:'||count(*)-count({{base_SQL}}) ;;
#   }
# #
# #  template moved to variables_and_templates
# #   measure: TEMPLATE_summary {
# #     hidden: yes
# #     type: string
# #     sql:
# #     {% assign base_SQL = created_raw._sql %}
# #     'Values Range: '||
# #     case
# #       when coalesce(count(TEMPLATE_SQL_PLACEHOLDER),0)=0 then 'All NULLs'
# #       when count(distinct TEMPLATE_SQL_PLACEHOLDER)=1 then min(TEMPLATE_SQL_PLACEHOLDER) ||'(only value)'
# #       when count(distinct TEMPLATE_SQL_PLACEHOLDER)=2 then min(TEMPLATE_SQL_PLACEHOLDER) || ' and ' || max(TEMPLATE_SQL_PLACEHOLDER)
# #       else min(TEMPLATE_SQL_PLACEHOLDER) ||' - '|| max(TEMPLATE_SQL_PLACEHOLDER)
# #     end ||
# #     '| Count Distinct:' || count(distinct TEMPLATE_SQL_PLACEHOLDER) || '| Count Null:'||count(*)-count(TEMPLATE_SQL_PLACEHOLDER) ;;
# #   }
#
#   measure: created_summary {
#     type: string
#     sql:
#     {% assign base_SQL = created_raw._sql %}
#     'Values Range: '||
#     case
#       when coalesce(count({{base_SQL}}),0)=0 then 'All NULLs'
#       when count(distinct {{base_SQL}})=1 then min({{base_SQL}}) ||'(only value)'
#       when count(distinct {{base_SQL}})=2 then min({{base_SQL}}) || ' and ' || max({{base_SQL}})
#       else min({{base_SQL}}) ||' - '|| max({{base_SQL}})
#     end ||
#     '| Count Distinct:' || count(distinct {{base_SQL}}) || '| Count Null:'||count(*)-count({{base_SQL}}) ;;
#   }
# #   measure: gender_summary {
# #     type: string
# #     sql:
# #     {% assign base_SQL = gender._sql %}
# #     'Values Range: '||
# #     case
# #       when coalesce(count({{base_SQL}}),0)=0 then 'All NULLs'
# #       when count(distinct {{base_SQL}})=1 then min({{base_SQL}}) ||'(only value)'
# #       when count(distinct {{base_SQL}})=2 then min({{base_SQL}}) || ' and ' || max({{base_SQL}})
# #       else min({{base_SQL}}) ||' - '|| max({{base_SQL}})
# #     end ||
# #     '| Count Distinct:' || count(distinct {{base_SQL}}) || '| Count Null:'||count(*)-count({{base_SQL}}) ;;
# #   }
