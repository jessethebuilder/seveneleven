Rails.application.routes.draw do
  resources :na_stores do
    collection do
      get 'edit_all'
    end

    member do
      delete 'delete_fz_image'
    end
  end

  resources :intl_stores
  resources :playlists, except: [:new, :create] do
    member do
      get 'go_live'
    end

    collection do
      post 'add_to_current'
      post 'remove_from_current'
    end
  end

  get 'users/sign_up', to: 'playlists#index'
  #force the following route through users, beause it is protected by auth
  post '/users(:format)', to: 'users#create'

  devise_for :users
  resources :users

  resources :store_searches, only: [:show]

  root to: 'playlists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
