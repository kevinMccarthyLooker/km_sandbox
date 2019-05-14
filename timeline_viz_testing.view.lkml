view: timeline_viz_testing {
  derived_table: {
    sql:
select '1' as id, 'a' as group1_id, 'cost' as group2_id, 0.5 as value union all
select '2' as id, 'a' as group1_id, 'cost' as group2_id, 1 as value union all
select '3' as id, 'a' as group1_id, 'revenue' as group2_id, 1.5 as value union all
select '4' as id, 'a' as group1_id, 'revenue' as group2_id, 2 as value union all
select '5' as id, 'a' as group1_id, 'revenue' as group2_id, 2.5 as value union all
select '6' as id, 'a' as group1_id, 'cost' as group2_id, 3 as value union all
select '7' as id, 'a' as group1_id, 'revenue' as group2_id, 3.5 as value union all
select '8' as id, 'a' as group1_id, 'revenue' as group2_id, 4 as value union all
select '9' as id, 'a' as group1_id, 'revenue' as group2_id, 0 as value union all
select '10' as id, 'a' as group1_id, 'revenue' as group2_id, 0.5 as value union all
select '11' as id, 'a' as group1_id, 'cost' as group2_id, 1 as value union all
select '12' as id, 'a' as group1_id, 'revenue' as group2_id, 1.5 as value union all
select '13' as id, 'a' as group1_id, 'revenue' as group2_id, 2 as value union all
select '14' as id, 'a' as group1_id, 'cost' as group2_id, 2.5 as value union all
select '15' as id, 'a' as group1_id, 'revenue' as group2_id, 3 as value union all
select '16' as id, 'a' as group1_id, 'cost' as group2_id, 3.5 as value union all
select '17' as id, 'a' as group1_id, 'cost' as group2_id, 4 as value union all
select '18' as id, 'a' as group1_id, 'revenue' as group2_id, 0 as value union all
select '19' as id, 'a' as group1_id, 'revenue' as group2_id, 0.5 as value union all
select '20' as id, 'b' as group1_id, 'revenue' as group2_id, 1 as value union all
select '21' as id, 'b' as group1_id, 'cost' as group2_id, 1.5 as value union all
select '22' as id, 'b' as group1_id, 'revenue' as group2_id, 2 as value union all
select '23' as id, 'b' as group1_id, 'cost' as group2_id, 2.5 as value union all
select '24' as id, 'b' as group1_id, 'cost' as group2_id, 3 as value union all
select '25' as id, 'b' as group1_id, 'cost' as group2_id, 3.5 as value union all
select '26' as id, 'b' as group1_id, 'cost' as group2_id, 4 as value union all
select '27' as id, 'b' as group1_id, 'revenue' as group2_id, 0 as value union all
select '28' as id, 'b' as group1_id, 'cost' as group2_id, 0.5 as value union all
select '29' as id, 'b' as group1_id, 'revenue' as group2_id, 1 as value union all
select '30' as id, 'b' as group1_id, 'cost' as group2_id, 1.5 as value union all
select '31' as id, 'b' as group1_id, 'revenue' as group2_id, 2 as value union all
select '32' as id, 'b' as group1_id, 'revenue' as group2_id, 2.5 as value union all
select '33' as id, 'b' as group1_id, 'cost' as group2_id, 3 as value union all
select '34' as id, 'b' as group1_id, 'revenue' as group2_id, 3.5 as value union all
select '35' as id, 'b' as group1_id, 'revenue' as group2_id, 4 as value union all
select '36' as id, 'b' as group1_id, 'revenue' as group2_id, 0 as value union all
select '37' as id, 'b' as group1_id, 'cost' as group2_id, 0.5 as value union all
select '38' as id, 'b' as group1_id, 'cost' as group2_id, 1 as value union all
select '39' as id, 'b' as group1_id, 'cost' as group2_id, 1.5 as value union all
select '40' as id, 'b' as group1_id, 'revenue' as group2_id, 2 as value union all
select '41' as id, 'b' as group1_id, 'revenue' as group2_id, 2.5 as value union all
select '42' as id, 'b' as group1_id, 'cost' as group2_id, 3 as value union all
select '43' as id, 'b' as group1_id, 'revenue' as group2_id, 3.5 as value union all
select '44' as id, 'b' as group1_id, 'cost' as group2_id, 4 as value union all
select '45' as id, 'b' as group1_id, 'cost' as group2_id, 0 as value union all
select '46' as id, 'b' as group1_id, 'cost' as group2_id, 0.5 as value union all
select '47' as id, 'b' as group1_id, 'revenue' as group2_id, 1 as value union all
select '48' as id, 'b' as group1_id, 'cost' as group2_id, 1.5 as value union all
select '49' as id, 'b' as group1_id, 'revenue' as group2_id, 2 as value union all
select '50' as id, 'c' as group1_id, 'revenue' as group2_id, 2.5 as value union all
select '51' as id, 'c' as group1_id, 'cost' as group2_id, 3 as value union all
select '52' as id, 'c' as group1_id, 'cost' as group2_id, 3.5 as value union all
select '53' as id, 'c' as group1_id, 'cost' as group2_id, 4 as value union all
select '54' as id, 'c' as group1_id, 'cost' as group2_id, 0 as value union all
select '55' as id, 'c' as group1_id, 'revenue' as group2_id, 0.5 as value union all
select '56' as id, 'c' as group1_id, 'revenue' as group2_id, 1 as value union all
select '57' as id, 'c' as group1_id, 'cost' as group2_id, 1.5 as value union all
select '58' as id, 'c' as group1_id, 'cost' as group2_id, 2 as value union all
select '59' as id, 'c' as group1_id, 'cost' as group2_id, 2.5 as value union all
select '60' as id, 'c' as group1_id, 'revenue' as group2_id, 3 as value union all
select '61' as id, 'c' as group1_id, 'cost' as group2_id, 3.5 as value union all
select '62' as id, 'c' as group1_id, 'revenue' as group2_id, 4 as value union all
select '63' as id, 'c' as group1_id, 'cost' as group2_id, 0 as value union all
select '64' as id, 'c' as group1_id, 'revenue' as group2_id, 0.5 as value union all
select '65' as id, 'c' as group1_id, 'revenue' as group2_id, 1 as value union all
select '66' as id, 'c' as group1_id, 'revenue' as group2_id, 1.5 as value union all
select '67' as id, 'c' as group1_id, 'cost' as group2_id, 2 as value union all
select '68' as id, 'c' as group1_id, 'revenue' as group2_id, 2.5 as value union all
select '69' as id, 'c' as group1_id, 'revenue' as group2_id, 3 as value union all
select '70' as id, 'c' as group1_id, 'revenue' as group2_id, 3.5 as value union all
select '71' as id, 'c' as group1_id, 'revenue' as group2_id, 4 as value union all
select '72' as id, 'c' as group1_id, 'revenue' as group2_id, 0 as value union all
select '73' as id, 'c' as group1_id, 'revenue' as group2_id, 0.5 as value union all
select '74' as id, 'c' as group1_id, 'cost' as group2_id, 1 as value union all
select '75' as id, 'c' as group1_id, 'revenue' as group2_id, 1.5 as value union all
select '76' as id, 'c' as group1_id, 'cost' as group2_id, 2 as value union all
select '77' as id, 'c' as group1_id, 'cost' as group2_id, 2.5 as value union all
select '78' as id, 'c' as group1_id, 'cost' as group2_id, 3 as value union all
select '79' as id, 'c' as group1_id, 'revenue' as group2_id, 3.5 as value union all
select '80' as id, 'c' as group1_id, 'revenue' as group2_id, 4 as value union all
select '81' as id, 'c' as group1_id, 'cost' as group2_id, 0 as value union all
select '82' as id, 'c' as group1_id, 'cost' as group2_id, 0.5 as value union all
select '83' as id, 'c' as group1_id, 'revenue' as group2_id, 1 as value union all
select '84' as id, 'c' as group1_id, 'revenue' as group2_id, 1.5 as value union all
select '85' as id, 'c' as group1_id, 'cost' as group2_id, 2 as value union all
select '86' as id, 'c' as group1_id, 'revenue' as group2_id, 2.5 as value union all
select '87' as id, 'c' as group1_id, 'revenue' as group2_id, 3 as value union all
select '88' as id, 'c' as group1_id, 'cost' as group2_id, 3.5 as value union all
select '89' as id, 'c' as group1_id, 'revenue' as group2_id, 4 as value union all
select '90' as id, 'c' as group1_id, 'cost' as group2_id, 0 as value union all
select '91' as id, 'c' as group1_id, 'cost' as group2_id, 0.5 as value union all
select '92' as id, 'c' as group1_id, 'cost' as group2_id, 1 as value union all
select '93' as id, 'c' as group1_id, 'revenue' as group2_id, 1.5 as value union all
select '94' as id, 'c' as group1_id, 'cost' as group2_id, 2 as value union all
select '95' as id, 'c' as group1_id, 'revenue' as group2_id, 2.5 as value union all
select '96' as id, 'c' as group1_id, 'revenue' as group2_id, 3 as value union all
select '97' as id, 'c' as group1_id, 'revenue' as group2_id, 3.5 as value

    ;;
  }
  dimension: id {
    primary_key: yes
  }
  dimension: group1_id {}
  dimension: group2_id {}
  dimension: value {
    type: number
  }
  dimension: value_end {
    type: number
    sql: ${value}+1 ;;
  }
  measure: base_count {
    type: count
  }
  measure: total_value {
    type: sum
    sql: ${TABLE}.value ;;
  }
  measure: total_value_end {
    type: number
    sql: ${total_value}+1 ;;
  }
  measure: total_revenue_start {
    type: sum

    sql: 0 ;;
  }
  measure: total_cost {
    type: sum
    filters: {
      field: group2_id
      value: "cost"
    }
    sql: ${TABLE}.value ;;
  }
  measure: rev_minus_cost {
    type: number
    sql: ${total_value}-${total_cost} ;;
  }

  measure: start {
    type: number
    sql: case when ${group2_id}='revenue' then 0 else ${total_cost} end ;;
  }
#   measure: end {}



}
