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

  resources :notifications, only: [:index, :destroy]

  resources :locals, only: [:create, :destroy]

  get 'home/about' => 'homes#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
