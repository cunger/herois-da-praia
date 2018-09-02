Rails.application.routes.draw do
  root 'welcome#start'

  get 'beachclean' => 'welcome#beachclean'
  get 'whalewatch' => 'welcome#whalewatch'

  resources :scopes, only: [:new, :create] do
    # Routes for logging beach clean data.
    get    'items', to: 'items#index',   on: :member
    patch  'items', to: 'items#update',  on: :member
    delete 'items', to: 'items#destroy', on: :member

    # Routes for logging whale watching data.
    resources :observations
  end

  # Routes for inspecting beach clean data.
  get 'beachclean/analytics/start' => 'analytics#start'
  get 'whalewatch/analytics/start' => 'analytics#start'
end
