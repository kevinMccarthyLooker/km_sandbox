- dashboard: special_dashboard_filter_copy
  title: Special Dashboard Filter (copy)
  layout: newspaper
  elements:
  - name: a
    title: a
    merged_queries:
    - model: aaa_safe_basic_explores
      explore: basic_users
      type: looker_line
      fields: [basic_users.created_week, basic_users.count]
      fill_fields: [basic_users.created_week]
      sorts: [basic_users.created_week desc]
      limit: 500
      series_types: {}
    - model: aaa_safe_basic_explores
      explore: basic_users
      type: table
      fields: [basic_users.created_week, basic_users.count]
      fill_fields: [basic_users.created_week]
      limit: 500
      query_timezone: America/New_York
      join_fields:
      - field_name: basic_users.created_week
        source_field_name: basic_users.created_week
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: true
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hide_legend: true
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    swap_axes: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_area
    hidden_fields: [placeholder_to_make_query_different]
    listen:
    -
    - Untitled Filter: basic_users.created_date
    row: 0
    col: 0
    width: 1
    height: 15
  filters:
  - name: Untitled Filter
    title: Untitled Filter
    type: date_filter
    default_value: 7 days
    allow_multiple_values: true
    required: false
