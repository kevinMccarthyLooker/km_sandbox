view: functions {
derived_table: {sql:select 1;;}
#   dimension: functionA_parameterA {
# #     type: number
#     sql: 1 ;;
#   }
#   dimension: functionA_parameterB {
# #     type: number
#     sql: 2 ;;
#   }
#
#   dimension: functionA_result {
# #     type: number
#     sql:  {{ functionA_parameterA._sql }} + {{ functionA_parameterB._sql }};;
#   }
#
  dimension: function_add {
#     type: number
    sql:  Replace_Parameter_1 + Replace_Parameter_2;;
  }

  dimension: safe_divide {
#     type: number
    sql:  Replace_Parameter_1*1.0/nullif(Replace_Parameter_2,0);;
  }

parameter: t {
  default_value: "t"
}

  dimension: function_add2 {
#     type: number
#     {% assign p1 = 1 %}
#     {% assign p2 = 2 %}

#     {% if p1 %}{% else %}{% assign p1 = 10 %}{% endif %}

#     {% assign p1 = p1 | append:'' %}

#     {% assign p1 = '' | split:',' %}
#     {% assign p1[1] = 1 %}

#     {% assign randomNumber = "now" | date: "%s" | plus: 0 %}
#     {{randomNumber}}
#     {% if randomNumber > 1538611289 %}
#
#       t
#       {% assign p1 = 1 %}
#       {% assign p2 = 1 %}
#     {% else %}
#     f
#     {% endif %}

#     sql:
#     {% if functions.t._parameter_value == "''" %}
#       val{{functions.t._parameter_value}}
#       {% assign p1 = 1 %}
#       {% assign p2 = 1 %}
#     {% else %}
#     {% endif %}
#     {{ p1 }}
#     + {{p2}}
#     ;;

#       {% if t == 'functions' %}{% assign p2 = 1 %}{% endif %}
#     {% if t == 'functions' %}{% assign p1 = 1 %}{% endif %}


#     sql:
#     {% assign t = _view._name %}
#     -{{t}}-
#
#     {% if t == 'functions2' %}{% assign p1 = 1 %}{% endif %}
#
#     {{ p1 }}
#     ;;

#       sql:
#       {% assign minute = "now" | date: "%M" | plus: 0 %}
#       :{{minute}}:
#       {% if minute <24 %}
#        {% assign p1 = 1 %}
#        {% assign p2 = 1 %}
#       {% endif %}
#       {{ p1 }}
#      + {{p2}}
#       ;;

# sql:
# {{function_add2._is_selected}}
# {% assign t = function_add2._is_selected %}
# {% if t == false %}
# 1
# {% else %}
# 2
# {% endif %}
#        {% assign p1 = 1 %}
#        {% assign p2 = 1 %}
# {{ p1 }} + {{ p2 }}
# ;;


    sql:
    {% if _query._query_timezone == 'America/Los_Angeles' %}
       {% assign p1 = 0 %}
       {% assign p2 = 0 %}
    {% endif %}
    {{ p1 }} + {{p2}}
    ;;
  }
  dimension: safe_divide2 {
#     type: number
    sql:
    {% if _query._query_timezone == 'America/Los_Angeles' %}
       {% assign p1 = 0 %}
       {% assign p2 = 0 %}
    {% endif %}
    {{p1}}*1.0/nullif({{p2}},0);;
  }

  measure: TEMPLATE_summary {
#     sql:
#     'Values Range: '||
#     case
#       when coalesce(count(TEMPLATE_SQL_PLACEHOLDER),0)=0 then 'All NULLs'
#       when count(distinct TEMPLATE_SQL_PLACEHOLDER)=1 then min(TEMPLATE_SQL_PLACEHOLDER) ||'(only value)'
#       when count(distinct TEMPLATE_SQL_PLACEHOLDER)=2 then min(TEMPLATE_SQL_PLACEHOLDER) || ' and ' || max(TEMPLATE_SQL_PLACEHOLDER)
#       else min(TEMPLATE_SQL_PLACEHOLDER) ||' - '|| max(TEMPLATE_SQL_PLACEHOLDER)
#     end ||
#     '| Count Distinct:' || count(distinct TEMPLATE_SQL_PLACEHOLDER) || '| Count Null:'||count(*)-count(TEMPLATE_SQL_PLACEHOLDER) ;;
    sql:
    {% if _query._query_timezone == 'America/Los_Angeles' %}
       {% assign p1 = 0 %}
       {% assign p2 = 0 %}
    {% endif %}
    'Values Range: '||
    case
    when coalesce(count({{p1}}),0)=0 then 'All NULLs'
    when count(distinct {{p1}})=1 then min({{p1}}) ||'(only value)'
    when count(distinct {{p1}})=2 then min({{p1}}) || ' and ' || max({{p1}})
    else min({{p1}}) ||' - '|| max({{p1}})
    end ||
    '| Count Distinct:' || count(distinct {{p1}}) || '| Count Null:'||count(*)-count({{p1}}) ;;
  }

}


view: function_use {
  dimension: combined_sales{
    type: number
    sql: {{ functions2.function_add._sql | replace:'Replace_Parameter_1','4' | replace:'Replace_Parameter_2','5'}} ;;
  }

  dimension: first_part {
    sql: 5;;
  }
  dimension: second_part {
    sql: 2 ;;
  }
  dimension: t2 {
    type: number
    sql:
    {% assign p1 = first_part._sql %}
    {% assign p2 = second_part._sql %}
    ${functions2.function_add2} ;;
  }

  dimension: t3 {
    type: number
    sql:
    {% assign p1 = first_part._sql %}
    {% assign p2 = second_part._sql %}
    ${functions2.safe_divide2} ;;
  }
  measure: first_part_summary {
    type: string
    sql:
    {% assign p1 = first_part._sql %}
    ${functions2.TEMPLATE_summary}
    ;;
  }
}

view: field_for_extending {
  dimension: field {
    label: "test"
    sql:
    {% if _query._query_timezone == 'America/Los_Angeles' %}
       {% assign p1 = 0 %}
       {% assign p2 = 0 %}
    {% endif %}
    {{_view._name}} ;;
    link: {
      label: "test link"
      url: "https://google.com"
    }
  }
}
