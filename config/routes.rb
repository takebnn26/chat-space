Rails.application.routes.draw do

  devise_for :users
  root 'groups#index'
  resources :groups, except: [:index, :delete] do
    collection do
      get 'search'
    end
    resources :messages, only: [:index, :create]
  end
  resources :users,    only: [:edit, :update]

end
