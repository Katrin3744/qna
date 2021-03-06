Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "questions#index"
  resources :questions do
    resources :answers, except: [:index, :show, :new], shallow: true
  end
end
