view: order_items {
  sql_table_name: public.order_items ;;

  dimension: test_table_name_reference {
    sql: 'order_items' ;;
  }

  dimension: test_field_name_reference {
    sql: 'id' ;;
  }


  dimension: test_link {
    sql: 'link' ;;
#links to explore showing all possible values for the field sorted by count descending
    link: {
      label: "linky"
      url: "https://profservices.dev.looker.com/explore/t__thelook_events_redshift__public__order_items/table?fields=distinctstatus&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%7D&filter_config=%7B%7D&dynamic_fields=%5B%7B%22measure%22%3A%22distinctstatus%22%2C%22based_on%22%3A%22order_items.status%22%2C%22type%22%3A%22count_distinct%22%2C%22label%22%3A%22DistinctStatus%22%2C%22expression%22%3Anull%2C%22value_format%22%3Anull%2C%22value_format_name%22%3Anull%2C%22_kind_hint%22%3A%22measure%22%2C%22_type_hint%22%3A%22number%22%7D%5D&origin=share-expanded"
    }
    link: {
      label: "linky encoded"
      url: "
      {% assign baseUrl='/explore/t__thelook_events_redshift__public__' %}
      {% assign table=test_table_name_reference._value %}
      {% assign base_column = table | append: '.' | append: test_field_name_reference._value %}
      {% assign placeholder2 ='/table?fields=' %}
      {% assign field_name = 'distinct__' | append: base_column %}
      {% assign field_name2 = 'max__' | append: base_column %}
      {% assign placeholder3 ='&dynamic_fields=' %}
      {% assign dynamic_fields = ''
      | append: '[{'


      | append: '\"type\":\"max\",'
      | append: '\"label\":\"'    | append: field_name2  | append:  '\",'
      | append: '\"measure\":\"'  | append: field_name2  | append:  '\",'
      | append: '\"based_on\":\"' | append: base_column | append: '\"'

      | append: '},{'


      | append: '\"type\":\"count_distinct\",'
      | append: '\"label\":\"'    | append: field_name  | append:  '\",'
      | append: '\"measure\":\"'  | append: field_name  | append:  '\",'
      | append: '\"based_on\":\"' | append: base_column | append: '\"'



      | append: '}]'
      | url_encode
      %}

      {% assign query_timezone = '&query_timezone=America%2FLos_Angeles' %}
      {% assign viz = '&vis=%7B%7D' %}
      {% assign filter_config='&filter_config=%7B%7D' %}
      {% assign limit = '&limit=500' %}
      {% assign remainder = '&origin=share-expanded' %}

      {{ baseUrl | append: table | append: placeholder2 | append: field_name
          | append: ','
          | append: field_name2
          | append: placeholder3 | append: dynamic_fields }}
      "
    }
#works giving link to explore showing count distinct
#     link: {
#       label: "linky encoded"
#       url: "
#       {% assign baseUrl='https://profservices.dev.looker.com/explore/t__thelook_events_redshift__public__' %}
#       {% assign table=test_table_name_reference._value %}
#       {% assign base_column = table | append: '.' | append: test_field_name_reference._value %}
#       {% assign placeholder2 ='/table?fields=' %}
#       {% assign field_name = 'distinct__' | append: base_column %}
#       {% assign placeholder3 ='&dynamic_fields=' %}
#       {% assign dynamic_fields = ''
#         | append: '[{'
#         | append: '\"type\":\"count_distinct\",'
#         | append: '\"label\":\"'    | append: field_name  | append:  '\",'
#         | append: '\"measure\":\"'  | append: field_name  | append:  '\",'
#         | append: '\"based_on\":\"' | append: base_column | append: '\"'
#         | append: '}]'
#         | url_encode
#       %}
#
#       {% assign query_timezone = '&query_timezone=America%2FLos_Angeles' %}
#       {% assign viz = '&vis=%7B%7D' %}
#       {% assign filter_config='&filter_config=%7B%7D' %}
#       {% assign limit = '&limit=500' %}
#       {% assign remainder = '&origin=share-expanded' %}
#
#       {{ baseUrl | append: table | append: placeholder2 | append: field_name | append: placeholder3 | append: dynamic_fields }}
#       "
#     }

  }

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
    label: "Order"
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
    #idea is to dynamicall color these based on percent of total.  Relating to a question Mark was asking
#     html:{% if count_percent_of_total._value > 1 %}{{ value }}{% else %}no-{{ count_percent_of_total._value }}{% endif %} ;;
  }

  measure: count_percent_of_total {
    type: percent_of_total
    direction: "column"
    sql: ${count} ;;
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
