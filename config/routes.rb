GoalApp::Application.routes.draw do
  root :to => "sessions#new"
  resources :users do
    resources :goals, :only => [:create]
  end
  resources :goals, :except => [:create]
  resource :session
end
