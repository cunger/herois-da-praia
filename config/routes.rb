Rails.application.routes.draw do
  root 'welcome#start'

  get 'beachclean' => 'welcome#beachclean'
  get 'whalewatch' => 'welcome#whalewatch'

  # Routes for logging data.

  resources :scopes do
    resources :observations
    resources :items do
      post 'plus',  to: 'items#plus', on: :member
      post 'minus', to: 'items#minus', on: :member
    end

    post 'submit', on: :member
    post 'reset', on: :member
  end

  # Routes for inspecting data.

  get 'analytics/start' => 'analytics#start'
end
