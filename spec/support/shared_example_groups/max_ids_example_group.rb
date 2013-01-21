shared_examples_for 'max_ids' do | klass, count |

  let(:max_id_from_model){klass.max(:leo_id).to_i}

  before(:each) do
    create(:setting, key: :max_ids)
    count.times{create(klass.collection_name.to_s.singularize)}
  end

  it 'should store max_id correctly in settings' do
    klass.set_max_id
    s = Setting.where(key: :max_ids).first
    expect(s.read_attribute(klass.collection_name)).to eq max_id_from_model
  end
end