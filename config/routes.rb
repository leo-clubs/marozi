Marozi::Application.routes.draw do
  root :to => "home#index"

  resources :members
  resources :clubs
  resources :districts
  resources :multiple_districts
end
