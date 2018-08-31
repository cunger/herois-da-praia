Rails.application.routes.draw do
  root 'welcome#start'

  get 'beachclean' => 'welcome#beachclean'
  get 'whalewatch' => 'welcome#whalewatch'

  resources :scopes, only: [:new, :create] do
    # Routes for logging beach clean data.
    get  'items',       to: 'items#index', on: :member
    post 'items/plus',  to: 'items#plus',  on: :member
    post 'items/minus', to: 'items#minus', on: :member

    post 'items/submit', on: :member
    post 'items/reset',  on: :member

    # Routes for logging whale watching data.
    resources :observations do
      post 'submit', on: :member
      post 'reset',  on: :member
    end
  end

  # Routes for inspecting beach clean data.
  get 'beachclean/analytics/start' => 'analytics#start'
  get 'whalewatch/analytics/start' => 'analytics#start'
end
