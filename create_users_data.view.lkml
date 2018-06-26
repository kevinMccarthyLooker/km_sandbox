view: create_users_data {
  derived_table: {
    sql:
    select 'kevin.mccarthy+1@looker.com' as Email,'111' as CouncilCode, 'Enabled' as Account,'SU602' as "Service Unit",'SU Roster' as Roles
    union all
    select 'kevin.mccarthy+2@looker.com' as Email,'112' as CouncilCode, 'Enabled' as Account,'SU602' as "Service Unit",'SU Roster,Admin' as Roles

    ;;
# Email CouncilCode Account Service Unit Name Roles
# kevin.mccarthy.999@gmail.com  116 Enabled SU602, SU603  SU Roster,Admin

  }
  dimension: Email {}
  dimension: CouncilCode {}
  dimension: Account {}
  dimension: Roles {}
}
