Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  resources :projects, except: [:index] do
    member do
      post 'send_invite'
    end

    resources :memberships, only: [:create]
    resources :tasks, only: [:create, :destroy] do
      member do
        patch 'update_user'
        patch 'update_status'
      end
    end
  end
end
