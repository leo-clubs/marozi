require 'spec_helper'

describe MultipleDistrict do
  it_behaves_like 'a hierarchy', [:club, :district, :multiple_district]
end