connection: "thelook_events_redshift"

include: "basic_users.*"

view: faceted_special {
  derived_table: {
    # sql: select distinct country, case when country='USA' then 'USD' else 'EURO' end as currency from public.users ;;
    sql:
SELECT 'USA' as country,'USD' as currency union all
SELECT 'UK' as country,'EURO' as currency union all
SELECT 'ALL' as country,'USD' as currency
    ;;

    # persist_for: "10000 hours"
    # distribution_style: all
  }
  dimension: country {}
  dimension: filter_to_update {
    sql:
case when
  (select count(distinct country) from ${faceted_special.SQL_TABLE_NAME} where {%condition country%}country{%endcondition%})=1
    then (select currency from ${faceted_special.SQL_TABLE_NAME} where {%condition country%}country{%endcondition%} group by 1 limit 1)
else 'USD'
end
  ;;
  }

  dimension: country2 {
    sql: '{%condition country%}country{%endcondition%}',''','') ;;
  }

  dimension: filter_to_update2 {
    sql:
case when replace('{%condition country%}country{%endcondition%}' like '%,%' then 'USD' else currency end
      ;;
  }
}

explore: faceted_special {}
