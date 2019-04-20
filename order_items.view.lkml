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
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: primary_key {
    type: number
    primary_key: yes
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

#   dimension: user_tenure_months {
#     label: "User Tenure Months"
#     type: number
#     sql: datediff(month, ${users.created_raw},${created_raw}) ;;
#
#
#   }
#
#   dimension: user_tenure_months_duration {
#     type: duration_month
#     sql_start: ${users.created_raw} ;;
#     sql_end: ${created_raw}  ;;
#   }


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
    label: "order_label_localized"
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

  measure: average_sale_price_lookml {
    type: average
    sql: ${sale_price} ;;
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
    type: number
    sql: sum(case when ${primary_key} is not null then 1 else null end) ;;
    drill_fields: [detail*]
#     filters:{
#       field: primary_key
#       value: "NOT NULL"
#     }
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
    drill_fields: [revenue]
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

  #link building... for better drilling
  measure: dummy_link_holder {
    type: sum
    sql: 0 ;;
    drill_fields: [link_testing2]
  }

  measure: link_text {
    type: number
    sql: count(*) ;;
#     html: {{created_month._linked_value}} | {{created_month._link}} ;;
    html: {{dummy_link_holder._linked_value}} | {{dummy_link_holder._link}} ;;
  }

#   measure: link_text_modified {
#     type: number
#     sql: count(*) ;;
# #     html:
# #     {% assign orig_link = dummy_link_holder._link %}
# #     {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
# #     {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}
# #
# #     {% assign field_list = 'fields=' %}
# #     {% assign sort_list = '&sorts=' %}
# #     {% if created_month_name._is_selected %}
# #         {% assign field_list = field_list | append: created_date_day_of_year._name | append: ',' %}
# #         {% assign sort_list = sort_list | append: created_date_day_of_year._name | append: ',' %}
# #     {% endif %}
# #     {% assign field_list = field_list | append: created_date_day_of_year._name | append: ',' | append: created_year._name | append: ',' %}
# #
# #     {% assign pivot_url_portion = '&pivots=order_items.created_year' %}
# #
# #     {% comment %}remove year filter {% endcomment %}
# #
# #
# #     {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
# #     {% assign part1 = final_link | split: 'f[order_items.created_year]=' | first %}
# #     {% assign part2 = final_link | split: 'f[order_items.created_year]=' | last %}
# #
# #     {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
# #     {% assign final_link2 = part1 | append: "f[" | append: parts_after_created_year_filter_value %}
# #     <a href="{{final_link2}}">{{value}}<a>
# #
# #     ;;
#
#
#
# #     link: {
# #       url: "
# #     {% assign orig_link = dummy_link_holder._link %}
# #     {% assign field_to_drill_into = created_date_week_of_year._name %}
# #     {% assign period_to_compare__field_to_pivot_on = created_year._name %}
# #
# # {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
# # {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
# # {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}
# #
# # {% assign field_list = 'fields=' %}
# # {% assign sort_list = '&sorts=' %}
# #   {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
# #   {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
# #   {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
# #     {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}
# #
# #     {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #
# #     {% comment %}remove year filter {% endcomment %}
# #
# #
# #     {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
# #     {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
# #     {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
# #     {% assign part2 = final_link | split: split_string__pivot_field_filter_start | last %}
# #
# #     {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
# #     {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
# #     {% assign final_link2 = part1 | append: 'f[' | append: parts_after_created_year_filter_value | append: vis_config %}
# #
# #     {{final_link2}}
# #       "
# # label:
# # "
# #     {% assign field_to_drill_into = created_date_week_of_year._name %}
# #     {% assign period_to_compare__field_to_pivot_on = created_year._name %}
# #     compare {{period_to_compare__field_to_pivot_on}}s, by {{field_to_drill_into}}
# #     "
# #     }
# #
# #     link: {
# #       url: "
# #       {% assign orig_link = dummy_link_holder._link %}
# #       {% assign field_to_drill_into = created_date_day_of_year._name %}
# #       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
# #
# #       {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
# #       {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
# #       {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}
# #
# #       {% assign field_list = 'fields=' %}
# #       {% assign sort_list = '&sorts=' %}
# #       {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
# #       {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}
# #
# #       {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #
# #       {% comment %}remove year filter {% endcomment %}
# #
# #
# #       {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
# #       {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
# #       {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
# #       {% assign part2 = final_link | split: split_string__pivot_field_filter_start | last %}
# #
# #       {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
# #       {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
# #       {% assign final_link2 = part1 | append: 'f[' | append: parts_after_created_year_filter_value | append: vis_config %}
# #
# #       {{final_link2}}
# #       "
# #       label:
# #       "
# #       {% assign field_to_drill_into = created_date_day_of_year._name %}
# #       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
# #       compare {{period_to_compare__field_to_pivot_on}}s, by {{field_to_drill_into}}
# #       "
# #     }
# #
# #     link: {#by quarter of year
# #       url: "
# #       {% assign orig_link = dummy_link_holder._link %}
# #       {% assign field_to_drill_into = created_date_day_of_year._name %}
# #       {% assign period_to_compare__field_to_pivot_on = created_date_quarter_of_year._name %}
# #
# #       {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
# #       {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
# #       {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}
# #
# #       {% assign field_list = 'fields=' %}
# #       {% assign sort_list = '&sorts=' %}
# #       {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
# #       {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}
# #
# #       {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #
# #       {% comment %}remove year filter {% endcomment %}
# #       {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
# #       {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
# #       {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
# #       {% assign part2 = final_link | split: split_string__pivot_field_filter_start | last %}
# #
# #       {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
# #       {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
# #       {% assign final_link2 = part1 | append: 'f[' | append: parts_after_created_year_filter_value | append: vis_config %}
# #
# #       {{final_link2}}
# #       "
# #       label:#create a label that says what is being filtered on.
# #       "
# #       {% assign orig_link = dummy_link_holder._link %}
# #       {% assign field_to_drill_into = created_date_day_of_year._name %}
# #       {% assign period_to_compare__field_to_pivot_on = created_date_quarter_of_year._name %}
# #
# #       {% assign left_portion__to_filters = orig_link | split: '&f[' | first %}
# #       {% assign right_portion__from_filters = orig_link | split: left_portion__to_filters | last %}
# #       {% assign filters = right_portion__from_filters | split: '&sorts=' | first | split: '&query_timezone' | first | split: '&limit' | first %}
# #
# #       {% assign formatted_filters = filters | replace: '&f[','-' | replace: ']','' %}
# #       compare {{period_to_compare__field_to_pivot_on}}s, by {{field_to_drill_into}}, filter on {{formatted_filters}}
# #       "
# #     }
#
#     link: {label:"All YOY fields below filtered by:
#       {% assign orig_link = dummy_link_holder._link %}
#       {% assign field_to_drill_into = created_date_day_of_year._name %}
#       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
#
#       {% assign left_from_filters = orig_link | split: 'f[' | first %}
#         {% assign right_from_filters = orig_link | remove_first: left_from_filters %}
#         {% assign filters = right_from_filters | split: '&sorts' | first | split: '&query_timezone' | first  | split: '&limit' | first %}
#         {% assign filters_to_drill_field = filters | split: period_to_compare__field_to_pivot_on | first %}
#         {% assign filters_from_drill_field = filters | remove_first: filters_to_drill_field %}
#         {% assign drill_filter_only = filters_from_drill_field | split: 'f[' | first %}
#           {% assign after_drill_filter = filters_from_drill_field | remove_first: drill_filter_only %}
#           {% assign filters_without_drill_field = filters_to_drill_field | append: after_drill_filter | replace: 'f[',' ' | replace: ']',''%}
#             {{filters_without_drill_field}}"
#             url:"none"
#       }
#
#     link: {
# #       label:"YOY by month number"
#       label:
#         "
#       {% assign orig_link = dummy_link_holder._link %}
#       {% assign field_to_drill_into = created_month_num2._name %}
#       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
#
#       {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
#       {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
#       {% assign right_portion__from_fields = orig_link | remove_first: left_portion__to_fields %}
#
#       {% assign fields_only = right_portion__from_fields | split: '&query_timezone' | first %}
#       {% assign right_from_fields = right_portion__from_fields | remove_first: fields_only %}
#       {% assign field_list = 'fields=' %}
#       {% assign sort_list = '&sorts=' %}
#       {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
#       {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
#       {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
#       {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}
#
#       {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
#
#       {% comment %}remove year filter {% endcomment %}
#       {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_from_fields | append: sort_list | append: pivot_url_portion %}
#       {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
#       {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
#       {% assign part2 = final_link | remove: part1 %}
#
#       {% assign pivot_field_part_only = part2 | remove_first: 'f[' | split: 'f[' | first %}
#
#       {% assign after_pivot_field_part_only = part2 | remove_first: 'f[' | remove: pivot_field_part_only %}
#
#       {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
#       {% assign final_link2 = part1 | append: after_pivot_field_part_only | append: vis_config %}
#
#       {{final_link2}}
#
#
#
#             "
#       url: "none"
# #       url: "
# #       {% assign orig_link = dummy_link_holder._link %}
# #       {% assign field_to_drill_into = created_month_num2._name %}
# #       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
# #
# #       {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
# #       {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
# #       {% assign right_portion__from_fields = orig_link | remove_first: left_portion__to_fields %}
# #
# #       {% assign right_from_fields = right_portion__from_fields | remove_first: fields_only %}
# #
# #       {% assign field_list = 'fields=' %}
# #       {% assign sort_list = '&sorts=' %}
# #       {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
# #       {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}
# #
# #       {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #
# #       {% comment %}remove year filter {% endcomment %}
# #       {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_from_fields | append: sort_list | append: pivot_url_portion %}
# #       {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
# #       {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
# #       {% assign part2 = final_link | remove: part1 %}
# #
# #       {% assign pivot_field_part_only = part2 | remove_first: 'f[' | split: 'f[' | first %}
# #
# #       {% assign after_pivot_field_part_only = part2 | remove_first: 'f[' | remove: pivot_field_part_only %}
# #
# #       {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
# #       {% assign final_link2 = part1 | append: after_pivot_field_part_only | append: vis_config %}
# #
# #       {{final_link2}}
# #       "
#     }
# #     link: {label:"YOY by week of year number"
# #       url: "
# #       {% assign orig_link = dummy_link_holder._link %}
# #       {% assign field_to_drill_into = created_date_week_of_year._name %}
# #       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
# #
# #       {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
# #       {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
# #       {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}
# #
# #       {% assign field_list = 'fields=' %}
# #       {% assign sort_list = '&sorts=' %}
# #       {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
# #       {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}
# #
# #       {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #
# #       {% comment %}remove year filter {% endcomment %}
# #       {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
# #       {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
# #       {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
# #       {% assign part2 = final_link | split: split_string__pivot_field_filter_start | last %}
# #
# #       {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
# #       {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
# #       {% assign final_link2 = part1 | append: 'f[' | append: parts_after_created_year_filter_value | append: vis_config %}
# #
# #       {{final_link2}}
# #       "
# #     }
# #     link: {label:"YOY by day of year number"
# #       url: "
# #       {% assign orig_link = dummy_link_holder._link %}
# #       {% assign field_to_drill_into = created_date_day_of_year._name %}
# #       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
# #
# #       {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
# #       {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
# #       {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}
# #
# #       {% assign field_list = 'fields=' %}
# #       {% assign sort_list = '&sorts=' %}
# #       {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
# #       {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
# #       {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}
# #
# #       {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #
# #       {% comment %}remove year filter {% endcomment %}
# #       {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
# #       {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
# #       {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
# #       {% assign part2 = final_link | split: split_string__pivot_field_filter_start | last %}
# #
# #       {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
# #       {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
# #       {% assign final_link2 = part1 | append: 'f[' | append: parts_after_created_year_filter_value | append: vis_config %}
# #
# #       {{final_link2}}
# #       "
# #     }
#
#   }
#
#   measure: link_testing {
#     type: count
#   #for testing
# #     type: string
# #     sql: max('') ;;
# #     html:
# #     {% assign field_to_drill_into = created_date_day_of_year._name %}
# #     {% assign period_to_compare__field_to_pivot_on = created_year._name %}
# #     {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
# #     {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #
# #     {% assign orig_link = dummy_link_holder._link %}
# #     orig:{{orig_link}}
# #     <br>
# #     {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
# #     url_to_question_mark:{{url_to_question_mark}}
# #     <br>
# #     {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
# #     url_from_question_mark:{{url_from_question_mark}}
# #
# #     <br>
# #     {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
# #     fields_begin:{{to_fields_begin}}
# #     <br>
# #     {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
# #     from_fields_begin:{{from_fields_begin}}
# #     <br>
# #     {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
# #     {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}
# #     fields:{{fields_final}}
# #
# #     <br>
# #     {% assign to_filters_begin = orig_link | split: '&' | first %}
# #     to_filters_begin:{{to_filters_begin}}
# #     <br>
# #     {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
# #     from_filters_begin:{{from_filters_begin}}
# #     <br>
# #     {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
# #     filters_begin_to_filters_end:{{filters_begin_to_filters_end}}
# #     <br>
# #
# #     {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
# #     {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
# #     filters_after_compare_field_start:{{filters_after_compare_field_start}}
# #     {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
# #     filters_after_compare_field_to_next_filter:{{filters_after_compare_field_to_next_filter}}
# #     {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}
# #     filters_after_compare_field_end:{{filters_after_compare_field_end}}
# #     {% assign filters_without_compare_field = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' %}
# #     filters_again:{{filters_without_compare_field}}
# #     final:{{to_fields_begin | append:fields_final | append: filters_without_compare_field | | append: pivot_list | append: sort_list  }}
# #     ;;
#
#     link: {label: "YOY by day number of year
#       {% assign field_to_drill_into = created_date_day_of_year._name %}
#       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
#
#       {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
#       {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
#       {% assign orig_link = dummy_link_holder._link %}
#       {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
#       {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
#       {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
#       {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
#       {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
#       {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}
#       {% assign to_filters_begin = orig_link | split: '&' | first %}
#       {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
#       {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
#       {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
#       {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
#       {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
#         {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}
#
#         {% assign filters_without_compare_field_label = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f[' | replace: 'f[','--'% | replace: '&','' | replace:']','' %}
#                 (filter on {{filters_without_compare_field_label}})
#                 "
# url: "{% assign field_to_drill_into = created_date_day_of_year._name %}
# {% assign period_to_compare__field_to_pivot_on = created_year._name %}
#
#                 {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
#                 {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
#                 {% assign orig_link = dummy_link_holder._link %}
#                 {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
#                 {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
#                 {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
#                 {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
#                 {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
#                 {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}
#                 {% assign to_filters_begin = orig_link | split: '&' | first %}
#                 {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
#                 {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
#                 {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
#                 {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
#                 {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
#                   {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}
#                   {% assign filters_without_compare_field = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f['%}
#                           {{to_fields_begin | append:fields_final | append: '&' | append: filters_without_compare_field | append: pivot_list | append: sort_list  }}"
#                         }
#     link: {label: "YOY by week number of year
#       {% assign field_to_drill_into = created_date_week_of_year._name %}
#       {% assign period_to_compare__field_to_pivot_on = created_year._name %}
#
#       {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
#       {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
#       {% assign orig_link = dummy_link_holder._link %}
#       {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
#       {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
#       {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
#       {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
#       {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
#       {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}
#       {% assign to_filters_begin = orig_link | split: '&' | first %}
#       {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
#       {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
#       {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
#       {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
#       {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
#         {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}
#
#         {% assign filters_without_compare_field_label = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f[' | replace: 'f[','--'% | replace: '&','' | replace:']','' %}
#                 (filter on {{filters_without_compare_field_label}})
#                 "
# url: "{% assign field_to_drill_into = created_date_week_of_year._name %}
# {% assign period_to_compare__field_to_pivot_on = created_year._name %}
#
#                 {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
#                 {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
#                 {% assign orig_link = dummy_link_holder._link %}
#                 {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
#                 {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
#                 {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
#                 {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
#                 {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
#                 {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}
#                 {% assign to_filters_begin = orig_link | split: '&' | first %}
#                 {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
#                 {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
#                 {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
#                 {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
#                 {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
#                   {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}
#                   {% assign filters_without_compare_field = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f['%}
#                           {{to_fields_begin | append:fields_final | append: '&' | append: filters_without_compare_field | append: pivot_list | append: sort_list  }}"
#                         }
# # {% assign field_to_drill_into = created_date_week_of_year._name %}
#     link: {
# label: "t"
# #       label: "
# # {% if created_date_quarter_of_year._is_selected %}
# # QOQ by week number of year
# #
# #       {% assign period_to_compare__field_to_pivot_on = 'order_items.created_quarter' %}
# #       {% assign field_to_drill_into = 'order_items.created_date_week_of_year' %}
# #
# #       {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
# #       {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #       {% assign orig_link = dummy_link_holder._link %}
# #       {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
# #       {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
# #       {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
# #       {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
# #       {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
# #       {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}
# #       {% assign to_filters_begin = orig_link | split: '&' | first %}
# #       {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
# #       {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
# #       {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
# #       {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
# #       {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
# #       {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}
# #
# #       {% assign filters_without_compare_field_label = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f[' | replace: 'f[','--'% | replace: '&','' | replace:']','' %}
# #       (filter on {{filters_without_compare_field_label}})
# # {% else %}
# # {% endif %}
# #       "
#
#       url: "
# {% if created_date_quarter_of_year._is_selected %}
#       {% assign period_to_compare__field_to_pivot_on = 'order_items.created_quarter' %}
#       {% assign field_to_drill_into = 'order_items.created_date_week_of_year' %}
#
#       {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
#       {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
#       {% assign orig_link = dummy_link_holder._link %}
#
#       {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
#       {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
#       {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
#       {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
#       {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
#       {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}
#       {% assign to_filters_begin = orig_link | split: '&' | first %}
#       {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
#       {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
#       {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
#
#   {% assign filters_without_compare_field = filters_begin_to_filters_end %} {%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway{%endcomment%}
#    {% if filters_after_compare_field_start | size > 0 %}
#       {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
#       {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
#       {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}
#       {% assign filters_without_compare_field = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f['%}
#     {% else %}
#     {% endif %}
#
#       {{to_fields_begin | append:fields_final | append: '&' | append: filters_without_compare_field | append: pivot_list | append: sort_list  }}
# {% else %}
# {% endif %}
#       "
#
# #       url: "
# #       {% if created_date_quarter_of_year._is_selected %}
# #       {% assign period_to_compare__field_to_pivot_on = 'order_items.created_quarter' %}
# #       {% assign field_to_drill_into = 'order_items.created_date_week_of_year' %}
# #
# #       {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
# #       {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
# #       {% assign orig_link = dummy_link_holder._link %}
# #       {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
# #       {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
# #       {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
# #       {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
# #       {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
# #       {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}
# #       {% assign to_filters_begin = orig_link | split: '&' | first %}
# #       {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
# #       {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
# #       {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
# #       {% if filters_after_compare_field_start | size > 0 %}
# #         {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
# #         {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
# #         {{filters_after_compare_field_start}},{{filters_after_compare_field_to_next_filter}}
# #       {% else %}
# #       {% endif %}
# #
# #       {% else %}
# #       {% endif %}
# #                 "
#
#     }
#
# #         {% assign updated_filters_list = updated_filters_list | replace: 'amp;','&' | compact %}
# #     updated_filters_list:{{updated_filters_list}}
#   }

  measure: link_testing2 {
    type: count
#     html:
link: {label:"--YOY Drills--"
#       {{filters_without_drill_field | url_decode }}
      url:"none"
    }
#     label:"
#
#     {% if created_date_day_of_year._is_selected or created_date_week_of_year._is_selected or created_month_name._is_selected  %}
#     {% else %}
#     YOY by Quarter Of Year
#     {% endif %}"
link: {label:"
  {% assign label = 'label not set' %}
  {% if created_date_hour_of_day._is_selected %}{% assign label = 'na-lowest grain selected' %}
  {% elsif created_date_day_of_year._is_selected %}{% assign label = 'created_date_hour_of_day' %}
  {% elsif created_date_week_of_year._is_selected %}{% assign label = 'drill on created_date_day_of_year' %}
  {% elsif created_month_name._is_selected %}{% assign label = 'drill on created_date_week_of_year' %}
  {% elsif created_date_quarter_of_year._is_selected %}{% assign label = 'drill on created_month_name' %}
  {% else %}{% assign label = 'else case reached' %}{% assign label = label | append: 'drill on created_date_quarter_of_year' %}
  {% endif %}
  {{label}}
  "
#   {% assign field_to_drill_into = created_date_quarter_of_year._name %}
url:"
  {% assign field_to_drill_into = created_date_day_of_year._name %}
  {% if created_date_hour_of_day._is_selected %}{% assign field_to_drill_into = created_date_hour_of_day._name %}
  {% elsif created_date_day_of_year._is_selected %}{% assign field_to_drill_into = created_date_hour_of_day._name %}
  {% elsif created_date_week_of_year._is_selected %}{% assign field_to_drill_into = created_date_day_of_year._name %}
  {% elsif created_month_name._is_selected %}{% assign field_to_drill_into = created_date_week_of_year._name %}
  {% elsif created_date_quarter_of_year._is_selected %}{% assign field_to_drill_into = created_month_name._name %}
  {% else %}{% assign label = 'else case reached' %}{% assign field_to_drill_into = created_date_quarter_of_year._name %}
  {% endif %}



      {% assign period_to_compare__field_to_pivot_on = created_year._name %}


      {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
      {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
      {% assign orig_link = dummy_link_holder._link %}
      {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
      {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
      {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
      {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
      {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
      {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}

      {% assign to_filters_begin = orig_link | split: '&f' | first %}
      {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
      {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
      {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
      {% if filters_to_compare_field_start | size > 2 %}
        {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}{%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway{%endcomment%}
      {% else %}
        {% assign filters_after_compare_field_start = filters_begin_to_filters_end %}
      {% endif %}

      {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
      {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}

      {% assign filters_without_compare_field = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f[' | replace: '~~~','' %}


      {{to_fields_begin | append:fields_final | append: '&' | append: filters_without_compare_field | append: pivot_list | append: sort_list  }}
{%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway
      {% assign filters_without_compare_field = filters_begin_to_filters_end %}
      {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
{%endcomment%}"
}
#    ;;
    link: {label:"YOY by Month Of Year"
      url:" {% assign period_to_compare__field_to_pivot_on = created_year._name %}
      {% assign field_to_drill_into = created_month_name._name %}

      {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
      {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
      {% assign orig_link = dummy_link_holder._link %}
      {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
      {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
      {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
      {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
      {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
      {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}

      {% assign to_filters_begin = orig_link | split: '&f' | first %}
      {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
      {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
      {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
      {% if filters_to_compare_field_start | size > 2 %}
        {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}{%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway{%endcomment%}
      {% else %}
        {% assign filters_after_compare_field_start = filters_begin_to_filters_end %}
      {% endif %}

      {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
      {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}

      {% assign filters_without_compare_field = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f[' | replace: '~~~','' %}


      {{to_fields_begin | append:fields_final | append: '&' | append: filters_without_compare_field | append: pivot_list | append: sort_list  }}
{%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway
      {% assign filters_without_compare_field = filters_begin_to_filters_end %}
      {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
{%endcomment%}"
    }
    link: {label:"YOY by Week Of Year"
      url:" {% assign period_to_compare__field_to_pivot_on = created_year._name %}
      {% assign field_to_drill_into = created_date_week_of_year._name %}

      {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
      {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
      {% assign orig_link = dummy_link_holder._link %}
      {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
      {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
      {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
      {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
      {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
      {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}

      {% assign to_filters_begin = orig_link | split: '&f' | first %}
      {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
      {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
      {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
      {% if filters_to_compare_field_start | size > 2 %}
        {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}{%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway{%endcomment%}
      {% else %}
        {% assign filters_after_compare_field_start = filters_begin_to_filters_end %}
      {% endif %}

      {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
      {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}

      {% assign filters_without_compare_field = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f[' | replace: '~~~','' %}


      {{to_fields_begin | append:fields_final | append: '&' | append: filters_without_compare_field | append: pivot_list | append: sort_list  }}
{%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway
      {% assign filters_without_compare_field = filters_begin_to_filters_end %}
      {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
{%endcomment%}"
    }
    link: {label:"YOY by Day Of Year"
      url:" {% assign period_to_compare__field_to_pivot_on = created_year._name %}
      {% assign field_to_drill_into = created_date_day_of_year._name %}

      {% assign sort_list = '&sorts=' | append: field_to_drill_into %}
      {% assign pivot_list = '&pivots=' | append: period_to_compare__field_to_pivot_on %}
      {% assign orig_link = dummy_link_holder._link %}
      {% assign url_to_question_mark = orig_link | split: '?' | first | append: '?' %}
      {% assign url_from_question_mark = orig_link | remove_first: url_to_question_mark %}
      {% assign to_fields_begin = orig_link | split: 'fields=' | first | append: 'fields=' %}
      {% assign from_fields_begin = orig_link | remove_first: to_fields_begin %}
      {% assign fields_begin_to_fields_end = from_fields_begin | split: '&' | first %}
      {% assign fields_final = fields_begin_to_fields_end | append: ',' | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on %}

      {% assign to_filters_begin = orig_link | split: '&f' | first %}
      {% assign from_filters_begin = orig_link | remove_first: to_filters_begin | remove_first: '&' %}
      {% assign filters_begin_to_filters_end = from_filters_begin | split: 'query_timezone' | first %}
      {% assign filters_to_compare_field_start = filters_begin_to_filters_end | split: period_to_compare__field_to_pivot_on | first %}
      {% if filters_to_compare_field_start | size > 2 %}
      {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}{%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway{%endcomment%}
      {% else %}
      {% assign filters_after_compare_field_start = filters_begin_to_filters_end %}
      {% endif %}

      {% assign filters_after_compare_field_to_next_filter = filters_after_compare_field_start | split: 'f[' | first %}
      {% assign filters_after_compare_field_end = filters_after_compare_field_start | remove_first: filters_after_compare_field_to_next_filter %}

      {% assign filters_without_compare_field = filters_to_compare_field_start | append: filters_after_compare_field_end |replace: 'amp;f[','&' | replace: '&&','&' | replace: 'f[f[','f[' | replace: '~~~','' %}


      {{to_fields_begin | append:fields_final | append: '&' | append: filters_without_compare_field | append: pivot_list | append: sort_list  }}
      {%comment%}avoids an error on string parsing when the field wouldn't be present in filter anyway
      {% assign filters_without_compare_field = filters_begin_to_filters_end %}
      {% assign filters_after_compare_field_start = filters_begin_to_filters_end | remove_first: filters_to_compare_field_start %}
      {%endcomment%}"
    }
  }

  dimension: created_date_quarter_of_year {
    type: date_quarter_of_year
    sql: ${created_raw} ;;
  }
  dimension: created_date_week_of_year {
    type: date_week_of_year
    sql: ${created_raw} ;;
  }
  dimension: created_date_day_of_year {
    type: date_day_of_year
    sql:  ${created_raw};;
  }
  dimension: created_month_2 {
    type: date_month
    sql: ${created_raw} ;;
    html: {{link_text_modified._linked_value}} ;;
  }
  dimension: created_month_num2 {
    type: date_month_num
    sql: ${created_raw} ;;
  }
  dimension: created_month_name {
    type: date_month_name
    sql: ${created_raw} ;;
    order_by_field: created_month_num2
#     html: {{link_text_modified._linked_value}} ;;
  }
  dimension: created_date_hour_of_day {
    type: date_hour_of_day
    sql: ${created_raw} ;;
  }

  dimension: created_date_day_of_week {
    type: date_day_of_week
    sql: ${created_raw} ;;
  }

  measure: m3 {
    type: count
    html:
    {% assign t= created_month_name._name | split : 'x' | first %}
    {% assign t2 = t |remove:t %}
    {% assign t3 = t2 | remove_first:'a'%}
    t{{t}}
    t2{{t2}}

    ;;
  }

#testing caching and alerting
  dimension: static_dimension  {
    type: string
    sql: 'static value' ;;
  }
  dimension: rand_dimension  {
    type: string
    sql: random() ;;
  }

  measure: static_measure  {
    type: number
    sql: max(1) ;;
  }

  measure: random_measure  {
    type: number
    sql: max(random()) ;;
  }




#   {% assign field_list = orig_link | slice: 2,5 %}
# fields=

###2019-02-06 testing format switch for measure selector
parameter: measure_selector2 {
  allowed_value: {
    value:"count2"
    label:"count2"
  }
  allowed_value: {
    value:"total_sales2"
    label:"total_sales2"
  }
}
measure: count2 {
  type: count
  value_format_name: id
}
measure: total_sales2 {
  type: sum
  sql: ${sale_price};;
  value_format_name: usd
}
measure: selected {
  type: number
  sql: {%if measure_selector2._parameter_value == "'count2'" %}${count2}{% else %}${total_sales2}{% endif %} ;;
  html: {%if measure_selector2._parameter_value == "'count2'" %}{{ count2._rendered_value }}{% else %}{{ total_sales2._rendered_value }}{% endif %} ;;
}


# dimension: emoji_testing {
#   group_label: "🤣"
#   label: "😀🦑<br>⚂♟{{order_items.emoji_testing._sql}}"
#   description: "🐠<br />⚂♟"
#   type: string
#   sql: 't
#   😄
#   t2' ;;
#   html: emoji:{{rendered_value}} ;;
#
# }
#   dimension: emoji_testing2 {
#     group_label: "🤣"
#     label: "😀🦑<br>⚂♟{{order_items.emoji_testing._sql}}"
#     description: "🐠<br />⚂♟2"
#     type: string
#     sql: 't
#         😄
#         t2' ;;
#     html: emoji:{{rendered_value}} ;;

#   }

  dimension_group: some_date2  {

    type: time
    timeframes: [raw,date,month]
    sql: ${TABLE}.created_at ;;
  }

  filter: yesno_filter {
    type: yesno
    sql: {% condition yesno_filter %} true {% endcondition %} ;;
  }

}
