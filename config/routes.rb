Rails.application.routes.draw do
  root "home#index"
  get "/about" => "home#about"

  resources :users
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :passwordresets, only: [:new, :create, :edit, :update]
  resources :projects do
    resources :tasks
    post "/tasks/:id" => "tasks#mark", as: :mark
    resources :discussions do
      resources :comments
    end#, shallow: true
  end

end
