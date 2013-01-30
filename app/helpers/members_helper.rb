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

  def value_cell(opts)
    opts[:value] ||= ''
    puts "here are the opts: #{opts.inspect}"
    content_tag(:td) { edit_link(opts) }
  end

  def name_cell(name: nil)
    content_tag(:td, {width: '15%'}) { name }
  end

  def edit_link(opts)
    safe_opts = opts.dup
    link_to(safe_opts.delete(:value), '#', {id: safe_opts.delete(:field), :'data-field-type' => safe_opts.delete(:type), :'data-field-title' => safe_opts.delete(:caption), class: safe_opts.delete(:editable_class)}.merge(safe_opts))
  end

  private
  def value_from_member(field)
    @member ? @member.send(field) : nil
  end

  def date_value_from_member(field)
    @member && @member.send(field) ? @member.send(field).strftime('%Y-%m-%d') : nil
  end
end