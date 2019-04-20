connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
view: users__controlled_fields {
  sql_table_name: users ;;
### Issue Desciption:
## I need to expose different subsets of fields in different explores.
## Sets are the right approach, but how to easily define and maintain set lists for this purpose?
## One challenge is that if I just want to make a field visible in a given explore that has limited fields,
## I often have to find an appropriate set to put the into, so i have to bounce to the explore and figure out what sets are included, etc.
#
## Behold, an process/approach that ultimately allows you to manage the inclusion of a field in a set without leaving the area of the field definition.
#
## Basically, whenever needed we create a helper set which represents that fields inclusion in a bigger master set.
## We then can maintain the master set trivially by ensuring it is comprised of all subsets with a matching name.

# (Process): When we want a field to show, add the field to a new standalone (sub)set directly below the field definition. This will make it easy for us to reference it later for inclusion in other sets or explores
# Use this naming convention: #set: <set_name>__<field_name> {fields:[<field_name>]}
  dimension: first_name {}
  set: contact_info__first_name {fields:[first_name]}

# (Comment on Benefits): Don't need to explicitly add hidden parameter or do anything for fields we don't want to show.*
  dimension: id {type: number}
  #see... no need to mention any sets or hidden parameter

  dimension: email {}
  set: contact_info__email {fields:[email]}

# (Examples): Adding a field to a different list
  dimension: age {}
  set: demographics_info__age {fields:[age]}

# (Examples): Easily add a fields to multiple sets, and easily see all sets that a field is included in
  dimension: state {}
  set: contact_info__state {fields:[state]}
  set: demographics_info__state {fields:[state]}

# (Examples): If you later decide to remove a field from a set, simply delete the field name from the fields parameter
  dimension: city {}
  set: demographics_info__city {fields:[]}##(updated from): set: demographics_info__state {fields:[city]}

## Compile Our Final Sets.
# Need to associate each (sub)set to the master set, by referencing the subset you created for it.
# Process is simply to start typing the master set name and select the fields that are highlighted by the IDE, making sure to get each matching subset in same order (for your sanity)
  set: contact_info {
    fields:[
      contact_info__email*,
      contact_info__first_name*,
    ]
  }

  set: demographics_info {
    fields: [
      demographics_info__age*,
      demographics_info__city*,
      demographics_info__state*,
    ]
  }

#Process Review -
# Notice you want to include a new field in an existing set. For example, want to add last name to contact_info
# start adding a set, and in fields parameter, start typying the name of the set you want to add to, and pick the last entry
# copy that selected value, add one, and make that the name of the new set you are creating
}

explore: users__controlled_fields {
  label: "Field Control Example - Demographic Info Only Explore"
  fields: [users__controlled_fields.demographics_info*]
}

explore: order_items__for_fields_control_example {
  from: order_items
  label: "Field Control Example - Order Items With User Contact and Demographic Fields"
  #include both contact info and demographic info
  join: users__controlled_fields {
    fields: [
      demographics_info*,
      contact_info*,
    ]
  }
}
