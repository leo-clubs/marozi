Marozi::Application.routes.draw do
  root :to => "home#index"

  get '/members/me' => 'members#me', :as => :my_membership
  get '/clubs/my_club' => 'clubs#my_club', :as => :my_club
  get '/clubs/my_district' => 'clubs#my_district', :as => :my_district
  get '/clubs/my_multiple_district' => 'clubs#my_multiple_district', :as => :my_multiple_district

  resources :members
  resources :clubs
  resources :districts
  resources :multiple_districts
end