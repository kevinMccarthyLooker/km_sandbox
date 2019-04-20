connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project


#my base table
view: users__title_tags
{
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {}
  measure: count {type:count}

  dimension: age_with_table {
    type: string
    sql: ${age} ;;
    html:
<table>
<td>
{% for i in (1..20) %}
<tr>Hi!</tr>
{% endfor %}
</td>
<td>
{% for i in (1..20) %}
<tr>there!</tr>
{% endfor %}
</td>
</table>
    ;;
  }

  #two fields to control whether looker uses group by or not
  dimension: age_with_title {
    type: string
    sql: ${age} ;;
    html:
<span>
Reactivation
<br>
Definition:
<br>
The
<br>
rate
<br>
at
<br>
which
<br>
a
<br>
user
<br>
re-engages
<br>
with
<br>
our
<br>
platform
{{linked_value}}
</span>;;
  }
  dimension: more_links{
    type: string
    sql: ${age} ;;
    link: {
      url: "https://profservices.dev.looker.com/browse"
      label: "home"
    }
    link: {
      url: "https://profservices.dev.looker.com/browse"
      label: "home2"
    }
  html: {{link}} ;;
  }

#use as a tiny tile, to provide a link on a dashboard.
  dimension: age_with_title_and_line_breads{
    type: string
    sql: 'placeholder value. Field intended for providing in browser rendered HTML' ;;
#span title makes a grey hover window.  Can't seem to control font or exact spacing, but still, a space conscious way to provide notes
    html:
<span title=
"Dashboard X
----------------------------------
Data Owner: Kevin McCarthy

Business Owner: Doc McStuffins

Intended Users: Customer Support Team

Purpose: Highlight next steps and facilitate necessary interventions.  Provide actionable insights.

Other Notes:
4/19 Created
4/20 Updated with new at risk tile
4/21 Questions about change $ shown on tile X
"</span>
<img src="https://logo-core.clearbit.com/looker.com"/>
<br>
Click for Links;;
#links will appear in a ... at the end of the html
    link: {
      url: "https://profservices.dev.looker.com/browse"
      label: "home"
    }
    link: {
      url: "https://profservices.dev.looker.com/browse"
      label: "home2"
    }
  }

measure: html {
  type: number
  sql: min(1) ;;
  html:
 <span style="color:Red;">
Lorem Ipsem
<br>
About this dashboard:
<br>
_____________ _____-        ___________   ______________    ________________  ____________________
<br>
Reactivation  Definition:   -             t                 t                 t
<br>
The           t
<br>
rate          t
<br>
<img src="https://logo-core.clearbit.com/looker.com" />
</span>

  ;;
}

measure: string_measure {
  type: string
  sql:
  case when max(${age})>15 then 'T' else
    case when max(${age})>13 then 'Z' else
    'F'
    end
  end ;;
}

}

#demo explore
explore: users__title_tags {}
