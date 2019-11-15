connection: "thelook_events_redshift"
# thelook_events_redshift
# biquery_publicdata_standard_sql
include: "basic_users.*"

view: dialect_check {
  extends: [basic_users]
  sql_table_name:
  {% if _dialect._name == 'bigquery_standard_sql' %}
    thelook_web_analytics.users
  {% else %}
    public.users
  {% endif %}
   ;;
  dimension: dialect {
    sql:
    {% if _dialect._name == 'redshift'              %}yes: redshift{% endif %}
    {% if _dialect._name == 'postgres'              %}yes: postgres{% endif %}
    {% if _dialect._name == 'bigquery_standard_sql' %}yes: bigquery_standard_sql{% endif %}
    {% if _dialect._name == 'snowflake'             %}yes: snowflake{% endif %}
    {% if _dialect._name == 'mssql_2008'            %}yes: mssql_2008{% endif %}
    {% if _dialect._name == 'mysql'                 %}yes: mysql{% endif %}
    {% if _dialect._name == 'postgres'              %}yes: postgres{% endif %}
    {{_dialect._name}}
    ;;
  }

  dimension: now {
    type: date_raw
    sql:
  {% if _dialect._name == 'bigquery_standard_sql' %}CURRENT_DATETIME()
  {% elsif _dialect._name == 'redshift'           %}getdate()
  {% endif %}
    ;;
#     -- select CURRENT_DATETIME() --bigquery
# select getdate() --redshift
  }
  dimension: show_now {
    type: string
    sql: ${now} ;;
  }
}

explore: dialect_check {}
