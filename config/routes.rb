WwqiPlatform::Application.routes.draw do
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

  resources :items do
    get 'search', on: :collection
  end
  
  root :to => 'site#index'
end
