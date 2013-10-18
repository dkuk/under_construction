RedmineApp::Application.routes.draw do

  resources :uc_periods do
    collection do
      get 'under_construction'
      get 'update_msg_head'
    end
  end

end