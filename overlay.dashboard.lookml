# - dashboard: test_dashboard_overlay_fun
#   title: test dashboard overlay fun
  # layout: static
  # embed_style:
  #   background_color: ''
  #   show_title: false
  #   title_color: "#d6f4ff"
  #   show_filters_bar: false
  #   tile_text_color: "#fff5f8"
  #   text_tile_text_color: ''
  # elements:
  # - title: Untitled (copy)
  #   name: Untitled (copy)
  #   model: dashboard_layers_fun
  #   explore: dashboard_layers_fun
  #   type: looker_column
  #   fields: [dashboard_layers_fun.count]
  #   limit: 500
  #   series_types: {}
  #   listen: {}
  #   row: 0
  #   col: 0
  #   width: 8
  #   height: 6
  # - title: Untitled
  #   name: Untitled
  #   model: dashboard_layers_fun
  #   explore: dashboard_layers_fun
  #   type: single_value
  #   fields: [dashboard_layers_fun.picture1]
  #   limit: 500
  #   series_types: {}
  #   listen: {}
  #   row: 0
  #   col: 0
  #   width: 8
  #   height: 6
- dashboard: overlay
  title: overlay
  layout: static
  embed_style:
  # # background_color: ''
  # show_title: false
  # title_color: "#d6f4ff"
  # show_filters_bar: false
  # tile_text_color: "#fff5f8"
  # text_tile_text_color: ''
  elements:
  - title: pie
    name: pie
    model: dashboard_layers_fun
    explore: dashboard_layers_fun
    type: looker_pie
    fields: [dashboard_layers_fun.count, dashboard_layers_fun.state]
    filters:
      dashboard_layers_fun.state: North Carolina,New York
    sorts: [dashboard_layers_fun.count desc]
    limit: 500
    series_types: {}
    left: 0
    top: 0
    width: 8
    height: 8
  - title: Untitled (copy)
    name: Untitled (copy)
    model: dashboard_layers_fun
    explore: dashboard_layers_fun
    type: single_value
    fields: [dashboard_layers_fun.picture1]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    left: 1
    top: 0
    width: 2
    height: 6
  - title: Untitled
    name: Untitled
    model: dashboard_layers_fun
    explore: dashboard_layers_fun
    type: single_value
    fields: [dashboard_layers_fun.picture2]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    left: 4
    top: 0
    width: 2
    height: 8
  - title: Untitled2
    name: Untitled2
    model: dashboard_layers_fun
    explore: dashboard_layers_fun
    type: single_value
    fields: [dashboard_layers_fun.picture3]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    left: 6
    top: 0
    width: 2
    height: 2
