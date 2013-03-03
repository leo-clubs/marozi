shared_examples_for 'member finders' do | method, login_id = nil |
  describe "##{method}" do

    let(:existing_id) { login_id }

    it 'should assign variables correctly' do
      factory_opts = {}
      if login_id
        factory_opts.merge! leo_id: existing_id
        session[:current_user] = existing_id
      end
      member = create(:simple_member, factory_opts)
      if login_id
        get method
      else
        get method, id: member.leo_id
      end
      assigns(:member).should eq member
      assigns(:club).should eq member.club
    end
  end
end