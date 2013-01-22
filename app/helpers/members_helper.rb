module MembersHelper
  def member_simple_attribute_tablerow(field: nil, name: nil, caption: nil, editable_class: 'editable')
    content_tag :tr do
      name_cell(name: name).concat(
        value_cell(
          field: field,
          value: value_from_member(field),
          type: 'text',
          editable_class: editable_class,
          caption: caption))
    end
  end

  def member_select_attribute_tablerow(field: nil, name: nil, select_options: [], caption: nil, editable_class: 'editable')
    content_tag :tr do
      data_source = select_options.inject([]){|result, line| result << {value: line[0], text: line[1]}}
      name_cell(name: name).concat(
        value_cell(
          field: field,
          value: value_from_member(field),
          type: 'select',
          caption: caption,
          editable_class: editable_class,
          :'data-field-source' => data_source.to_json))
    end
  end

  def member_date_attribute_tablerow(field: nil, name: nil, caption: nil, editable_class: 'editable')
    content_tag :tr do
      name_cell(name: name).concat(
        value_cell(
          field: field,
          value: date_value_from_member(field),
          type: 'date',
          caption: caption,
          editable_class: editable_class,
          :'data-field-datepicker' => {language: I18n.locale}.to_json))
    end
  end

  def value_cell(field: nil, value: nil, type: nil, caption: nil, editable_class: nil, **opts)
    content_tag(:td) { link_to(value, '#', {id: field, :'data-field-type' => type, :'data-field-title' => caption, class: editable_class}.merge(opts))}
  end

  def name_cell(name: nil)
    content_tag(:td, {width: '15%'}) { name }
  end

  private
  def value_from_member(field)
    @member ? @member.send(field) : nil
  end

  def date_value_from_member(field)
    @member ? @member.send(field).strftime('%Y-%m-%d') : nil
  end
end