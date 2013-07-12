shared_context 'protected controller' do
  before(:each) do
    session.clear
    expect(controller).to receive(:require_login)
  end
end