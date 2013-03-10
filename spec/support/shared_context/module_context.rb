shared_context 'module' do | module_to_test |
  class DummyClass
  end

  let(:dummy_class) { Class.new(DummyClass) }

  before(:each) do
    dummy_class.extend(module_to_test)
  end
end