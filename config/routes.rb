Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  #mount Rich::Engine => '/rich', :as => 'rich'
  devise_for :admin
  #devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :products, only: [:index]
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  root to: "products#index"
end
