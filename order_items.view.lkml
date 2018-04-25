view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

#Original Date Field
  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

#Date Field dynamically grouped based on the filter range.
## This is the field you would actually display on the dashboard tile.  You may choose to hide it from the explore if you think it will not be intuitive for ad hoc use.
## Will only work if user or dashboard filters on specifically the created_date field.
  dimension: dynamic_date_group {
    description: "Created Date - Bucket used depends on the size of the timeframe that the end user filters on"
    type: string
    sql:
      case
        when datediff(days,{% date_start created_date %},{% date_end created_date %})>1825 then /*over 5 years, use yearly */ ${created_year}::varchar
        when datediff(days,{% date_start created_date %},{% date_end created_date %})>151 then /*over 5 months, use yearly */ ${created_month}::varchar
        when datediff(days,{% date_start created_date %},{% date_end created_date %})>35 then /*over 5 weeks, use weekly */ ${created_week}::varchar
        else ${created_date}::varchar
      end
    ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {group_label: "aaa__sale_price__or_something_else_unique"
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status2 {
    label: "Status Pivoted"
    type: string
    sql: ${TABLE}.status ;;
  }


  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: revenue {
    type: sum
    sql: ${sale_price} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
