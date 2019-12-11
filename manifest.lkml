project_name: "km_sandbox"

# localization_settings: {
#   # localization_level: [strict | permissive]
#   localization_level: permissive
#   default_locale: en
# }

#can 'capture' inputs like this and use them in comples
constant: trim_quotes_begin {
  value: "{% assign trim_quotes_input = "
}
constant: trim_quotes_end {
  value: "%}{% assign trim_quotes_input_size = trim_quotes_input | size | minus:2 %}{{trim_quotes_input | slice: 1 , trim_quotes_input_size }}"
  # value: "%}{% assign trim_quotes_input_size = 2 %}{{trim_quotes_input | slice: 1 , trim_quotes_input_size }}"
}
constant: test_var {
  value: "'testing abc'"
}

constant: owner {
  value: "{% if _explore._name == 'users__constants' %} 'Matched' {% else %} Default Placeholder{%endif%}"
  }

constant: test_constant {
  value: "02349_sfo"
}

constant: constant__now {
  value: "{{'now' | date: '%Y'}}"
}

constant: format_as_integer {value: "{{ value | round }}"}

constant: format_as_round_to_10s {value: "{{ value | round:1 }}"}

constant: camelize {
  value:
  "
  capitalize
  | replace: ' a',' A'
  | replace: ' b',' B'
  | replace: ' c',' C'
  | replace: ' d',' D'
  | replace: ' e',' E'
  | replace: ' f',' F'
  | replace: ' g',' G'
  | replace: ' h',' H'
  | replace: ' i',' I'
  | replace: ' j',' J'
  | replace: ' k',' K'
  | replace: ' l',' L'
  | replace: ' m',' M'
  | replace: ' n',' N'
  | replace: ' o',' O'
  | replace: ' p',' P'
  | replace: ' q',' Q'
  | replace: ' r',' R'
  | replace: ' s',' S'
  | replace: ' t',' T'
  | replace: ' u',' U'
  | replace: ' v',' V'
  | replace: ' x',' X'
  | replace: ' y',' Y'
  | replace: ' z',' Z'
  "
}

constant: viz_config_test {
  value:
"
      {% assign vis_config = '{
      \"stacking\" : \"\",
      \"show_value_labels\" : false,
      \"label_density\" : 25,
      \"legend_position\" : \"center\",
      \"x_axis_gridlines\" : true,
      \"y_axis_gridlines\" : true,
      \"show_view_names\" : false,
      \"limit_displayed_rows\" : false,
      \"y_axis_combined\" : true,
      \"show_y_axis_labels\" : true,
      \"show_y_axis_ticks\" : true,
      \"y_axis_tick_density\" : \"default\",
      \"y_axis_tick_density_custom\": 5,
      \"show_x_axis_label\" : false,
      \"show_x_axis_ticks\" : true,
      \"x_axis_scale\" : \"auto\",
      \"y_axis_scale_mode\" : \"linear\",
      \"show_null_points\" : true,
      \"point_style\" : \"circle\",
      \"ordering\" : \"none\",
      \"show_null_labels\" : false,
      \"show_totals_labels\" : false,
      \"show_silhouette\" : false,
      \"totals_color\" : \"#808080\",
      \"type\" : \"looker_scatter\",
      \"interpolation\" : \"linear\",
      \"series_types\" : {},
      \"colors\": [
      \"palette: Santa Cruz\"
      ],
      \"series_colors\" : {},
      \"x_axis_datetime_tick_count\": null,
      \"trend_lines\": [
      {
      \"color\" : \"#000000\",
      \"label_position\" : \"left\",
      \"period\" : 30,
      \"regression_type\" : \"average\",
      \"series_index\" : 1,
      \"show_label\" : true,
      \"label_type\" : \"string\",
      \"label\" : \"30 day moving average\"
      }
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"

}

constant: filter_field_to_filter_label_mappings {
  value: "
'
liquid_drops.age,age_filter,
liquid_drops.age,another_age_filter,
liquid_drops.gender,sex
'
  "

}

constant: field_to_filter_name_mapping {
 value: "

{% assign original = input %}
{% assign original_value = input | split: '=' | last %}
{% assign original_field = input | split: '=' | first %}
{% assign output = '' %}

{% assign used_filter_labels =
@{filter_field_to_filter_label_mappings}
| strip_newlines | split: ',' %}
{% assign used_filter_label_size = used_filter_labels | size %}

{% for i in (0..used_filter_label_size) %}
  {% assign i_mod = 0 %}
  {% assign i_mod = i | modulo: 2 %}
  {% if i_mod == 0 %}
    {% if original_field == used_filter_labels[i] %}
      {% assign next_index = i | plus:1 %}
      {% assign renamed_field = used_filter_labels[next_index] %}
      {% assign output = output | append: '&' | append: renamed_field | append:'=' | append: original_value %}
    {% endif %}
  {%endif%}
{%endfor%}
{% assign output = output | append: '&' | append: original_field | append:'=' | append: original_value %}

"

# {% for this_filter_label in used_filter_labels %}
#   {% if original_field == this_filter_label %}
#     {% assign renamed_field = 'age_filter' %}
#     {% assign output = output | append: '&' | append: renamed_field | append:'=' | append: original_value %}
#   {% endif %}
# {% endfor %}

# {% if original_field == 'liquid_drops.age' %}
}
