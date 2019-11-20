connection: "thelook_events_redshift"

include: "*basic_users.view"

include: "*dashboard_hacking*"

view:dashboard_hacking {
  extends:[basic_users]

  measure: count_special_html {
    type: count
#     html:
#     <div class="vis" style="background-color:rgba(200,0,0,0.01);padding-bottom: 0px;">
#     <div class="vis-single-value" style="background-color:rgba(200,0,0,0.01); color:white;font-weight:bold;font-size:20px">
#     {{ value }}
#     </div>
#     </div>
#     ;;
#     html:
#     <div class="vis-single-value" style="background-color:rgba(200,0,0,0.01); color:white;font-weight:bold;font-size:20px">
#     {{ value }}
#     </div>
#     ;;
#     html:
#     <div class="vis" style="background-color:rgba(200,0,0,0.01);padding-bottom: 0px;">
#     {{ value }}
#     </div>
#     ;;
    html:
    <div class="vis" style="background-color:#2196F3;padding-bottom: 0px;">
    Note:<br>
    viz on top of viz is possible<br>
    using static lookml dash<br>
    with overlapping positioning<br>
    ...live data value: {{ value }}
    </div>
    ;;

  }

  }

explore: dashboard_hacking {}
