require 'spec_helper'

describe MultipleDistrict do
  it_behaves_like 'a hierarchy', 3
  include_examples 'max_ids', MultipleDistrict, 1
end