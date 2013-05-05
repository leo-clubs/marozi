shared_examples_for 'max_ids' do | klass, count |

  let(:max_id_setting){Setting.where(key: :max_ids)}
  let(:max_id_from_model){klass.max(:oid).to_i}
  let(:max_id_from_setting){max_id_setting.first.read_attribute(klass.collection_name)}
  let(:factory_name){klass.collection.name.singularize}

  before(:each) do
    count.times{create(factory_name)}
    expect(max_id_setting.count).to be 1
  end

  it 'should store max_id correctly in settings' do
    klass.set_max_id
    expect(max_id_from_setting).to eq max_id_from_model
  end

  it 'should not touch max_ids for building models' do
    expect{build(factory_name)}.not_to change{max_id_from_setting}
  end

  it 'should not touch max_ids for changing models' do
    create(factory_name)
    expect{klass.first.update_attributes(year: '1999-2000')}.not_to change{max_id_from_setting}
  end

  it 'should change max_ids for creating models' do
    max_id_setting.set klass.collection_name => 1
    expect{create(factory_name, oid: nil)}.to change{max_id_setting.first.read_attribute(klass.collection_name)}.by(1)
  end
end