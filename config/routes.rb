WwqiPlatform::Application.routes.draw do
  get "autocomplete/users"

  devise_for :users

  resources :users do
    resources :notifications
  end

  resources :posts, controller: :threads, path: :threads do
    resources :comments
  end
  
  resources :researches do
    resources :comments
  end

  resources :contributions do
    resources :comments
  end
  
  resources :corrections
  
  match "/me" => "profile#show"

  root :to => 'site#index'
end
