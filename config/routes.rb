Marozi::Application.routes.draw do
  authenticated :member do
    root :to => 'home#index'
  end

  root :to => "home#index"

  resources :clubs do
    resources :members
  end
end
