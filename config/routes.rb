Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'user/follow' => 'users#follow'
  get 'user/follower' => 'users#follower'
  get 'search' => 'searches#search'

  resources :users, only: [:create, :show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

end