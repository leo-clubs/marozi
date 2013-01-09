shared_examples_for 'variable assignment for members controller' do | method |
  describe "##{method}" do
    it 'should assign variables correctly' do
      member = create(:simple_member)
      get method, id: member.leo_id
      assigns(:member).should eq member
      assigns(:club).should eq member.club
    end
  end
end