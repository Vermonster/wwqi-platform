WwqiPlatform::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "autocomplete/users"

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  ActiveAdmin.routes(self)

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
  end
  
  resources :corrections
  
  match "/me" => "profile#show", :as => 'my_profile'
  match "/me/notifications" => "profile#notifications", :as => 'my_notifications'

  root :to => 'site#index'
end
