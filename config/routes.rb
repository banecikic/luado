Rails.application.routes.draw do
  resources :workers
  resources :phases
  devise_for :users
  resources :projects
  root 'home#index'
  post "/phases/:id" => "phases#pay_phase"
  get "/choose_worker/:id" => "phases#choose_worker", as: :choose_worker
end
