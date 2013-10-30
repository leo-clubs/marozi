require 'spec_helper'

describe Membership do
  subject {Membership.new}

  it 'provides the possibility to get and set member' do
    expect(subject).to respond_to(:member)
    expect(subject).to respond_to(:member=)
  end
end
