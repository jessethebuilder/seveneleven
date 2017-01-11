Rails.application.routes.draw do
  resources :na_stores
  resources :intl_stores
  resources :store_lists do
    collection do
      post 'add_to_current'
      post 'remove_from_current'
    end
  end
  devise_for :users
  resources :users, except: [:show]

  root to: 'na_stores#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
