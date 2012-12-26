Marozi::Application.routes.draw do
  root :to => "home#index"

  resources :members do
    collection do
      get 'me'
    end

  end
  resources :clubs
  resources :districts
  resources :multiple_districts
end