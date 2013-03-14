shared_context 'members helper' do | opts |
  [:field, :name, :caption].each do |key|
    let(key) {opts[key]}
  end

  before(:each) do
    puts "im context"
    @member = build(:simple_member, opts[:field] => opts[:value])
    helper.should_receive(:name_cell).with(opts.slice(:name)).and_return(content_tag(:td))
    helper.should_receive(:value_cell).with(opts.except(:name)).and_return(content_tag(:td))
  end
end