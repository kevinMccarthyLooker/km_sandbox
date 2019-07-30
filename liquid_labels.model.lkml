connection: "thelook_events_redshift"

view: users_liquid_labels {
  sql_table_name: public.users ;;
  dimension: age {
    view_label: "{{_view._name}}{% if age._is_selected %}selected{%else%}not selected{%endif%}"
  }
}

explore: users_liquid_labels_alternate {
  from: users_liquid_labels

}
