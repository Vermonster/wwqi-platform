WwqiPlatform::Application.routes.draw do
  #devise_for :admin_users, ActiveAdmin::Devise.config
  get "autocomplete/users"

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users do
    resources :notifications
  end

  resources :posts, controller: :threads, path: :threads do
    resources :comments
    resources :followings
  end
  
  resources :researches do
    resources :comments
    resources :followings
  end

  resources :contributions do
    resources :comments
    resources :followings
  end
  
  resources :corrections

  # resources :transcriptions, :translations, :biographies, controller: :contributions

  match "/admin" => "admin/dashboard#index"
  match "/me" => "profile#show", :as => 'my_profile'
  match "/me/notifications" => "profile#notifications", :as => 'my_notifications'

  root :to => 'site#index'
  
  ActiveAdmin.routes(self)
end
