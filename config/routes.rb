Marozi::Application.routes.draw do
  root :to => "home#index"

  get '/members/me' => 'members#me', as: :my_membership
  get '/clubs/my_club' => 'clubs#my_club', as: :my_club
  get '/clubs/:id/members/:type' => 'clubs#members', as: :club_members
  get '/districts/my_district' => 'districts#my_district', as: :my_district
  get '/multiple_district/my_multiple_district' => 'multiple_districts#my_multiple_district', as: :my_multiple_district

  patch '/offices/:id' => 'offices#update', as: :office

  get '/login' => 'sessions#index', as: :login_screen
  post '/sessions/new' => 'sessions#create', as: :login
  get '/logout' => 'sessions#destroy', as: :logout

  # statistics
  get '/clubs/my_club/statistics' => 'clubs#my_club_statistics', as: :my_club_statistics
  get '/clubs/:id/statistics/' => 'clubs#statistics', as: :club_statistics

  # statistics api
  scope :api do
    get '/statistics/:type/:id/gender_ratio' => 'statistics#gender_ratio'
  end

  resources :members
  resources :clubs
  resources :districts
  resources :multiple_districts
  resources :committees
end