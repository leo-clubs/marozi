module MembersHelper
  def member_simple_attribute_tablerow field, name, caption
    value_cell = content_tag(:td) { link_to(@member.send(field), '#', {id: field, :'data-field-type' => 'text', :'data-field-title' => caption, class: 'editable'})}

    content_tag :tr do
      name_cell(name).concat value_cell
    end
  end

  def member_select_attribute_tablerow field, name, select_options, caption
    data_source = select_options.inject([]){|result, line| result << {value: line[0], text: line[1]}}
    value_cell = content_tag(:td) { link_to(@member.send(field), '#', {id: field, :'data-field-type' => 'select', :'data-field-title' => caption, :'data-field-source' => data_source.to_json, class: 'editable'})}

    content_tag :tr do
      name_cell(name).concat value_cell
    end
  end

  def name_cell name
    content_tag(:td, {width: '15%'}) { name }
  end
end