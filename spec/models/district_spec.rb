require 'spec_helper'

describe District do
  it_behaves_like 'a hierarchy'
  include_examples 'max_ids', District, 2
end