shared_context 'protected controller' do
  before(:each) do
    session.clear
    controller.should_receive :require_login
  end
end