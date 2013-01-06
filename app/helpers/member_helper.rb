module MemberHelper
  def gender_select member
    concat 'div'
    form_for member do |form|
      [:female, :male].map do |g|
        form.radio_button :gender, g, checked: g == member.gender
        form.label :gender, g
      end
    end
  end
end