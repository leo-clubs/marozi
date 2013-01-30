shared_examples_for 'a hierarchy' do
  let(:existing_id) { 87294 }
  let(:non_existing_id) { 987294 }
  let(:md_id) {@member.club.district.multiple_district.leo_id}
  let(:subject) {(rec = lambda{|m| m.class == described_class ? m : rec.call(m.parent)}).call(@member)}

  before(:each) do
    @member = create(:simple_member, leo_id: existing_id)
  end

  describe '#find_by_member_id' do
    it 'should find subject for existing id' do
      actual = described_class.find_by_member_id existing_id
      expect(actual).to eq subject
    end

    it 'should not find subject for non-existing id' do
      d = described_class.find_by_member_id non_existing_id
      expect(d).to be_nil
    end
  end

  describe '#current_multiple_district_id' do
    it 'should find subject for existing id' do
      expect(subject.current_multiple_district_id).to eq(md_id)
    end
  end
end