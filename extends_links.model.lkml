connection: "thelook_events_redshift"

view: users_base_for_links {
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: first_name {
    link: {
      url: "/dashboards/1"
      label: "test"

    }
  }

}


explore: users_base_for_links {}

view: users_extend_links {
  extends: [users_base_for_links]
  dimension: first_name {
    html:{{rendered_value}} <br>
    {{another_field._rendered_value}}
;;
  }
  dimension: another_field{
    sql: 'hardcoded' ;;
    type: string
    link: {
      url: "/dashboards/2"
      label: "another dashboard"
    }
  }
}

explore: users_extend_links {}
