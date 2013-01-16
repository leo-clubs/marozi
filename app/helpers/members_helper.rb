module MembersHelper
  def member_simple_attribute_tablerow field, name, caption
    content_tag :tr do
      name_cell(name).concat value_cell(field, @member.send(field), 'text', caption)
    end
  end

  def member_select_attribute_tablerow field, name, select_options, caption
    content_tag :tr do
      data_source = select_options.inject([]){|result, line| result << {value: line[0], text: line[1]}}
      name_cell(name).concat value_cell(field, @member.send(field), 'select', caption, {:'data-field-source' => data_source.to_json})
    end
  end

  def member_date_attribute_tablerow field, name, caption
    content_tag :tr do
      name_cell(name).concat(value_cell(field, @member.send(field).strftime('%Y-%m-%d'), 'date', caption, {:'data-field-datepicker' => {language: I18n.locale}.to_json}))
    end
  end

  def value_cell field, value, type, caption, opts = {}
    content_tag(:td) { link_to(value, '#', {id: field, :'data-field-type' => type, :'data-field-title' => caption, class: 'editable'}.merge(opts))}
  end

  def name_cell name
    content_tag(:td, {width: '15%'}) { name }
  end
end