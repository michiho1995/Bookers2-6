Rails.application.routes.draw do
  # get 'search/index'
  # get 'search/search'
  get 'search' => 'seaches#search'
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'home#index'
  get 'home/about'

  resources :books, only: [:new, :create, :index, :show, :edit] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: %i[create edit update destroy]
  end

  resources :users, only: [:show, :edit, :update, :index]
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

end
