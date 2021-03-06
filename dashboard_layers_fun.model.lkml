connection: "thelook_events_redshift"

include: "basic_users.view"
# include: "merge_filter_example.dashboard"

include: "test_thin*"

view: dashboard_layers_fun {
  extends: [basic_users]

  measure: picture1 {
    sql: max(1) ;;
    html:
    <div style='vis;background-color:rgba(255,255,255,0.001)'>
    <img style="width:250px;height:250px;" src="https://lou.looker.com/assets/img/profile_picture/fabio.jpg" />
    </div>
    ;;
  }
  measure: picture2 {
    sql: max(1) ;;
    html:
    <div style='vis;background-color:rgba(255,255,255,0.001)'>
    <img style="width:250px;height:250px;" src="https://lou.looker.com/assets/img/profile_picture/greg.li.jpg" />
    </div>;;
  }

  measure: picture3 {
    sql: max(1) ;;
    html:
    <div style='vis;background-color:rgba(255,255,255,0.001)'>
    <img style="width:250px;height:250px;" src="https://lou.looker.com/assets/img/profile_picture/{{_user_attributes['email'] | replace:'@looker.com'.''}}.jpg" />
    </div>;;
  }

}
explore: dashboard_layers_fun {}
include: "overlay.dashboard"
