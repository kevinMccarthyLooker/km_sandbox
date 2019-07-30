connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

view: users_for_group_label_automation {
  sql_table_name: public.users ;;
  dimension: group_label_search_string {sql:age;;hidden:yes}
  dimension: group_label_to_add {sql:Age Fields;;hidden:yes}

  dimension: id {
    group_label:"{% assign x = group_label_search_string._sql%}{% assign orig_size = _field._name | size %}{% assign field_name_up_to_search_string = _field._name | split: {{x}} | first %}{% assign field_name_up_to_search_string_size = field_name_up_to_search_string | size %}{% if orig_size > field_name_up_to_search_string_size %}{{group_label_to_add._sql}}{% endif %}"
    primary_key:yes
  }
  # {% if x | size %}
  dimension: age {
    group_label:"{% assign x = group_label_search_string._sql%}{% assign orig_size = _field._name | size %}{% assign field_name_up_to_search_string = _field._name | split: {{x}} | first %}{% assign field_name_up_to_search_string_size = field_name_up_to_search_string | size %}{% if orig_size > field_name_up_to_search_string_size %}{{group_label_to_add._sql}}{% endif %}"
    type:number
  }
  dimension: age_2 {
    group_label:"{% assign x = group_label_search_string._sql%}{% assign orig_size = _field._name | size %}{% assign field_name_up_to_search_string = _field._name | split: {{x}} | first %}{% assign field_name_up_to_search_string_size = field_name_up_to_search_string | size %}{% if orig_size > field_name_up_to_search_string_size %}{{group_label_to_add._sql}}{% endif %}"
  }

}

explore: users_for_group_label_automation {}
