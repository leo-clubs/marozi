Marozi::Application.routes.draw do
  authenticated :member do
    root :to => 'home#index'
  end

  root :to => "home#index"

  resources :members
  resources :clubs
  resources :districts
  resources :multiple_districts
end
