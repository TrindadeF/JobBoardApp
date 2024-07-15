Rails.application.routes.draw do

  root 'home#index'
  get 'profiles/show'
  get 'applications/new'
  get 'applications/create'
  get 'all_jobs', to: 'jobs#all_jobs', as: 'all_jobs'
  get 'my_applications', to: 'jobs#my_applications', as: 'my_applications'
  get '/perfil', to: 'profiles#show', as: :perfil

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  authenticated :user, ->(u) { u.user_type == 'academic' } do
    get 'academic_dashboard', to: 'academics#dashboard', as: :academic_root
  end
  

  authenticated :user, ->(u) { u.user_type == 'recruiter' } do
    get 'recruiter_dashboard', to: 'recruiters#dashboard', as: :recruiter_root
      resources :jobs do
        resources :applications, only: [:index, :new, :create] do
          member do
            patch :update_status
          end
        end
      end
  end

  resources :jobs do
    get 'show_applications', on: :member
    resources :applications
  end

  resources :recruiters do
    member do
      get 'show_applications'
    end
  end

  namespace :recruiters do
      get 'jobs/:id/applications', to: 'dashboard#show_applications', as: 'show_applications'
  end


end
