connection: "thelook_events_redshift"

include: "basic_users.view"

view: join_with_different_table_name_def_base {
  extends: [basic_users]
  sql_table_name: public.users ;;
}

explore: join_with_different_table_name_def_base {
  join: another_version {
    from: join_with_different_table_name_def_base
    sql_table_name: (select * from ${join_with_different_table_name_def_base.SQL_TABLE_NAME} where age=20) ;;
    sql_on: ${join_with_different_table_name_def_base.id}=${another_version.id} ;;
    relationship: one_to_one
  }


  join: another__even_simpler {
    from: join_with_different_table_name_def_base
    sql_on:
${join_with_different_table_name_def_base.id}=${another__even_simpler.id}
and ${another__even_simpler.age} =30
    ;;
    relationship: one_to_one
  }

}
