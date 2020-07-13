Rails.application.routes.draw do
  get 'contacts/new'
  post 'contacts/create'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }



  resources :users
  get 'users/:id/leave' => 'users#leave', as: 'users_leave'
  get 'users/:id/signup2' => 'users#signup2', as: 'users_signup2'

  resources :posts do

    resources :likes, only: [:create, :destroy]

    resources :comments, only: [:create, :destroy]

    resources :bookmarks, only: [:create, :destroy]
  end
  get '/' => 'posts#index', as: 'root'
  get  'searched' => 'searches#search',  as: 'search'

  resources :notifications, only: :index
  resources :notifications do
  collection do
    delete 'destroy_all'
  end
end

  resources :locals, only: [:create, :destroy]
  # ゲストログイン用
  post '/homes/guest_sign_in', to: 'homes#new_guest'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  get 'home/about' => 'homes#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
