require 'spec_helper'

describe ClubsController do
  describe 'index' do
    before(:each) do
      2.times{create :district}
    end

    it 'should build the club hash correctly' do
      get :index
      clubs = assigns(:clubs)
      clubs.keys.should eq %w{KL UV}
      clubs.values.flatten.size.should eq Club.count
    end
  end
end