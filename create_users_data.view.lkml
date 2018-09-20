view: create_users_data {
  derived_table: {
    sql:
    select 'kevin.mccarthy+101@looker.com' as Email,'111' as CouncilCode, 'Enabled' as Account,'SU602' as "Service Unit Name",'SU Roster' as Roles
    union all
    select 'kevin.mccarthy+2@looker.com' as Email,'113' as CouncilCode, 'Enabled' as Account,'SU602' as "Service Unit",'SU Roster,Admin' as Roles
    union all
    select 'kevin.mccarthy+3@looker.com' as Email,'113' as CouncilCode, 'Enabled' as Account,'SU602' as "Service Unit",'SU Roster,Admin' as Roles
    union all
    select 'kevin.mccarthy+4@looker.com' as Email,'113' as CouncilCode, 'Enabled' as Account,'SU602' as "Service Unit",'SU Roster,Admin' as Roles
    union all
    select 'kevin.mccarthy+5@looker.com' as Email,'113' as CouncilCode, 'Enabled' as Account,'SU602' as "Service Unit",'SU Roster,Admin' as Roles
    ;;
# Email CouncilCode Account Service Unit Name Roles
# kevin.mccarthy.999@gmail.com  116 Enabled SU602, SU603  SU Roster,Admin

  }
  dimension: Email {}
  dimension: CouncilCode {label:"Council Code"}
  dimension: Account {}
  dimension: Roles {}
  dimension: Service_Unit_Name {
    label: "Service Unit Name"
    sql: ${TABLE}."Service Unit Name";;
  }
}
