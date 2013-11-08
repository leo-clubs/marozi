module MembersHelper
  include XeditableCellHelper

  def member_link member
    link_to(t(:'members.name', first_name: member.first_name, last_name: member.last_name), member_path(id: member.oid))
  end

  def member_readonly_tablerow(caption: nil, value: nil)
    content_tag :tr do
      name_cell(name: caption).concat(content_tag(:td){value})
    end
  end

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

  def membership_list
    content_tag :ul, class: 'list-group' do
      @member.previous_memberships.map do |membership|
        content_tag :li, class: 'list-group-item' do
          I18n.translate(
            :'members.previous_membership',
            club_name: membership.club.name,
            from: I18n.l(membership.from, format: :long),
            to: I18n.l(membership.to, format: :long),
          )
        end
      end.inject(:concat)
    end
  end

  def member_gender_select_attribute_tablerow(editable_class: 'editable')
    name = I18n.translate(:'helpers.label.member.gender')
    select_options = [:female, :male].map{|gender| [gender, I18n.translate(:"helpers.label.member.gender_#{gender}")]}
    caption = I18n.translate(:'helpers.label.member.gender_caption')
    operation_for_value = lambda{|gender| I18n.translate(:"helpers.label.member.gender_#{gender}")}
    member_select_attribute_tablerow(field: :gender, name: name, select_options: select_options, operation_for_value: operation_for_value, editable_class: editable_class)
  end

  def member_select_attribute_tablerow(field: nil, name: nil, select_options: [], caption: nil, operation_for_value: nil, editable_class: 'editable')
    content_tag :tr do
      data_source = select_options.inject([]){|result, line| result << {value: line[0], text: line[1]}}
      raw_value = value_from_member(field, nil)
      name_cell(name: name).concat(
        value_cell(
          field: field,
          value: value_from_member(field, operation_for_value),
          type: 'select',
          selected: (data_source.select{|h| h[:value] == raw_value}.first[:value] rescue nil),
          caption: caption,
          editable_class: editable_class,
          :'data-field-source' => data_source.to_json))
    end
  end

  def member_date_attribute_tablerow(field: nil, name: nil, caption: nil, editable_class: 'editable')
    content_tag :tr do
      localized_format = i18n_date_format_to_xeditable_date_format(I18n.translate(:'date.formats.default'))
      international_value = date_value_from_member(field)
      localized_value = date_value_from_member(field, I18n.translate(:'date.formats.default'))
      name_cell(name: name).concat(
        value_cell(
          field: field,
          value: localized_value,
          type: 'date',
          caption: caption,
          editable_class: editable_class,
          :'data-value' => international_value,
          :'data-format' => i18n_date_format_to_xeditable_date_format('%Y-%m-%d'),
          :'data-viewformat' => localized_format,
          :'data-field-datepicker' => {language: I18n.locale}.to_json))
    end
  end

  def value_from_member(field, operation=nil)
    if @member
      operation ? operation.call(@member.send(field)) : @member.send(field)
    end
  end

  def date_value_from_member(field, date_format = '%Y-%m-%d')
    @member && @member.send(field) ? @member.send(field).strftime(date_format) : nil
  end
end