include: "order_items*"
view: order_items_dynamic_labels_testing {
  extends: [order_items]

  parameter: input_param {}

  dimension: param_value {
#sql: {{ input_param._value }} ;;#blank
#sql:  {{ input_param._sql }};;#blank
#sql: {{ _filters['order_items_dynamic_labels_testing.input_param'] }} ;;#cannot use _filters in sql
    sql: case when {% parameter input_param %} = '' then 'no selection' else {% parameter input_param %} end;;# ok

    label:
    "{% assign field_name_formatted = '' %}{% comment %}
{% endcomment %}{% assign field_name_only_words = _field._name | replace: '_',' ' | split: '.'  | last | split: ' ' %}{% comment %}
{% endcomment %}{% for word in field_name_only_words %}{% comment %}
{% endcomment %}{% assign this_word_capitalized = word | capitalize %}{% comment %}
{% endcomment %}{% assign field_name_formatted = field_name_formatted | append: this_word_capitalized | append: ' ' %}{% comment %}
{% endcomment %}{% endfor %}{% comment %}
{% endcomment %}{% assign label_value = _filters['input_param'] | replace \"'\",'' %}{% comment %}
{% endcomment %}{% if _field._in_query == true %}{{label_value}}{% else %}{{field_name_formatted}}{% endif %}"
  }


}
