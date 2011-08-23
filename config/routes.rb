GopayExampleApp::Application.routes.draw do

  resources :orders do
    collection do
      get :notification
      get :success
      get :failed
    end
  end
  
  root :to => 'orders#index'

end
