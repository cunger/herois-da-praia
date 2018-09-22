Rails.application.routes.draw do
  root 'welcome#start'

  # get 'about' => 'welcome#about'
  # get 'help'  => 'welcome#help'

  # Logging data

  resources :activities, only: [:index]

  resources :beachcleans, only: [:new, :show, :create, :update, :destroy], param: :uuid do
    get  :submit, on: :member
    post :verify, on: :member
    get  :thanks, on: :member
  end

  resources :whalewatches, only: [:new, :show, :create, :update, :destroy], param: :uuid do
    get  :submit, on: :member
    post :verify, on: :member
    get  :thanks, on: :member
  end

  # Analytics

  get  'analytics'       => 'analytics#start'
  post 'analytics/query' => 'analytics#query'
end
