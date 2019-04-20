connection: "thelook_events_redshift"

# include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

view: users_for_derived_tables_test {
  sql_table_name: public.users ;;
  dimension: id {
    primary_key:yes
    sql: /*goodfy test*/${TABLE}.id ;;
  }
  dimension: id_referenced {sql:/*add test*/${id};;}
  dimension: age {type:number}
  measure: count {type:count}
}

view: example_derived_table {
  derived_table: {
    sql:
    select
    'test' as label,
/*refernce ._sql of a joined view:*/
{{users_for_derived_tables_test.id._sql}}
/*... gives sql text*/ as users_for_derived_tables_test_id,
--
/*refernce ._sql of a field which itself has a reference*/
{{users_for_derived_tables_test.id_referenced._sql | replace: 'oo','HHHHHHHHHHHH'}}
/*... doesn't work, just pulls the $ { and } off the field's sql, !unless the field is included!*/ as users_for_derived_tables_test_id_referenced,
--
--
/*refernce field which itself has a reference*/
/*$ {users_for_derived_tables_test.id_referenced}*/
/*... doesn't work, just gives the field name, and throws a warning*/ as users_for_derived_tables_test_id_referenced,
--

/*testing reference to field that doesn't exist:*/
{{users_for_derived_tables_test.id2._sql}}
/*... does not throw an error and resolves to nothing empty*/ as users_for_derived_tables_test_id2
    ;;
  }
  dimension: label {}
  dimension: users_for_derived_tables_test_id {}
  dimension: users_for_derived_tables_test_id_referenced {
    required_fields: [users_for_derived_tables_test.id_referenced]
  }

}

explore: users_for_derived_tables_test {
  join: example_derived_table {
    sql: ;;
    relationship: one_to_one
  }
}
