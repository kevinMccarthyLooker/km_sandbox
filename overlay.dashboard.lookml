- dashboard: test_dasboard_filters_reference_break
  title: test dasboard filters reference break
  layout: static
  embed_style:
    background_color: ''
    show_title: false
    title_color: "#d6f4ff"
    show_filters_bar: false
    tile_text_color: "#fff5f8"
    text_tile_text_color: ''
  elements:
  - title: Untitled (copy)
    name: Untitled (copy)
    model: dashboard_layers_fun
    explore: dashboard_layers_fun
    type: looker_column
    fields: [dashboard_layers_fun.count]
    limit: 500
    series_types: {}
    listen: {}
    row: 0
    col: 0
    width: 8
    height: 6
  - title: Untitled
    name: Untitled
    model: dashboard_layers_fun
    explore: dashboard_layers_fun
    type: single_value
    fields: [dashboard_layers_fun.count]
    limit: 500
    series_types: {}
    listen: {}
    row: 0
    col: 0
    width: 8
    height: 6
