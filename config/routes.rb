RedmineApp::Application.routes.draw do

  match 'uc_periods/:id/preview', :controller => 'uc_periods', :action => 'preview', :via => [:get, :post, :put]

  resources :uc_periods do
    collection do
      get 'under_construction'
      get 'update_msg_head'
    end
  end

  resources :uc_browser_restrictions do
    collection do
      get 'wrong_browser'
    end
  end

end