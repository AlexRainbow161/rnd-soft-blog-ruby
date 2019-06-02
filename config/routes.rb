Rails.application.routes.draw do
  devise_for :users
  resources :news do
    member do
      post :add_comment
      post :delete_comment
    end
  end
  resources :user_profile do
    member do
      post :change_subscr_period
      post :change_user_name
      post :change_user_email
      post :upload_file
      get :subscribe
      post :unsubscribe
      get :subscribes
      get :user_settings
      get :posts
    end
  end
  root to: 'news#index'
  post 'user_profile/unsubscribe_all', to: "user_profile#unsubscribe_all"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
