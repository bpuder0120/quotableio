Pollathon::Application.routes.draw do

  resources :users, except: [:destroy, :index, :show] do
    member do
      post 'disable'
    end
  end

  resource :session, only: [:new, :create, :destroy]

  root :to => "users#new" 

  post 'callback' => 'twilio#callback'

end
