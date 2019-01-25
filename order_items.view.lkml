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
    drill_fields: [revenue]
  }

  measure: link_text {
    type: number
    sql: count(*) ;;
#     html: {{created_month._linked_value}} | {{created_month._link}} ;;
    html: {{dummy_link_holder._linked_value}} | {{dummy_link_holder._link}} ;;
  }

  measure: link_text_modified {
    type: number
    sql: count(*) ;;
#     html:
#     {% assign orig_link = dummy_link_holder._link %}
#     {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
#     {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}
#
#     {% assign field_list = 'fields=' %}
#     {% assign sort_list = '&sorts=' %}
#     {% if created_month_name._is_selected %}
#         {% assign field_list = field_list | append: created_date_day_of_year._name | append: ',' %}
#         {% assign sort_list = sort_list | append: created_date_day_of_year._name | append: ',' %}
#     {% endif %}
#     {% assign field_list = field_list | append: created_date_day_of_year._name | append: ',' | append: created_year._name | append: ',' %}
#
#     {% assign pivot_url_portion = '&pivots=order_items.created_year' %}
#
#     {% comment %}remove year filter {% endcomment %}
#
#
#     {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
#     {% assign part1 = final_link | split: 'f[order_items.created_year]=' | first %}
#     {% assign part2 = final_link | split: 'f[order_items.created_year]=' | last %}
#
#     {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
#     {% assign final_link2 = part1 | append: "f[" | append: parts_after_created_year_filter_value %}
#     <a href="{{final_link2}}">{{value}}<a>
#
#     ;;



    link: {
      url: "
    {% assign orig_link = dummy_link_holder._link %}
    {% assign field_to_drill_into = created_date_week_of_year._name %}
    {% assign period_to_compare__field_to_pivot_on = created_year._name %}

{% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
{% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
{% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}

{% assign field_list = 'fields=' %}
{% assign sort_list = '&sorts=' %}
  {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
  {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
  {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
    {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}

    {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}

    {% comment %}remove year filter {% endcomment %}


    {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
    {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
    {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
    {% assign part2 = final_link | split: split_string__pivot_field_filter_start | last %}

    {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
    {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
    {% assign final_link2 = part1 | append: 'f[' | append: parts_after_created_year_filter_value | append: vis_config %}

    {{final_link2}}
      "
label:
"
    {% assign field_to_drill_into = created_date_week_of_year._name %}
    {% assign period_to_compare__field_to_pivot_on = created_year._name %}
    compare {{period_to_compare__field_to_pivot_on}}s, by {{field_to_drill_into}}
    "
    }

    link: {
      url: "
      {% assign orig_link = dummy_link_holder._link %}
      {% assign field_to_drill_into = created_date_day_of_year._name %}
      {% assign period_to_compare__field_to_pivot_on = created_year._name %}

      {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
      {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
      {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}

      {% assign field_list = 'fields=' %}
      {% assign sort_list = '&sorts=' %}
      {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
      {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
      {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
      {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}

      {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}

      {% comment %}remove year filter {% endcomment %}


      {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
      {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
      {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
      {% assign part2 = final_link | split: split_string__pivot_field_filter_start | last %}

      {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
      {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
      {% assign final_link2 = part1 | append: 'f[' | append: parts_after_created_year_filter_value | append: vis_config %}

      {{final_link2}}
      "
      label:
      "
      {% assign field_to_drill_into = created_date_day_of_year._name %}
      {% assign period_to_compare__field_to_pivot_on = created_year._name %}
      compare {{period_to_compare__field_to_pivot_on}}s, by {{field_to_drill_into}}
      "
    }

    link: {#by quarter of year
      url: "
      {% assign orig_link = dummy_link_holder._link %}
      {% assign field_to_drill_into = created_date_day_of_year._name %}
      {% assign period_to_compare__field_to_pivot_on = created_date_quarter_of_year._name %}

      {% comment %}insert the desired dimension to display in the drill and sort on that field...{% endcomment %}
      {% assign left_portion__to_fields = orig_link | split: 'fields=' | first %}
      {% assign right_portion__from_fields = orig_link | split: 'fields=' | last %}

      {% assign field_list = 'fields=' %}
      {% assign sort_list = '&sorts=' %}
      {% comment %}could be dynamic based on which fields are included...like: if created_month_name._is_selected{% endcomment %}
      {% assign field_list = field_list | append: field_to_drill_into | append: ',' %}
      {% assign sort_list = sort_list | append: field_to_drill_into | append: ',' %}
      {% assign field_list = field_list | append: field_to_drill_into | append: ',' | append: period_to_compare__field_to_pivot_on | append: ',' %}

      {% assign pivot_url_portion = '&pivots=' | append: period_to_compare__field_to_pivot_on %}

      {% comment %}remove year filter {% endcomment %}
      {% assign final_link = 'https://profservices.dev.looker.com' | append: left_portion__to_fields | append: field_list | append: right_portion__from_fields | append: sort_list | append: pivot_url_portion %}
      {% assign split_string__pivot_field_filter_start = 'f[' | append: period_to_compare__field_to_pivot_on | append: ']=' %}
      {% assign part1 = final_link | split: split_string__pivot_field_filter_start | first %}
      {% assign part2 = final_link | split: split_string__pivot_field_filter_start | last %}

      {% assign parts_after_created_year_filter_value = part2 | split: 'f[' | last %}
      {% assign vis_config = '&vis=%7B%22type%22%3A%22looker_line%22%2C%22series_types%22%3A%7B%7D%7D' %}
      {% assign final_link2 = part1 | append: 'f[' | append: parts_after_created_year_filter_value | append: vis_config %}

      {{final_link2}}
      "
      label:#create a label that says what is being filtered on.
      "
      {% assign orig_link = dummy_link_holder._link %}
      {% assign field_to_drill_into = created_date_day_of_year._name %}
      {% assign period_to_compare__field_to_pivot_on = created_date_quarter_of_year._name %}

      {% assign left_portion__to_filters = orig_link | split: '&f[' | first %}
      {% assign right_portion__from_filters = orig_link | split: left_portion__to_filters | last %}
      {% assign filters = right_portion__from_filters | split: '&sorts=' | first | split: '&query_timezone' | first | split: '&limit' | first %}

      {% assign formatted_filters = filters | replace: '&f[','-' | replace: ']','' %}
      compare {{period_to_compare__field_to_pivot_on}}s, by {{field_to_drill_into}}, filter on {{formatted_filters}}
      "
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


#   {% assign field_list = orig_link | slice: 2,5 %}
# fields=
}
