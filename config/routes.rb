Rails.application.routes.draw do
  resources :intl_stores
  resources :na_stores

  root to: 'na_stores#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
