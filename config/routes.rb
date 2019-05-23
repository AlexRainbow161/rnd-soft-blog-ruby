Rails.application.routes.draw do
  devise_for :users
  resources :news
  resources :user_profile do
    member do
      post :change_subscr_period
      post :change_user_name
      post :change_user_email
      post :upload_file
      get :subscribe
      post :unsubscribe
    end
  end
  root to: 'news#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
