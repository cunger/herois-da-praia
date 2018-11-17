Rails.application.routes.draw do
  root 'welcome#start'

  get 'info' => 'welcome#info'

  # Logging data

  resources :activities, only: [:index]

  resources :beachcleans, only: [:new, :show, :create, :destroy], param: :uuid do
    post :submit,  :controller => 'beachcleans', :action => 'submit'
    get  :summary, :controller => 'beachcleans', :action => 'summary'
    get  :sign,    :controller => 'beachcleans', :action => 'sign'
    post :sign,    :controller => 'beachcleans', :action => 'create_signature'
    get  :thanks,  :controller => 'beachcleans', :action => 'thanks'
  end

  resources :whalewatches, only: [:new, :show, :create, :destroy], param: :uuid do
    # TODO analogous to beachcleans
  end

  resources :fisheries, only: [:new, :show, :create, :destroy], param: :uuid do
    # TODO analogous to beachcleans
  end

  # Analytics

  # TODO
  # get  'analytics'       => 'analytics#start'
  # post 'analytics/query' => 'analytics#query'
end
