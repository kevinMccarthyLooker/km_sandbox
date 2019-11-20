- dashboard: dash_hacking_nonbeta
  title: dash hacking (non-beta)
  layout: static
  tile_size: 100
  elements:
  - title: column chart
    name: column chart
    model: dashboard_hacking
    explore: dashboard_hacking
    type: looker_column
    fields: [dashboard_hacking.count]
    limit: 500
    query_timezone: America/New_York
    series_types: {}
    left: 0
    top: 0
    width: 8
    height: 8
  # - title: dash hacking
  #   name: dash hacking
  #   model: dashboard_hacking
  #   explore: dashboard_hacking
  #   type: single_value
  #   fields: [dashboard_hacking.count]
  #   limit: 500
  #   query_timezone: America/New_York
  #   series_types: {}
  #   top: 4
  #   left: 2
  #   width: 4
  #   height: 1
  - name: add_a_unique_name_1573832425
    title: Untitled Visualization
    model: dashboard_hacking
    explore: dashboard_hacking
    type: single_value
    fields: [dashboard_hacking.count, dashboard_hacking.count_special_html]
    limit: 500
    query_timezone: America/New_York
    series_types: {}
    hidden_fields: [dashboard_hacking.count]
    top: 4
    left: 2
    width: 5
    height: 1
    hidden_fields: [dashboard_hacking.count]
  - name: ''
    type: text
    body_text: |-
      <div class="alert alert-warning">
        <div class="card-header" style="color:red;">
          Look Ma, I'm annotating!
        </div>
      </div>

      <br>

      <br>

      <br>

      <br>

      <br>

      <br>

      <br>

      <br>

      <br>

      <div class="alert alert-warning" >
        <div class="card-header" style="color:red;">
          fun!
        </div>
      </div>
    left: 0
    top: 0
    width: 8
    height: 4
