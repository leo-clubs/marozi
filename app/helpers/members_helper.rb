module MembersHelper
  def gender_radio_buttons form, member
    [ :female, :male ].map do |gender|
      form.label(:gender, t(:"helpers.label.member.gender_#{gender}"), value: gender, class: ['radio', 'controls']) +
      form.radio_button(:gender, gender, checked: member.gender == gender)
    end.join("\n")
  end

  def member_simple_attribute_tablerow field, name, type, caption
    name_cell = content_tag(:td, {width: '15%'}) { name }
    value_cell = content_tag(:td) { link_to(@member.send(field), '#', {id: field, :'data-field-type' => type, :'data-title' => caption})}

    content_tag :tr do
      name_cell.concat value_cell
    end
  end
end