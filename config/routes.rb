RedmineApp::Application.routes.draw do

  resources :uc_periods do
    collection do
      get 'under_construction'
    end
  end

end