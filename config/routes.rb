Rails.application.routes.draw do

  get 'user_data/index'

  devise_for :users
  root to: "users#index"

  resources :helps
  resources :medical_centers
  resources :medical_tests do
    collection { post :import }
    collection { post :import_results }
  end

  resources :prescriptions

  resources :medications
  resources :histories do
    collection {
      post :search, to:'histories#index'
      get  :search, to:'histories#index'
    }
  end

  resources :issues do
    collection {
      post :search, to:'histories#index'
      get  :search, to:'histories#index'
    }
  end

  resources :professionals

  resources :users
  resources :specialities   do
    collection { post :import }
  end
  resources :analysis_results
  resources :analytical_groups  do
    collection { post :import }
  end
  resources :analytical_subgroups
  resources :analytical_items

  resources :documents, only: [:destroy]
  resources :images, only: [:destroy]
  resources :direct_uploads, only: [:create]
  delete "direct_uploads/destroy", to: "direct_uploads#destroy", as: :direct_upload_destroy

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
