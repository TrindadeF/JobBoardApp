Rails.application.routes.draw do
  get 'applications/new'
  get 'applications/create'
  root 'home#index'
  get 'all_jobs', to: 'jobs#all_jobs', as: 'all_jobs'
  get 'my_applications', to: 'jobs#my_applications', as: 'my_applications'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  authenticated :user, ->(u) { u.user_type == 'academic' } do
    get 'academic_dashboard', to: 'academics#dashboard', as: :academic_root
  end

  authenticated :user, ->(u) { u.user_type == 'recruiter' } do
    get 'recruiter_dashboard', to: 'recruiters#dashboard', as: :recruiter_root
  end

    
  resources :jobs do
    resources :applications, only: [:new, :create]
  end

end
