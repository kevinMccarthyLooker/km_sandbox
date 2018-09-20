view: group {
  sql_table_name: {% if _dialect._name == 'hypersql' %} PUBLIC."GROUP" {% else %} `group` {% endif %}
    ;;

  measure: count {
    type: count
  }

  dimension: id {
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  measure: groups {
    view_label: "User"
    type: string
    sql: GROUP_CONCAT(DISTINCT ${name}) ;;
  }
}
