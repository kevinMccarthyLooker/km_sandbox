#testing related to this discourse
#https://help.looker.com/hc/en-us/articles/360023589613--More-Powerful-Data-Drilling
connection: "thelook_events_redshift"

include: "basic_users.view"

view: visual_drilling {
  extends: [basic_users]


  measure: count_with_drill {
    type: count
    drill_fields: [age,count]
    link: {
      label: "Explore Top 20 Results"
      url: "{{ link }}&limit=20"
    }
  }

  measure: count_with_drill2 {
    type: count
    drill_fields: [age,count]
    link: {
      label: "Show as scatter plot"
      url: "
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
  }

  measure: count_with_drill3 {
    type: count
    drill_fields: [age,count]
    link: {
      label: "Show as scatter plot"
      url: "@{viz_config_test}"
    }
    }


  measure: count_with_drill4{
    type: count
    drill_fields: [age,count,count_with_drill2]
    link: {
      label: "Show as scatter plot"
      url: "
      {% assign vis_config = '{
      \"legend_position\" : \"left\"
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

}

explore: visual_drilling {}
