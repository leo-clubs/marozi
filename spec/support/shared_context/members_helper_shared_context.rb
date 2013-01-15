shared_context 'members helper' do |field_inner, value, name_inner, title_inner, type, opts |
  let(:field) { field_inner }
  let(:name) { name_inner }
  let(:title) { title_inner }

  before(:each) do
    @member = build(:simple_member, field => value)
    args = [field, type, title]
    args << opts if opts
    helper.should_receive(:name_cell).with(name).and_return(content_tag(:td))
    helper.should_receive(:value_cell).with(*args).and_return(content_tag(:td))
  end
end