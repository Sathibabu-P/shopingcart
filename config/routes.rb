Rails.application.routes.draw do
  devise_for :users
  resources :checkouts, only: [:index]
  mount Rich::Engine => '/rich', :as => 'rich'
  #mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdminImport::Engine => '/rails_admin_import', :as => 'rails_admin_import'
  
  devise_for :admin,
  :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  #devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :products, only: [:index]
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  root to: "products#index"
  resources :paypals, only: [:index,:create]
end
