connection: "thelook_events_redshift"

include: "basic_users.*"

# html: <a href="/explore/command-center-dr/one_pager_mockup_support?fields=one_pager_mockup_support.kpi_name,one_pager_mockup_support.actual,one_pager_mockup_support.ly,one_pager_mockup_support.vs_ly,one_pager_mockup_support.budget,one_pager_mockup_support.vs_bu,one_pager_mockup_support.le,one_pager_mockup_support.vs_le&amp;f[one_pager_mockup_support.level_of_fields_to_show]=0&amp;origin=drill-menu" data-drill-type="drill" data-context="" target="_self" rel="noreferrer" data-skipmodal="false">
view:  custom_drill_overlay_test{
  extends: [basic_users]

  dimension: age_with_special_drill {
    sql: ${age} ;;
    # html: <a href="/explore/custom_drill_overlay_test/custom_drill_overlay_test" data-drill-type="drill" data-context="table_cell" target="_self" rel="noreferrer" lk-track-name="drill" lk-track-action="explore" lk-track-attrs="[object Object]">link</a> ;;
    # html: <a href="{{link_holder._link}}">link</a> ;;

    html: <a href="test" data-drill-type="drill" class="cell-clickable-content" target="_self">1</a> ;;

    # link: {
    #   label: "test"
    #   url: "/explore/custom_drill_overlay_test/custom_drill_overlay_test"
    # }
  }

  measure: link_holder {
    type: max
    sql: 1 ;;
    drill_fields: [age_with_special_drill]
  }
}

explore:custom_drill_overlay_test  {}
