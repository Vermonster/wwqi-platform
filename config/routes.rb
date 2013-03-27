WwqiPlatform::Application.routes.draw do
  get "autocomplete/users"

  devise_for :users

  resources :posts, path: "threads" do
    resources :comments
  end
  
  resources :researches do
    resources :comments
  end

  resources :contributions do
    resources :comments
  end
  
  match "/me" => "profile#show"

  root :to => 'site#index'
end
