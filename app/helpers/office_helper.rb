module OfficeHelper
  include XeditableCellHelper

  def office_member_select_attribute_tablerow(office)
    content_tag(:tr, {class: :office_row, data: {update_url: office_path(id: office.leo_id), leo_id: office.leo_id}}) do
      data_source = club_members_path(id: @club.leo_id, type: 'xeditable_names_only')
      value = I18n.translate(:'members.name', first_name: office.member.first_name, last_name: office.member.last_name)
      name_cell(name: I18n.translate(:"clubs.caption.officers_#{office.name}", default: 'to be translated'), width: '25%').concat(
        value_cell(name: office.name,
        value: value,
        type: 'select',
        caption: value,
        selected: office.member.leo_id,
        editable_class: 'edit-office',
        :'data-field-source' => data_source))
    end
  end
end