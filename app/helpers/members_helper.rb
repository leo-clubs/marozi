module MembersHelper
  def gender_radio_buttons form, member
    Rails.logger.debug "lg: form: #{form.class.inspect}"
    [ :female, :male ].map do |gender|
      form.label(:gender, t(:"helpers.label.member.gender_#{gender}"), value: gender) +
      form.radio_button(:gender, gender, checked: member.gender == gender)
    end.join("\n")
  end
end
