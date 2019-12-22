Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :posts, only: :new do
    post 'renew', to: 'posts#create', on: :collection
    get 'renew', to: 'posts#renew', on: :collection
  end

  root 'posts#index'

  resources :users, except: :destroy do
    get :posts, on: :member
    get :change_password, on: :member
    post :update_password, on: :member
    get :update_password, to: 'users#change_password', on: :member
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
