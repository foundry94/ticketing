Ticketing::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :venues
  resources :events

  namespace :company_admin do
    resources :venues, :except => [:show]
    resources :events, :except => [:show]
  end

end
