module XeditableConverters
  def member_array_to_xeditable member_array, operation = nil
    member_array.map do | person |
      {
        value: person.leo_id,
        text: operation ? operation.call(person) : person
      }
    end
  end
end