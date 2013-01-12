RSpec::Matchers.define :have_same_attributes_as do |expected|
  match do |actual|
    if actual.class != Array
      actual = [actual]
      expected = [expected]
    end
    raise "different size: expected: #{expected.size} actual: #{actual.size}" if expected.size != actual.size
    ignored = ['_id']

    [actual, expected].each{|a| a.map!{|c| c.attributes.except(*ignored)}}
    actual == expected
  end
end