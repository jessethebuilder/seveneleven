Rails.application.routes.draw do
  resources :na_stores
  resources :intl_stores
  resources :store_lists, except: [:new, :create] do
    collection do
      post 'add_to_current'
      post 'remove_from_current'
    end
  end

  get 'users/sign_up', to: 'na_stores#index'
  post '/users(:format)', to: 'users#create'
  
  devise_for :users
  resources :users

  root to: 'na_stores#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
