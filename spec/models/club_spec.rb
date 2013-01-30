require 'spec_helper'

describe Club do
  it_behaves_like 'a hierarchy'
  include_examples 'max_ids', Club, 5
end