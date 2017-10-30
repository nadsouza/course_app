Rails.application.routes.draw do
  # User handling
  get    'register', to: 'users#new'
  get    'login',    to: 'sessions#new'
  post   'login',    to: 'sessions#create'
  delete 'logout',   to: 'sessions#destroy'

  post   'courses/:id/upvote',     to: 'upvotes#new', as: 'upvote'
  post   'courses/:id/downvote',  to: 'downvotes#new', as: 'downvote'

  # Resourceful routes
  # Follows the RESTful API
  resources :categories
  resources :locations
  resources :courses
  resources :users, except: [:new]

  delete 'courses/:id/votes', to: 'courses#reset_votes', as: 'reset_votes'

  # Root home template
  root 'home#index'

  match '/404', :to => 'errors#not_found', :via => :all
  match '/500', :to => 'errors#server_error', :via => :all
end
