shared_context 'members helper' do |field_inner, value_inner, title_inner, caption_inner |
  let(:field) { field_inner }
  let(:value) { value_inner }
  let(:title) { title_inner }
  let(:caption) { caption_inner }

  before(:each) do
    @member = build(:simple_member, field => value)
    helper.should_receive(:name_cell).with(title).and_return(content_tag(:td))
  end
end