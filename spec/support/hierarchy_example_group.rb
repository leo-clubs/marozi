shared_examples_for 'a hierarchy' do | child_path |
  let(:existing_id) {'087294'}
  let(:non_existing_id) {'987294'}

  before(:each) do
    @member = create(:simple_member, leo_id: existing_id)
  end

  it 'should find subject for existing id' do
    child = @member
    child_path.each{|method| child = child.send(method)}

    actual = described_class.find_by_member_id existing_id
    actual.should eq child
  end

  it 'should find subject for non-existing id' do
    d = described_class.find_by_member_id non_existing_id
    d.should be_nil
  end
end