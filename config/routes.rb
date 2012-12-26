Marozi::Application.routes.draw do
  root :to => "home#index"

  get '/members/me' => 'members#me', :as => :my_membership
  get '/clubs/my_club' => 'clubs#my_club', :as => :my_club
  get '/districts/my_district' => 'districts#my_district', :as => :my_district
  get '/multiple_district/my_multiple_district' => 'multiple_districts#my_multiple_district', :as => :my_multiple_district

  resources :members
  resources :clubs
  resources :districts
  resources :multiple_districts
end