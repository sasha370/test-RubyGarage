Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :projects do
    resources :tasks do
      put :sort
    end
  end

end


