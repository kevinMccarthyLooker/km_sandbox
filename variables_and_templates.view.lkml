view: variables_and_templates {
  measure: TEMPLATE_summary {
    hidden: yes
    type: string
    sql:
    'Values Range: '||
    case
      when coalesce(count(TEMPLATE_SQL_PLACEHOLDER),0)=0 then 'All NULLs'
      when count(distinct TEMPLATE_SQL_PLACEHOLDER)=1 then min(TEMPLATE_SQL_PLACEHOLDER) ||'(only value)'
      when count(distinct TEMPLATE_SQL_PLACEHOLDER)=2 then min(TEMPLATE_SQL_PLACEHOLDER) || ' and ' || max(TEMPLATE_SQL_PLACEHOLDER)
      else min(TEMPLATE_SQL_PLACEHOLDER) ||' - '|| max(TEMPLATE_SQL_PLACEHOLDER)
    end ||
    '| Count Distinct:' || count(distinct TEMPLATE_SQL_PLACEHOLDER) || '| Count Null:'||count(*)-count(TEMPLATE_SQL_PLACEHOLDER) ;;
  }
}
