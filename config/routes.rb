Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

devise_scope :customer do
  post 'customers/guest_saign_in', to: 'public/sessions#new_guest'
end

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
#devise_for :customers



  scope module: :public do
   resources :favorites, only: [:index]
  end
  scope module: :public do
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
  end
  scope module: :public do
    resources :recipes, only: [:new, :index, :edit, :show ]

  end
  scope module: :public do
    get root to:"homes#top"
    get "home/about" => "homes#about",as:"about"
  end

  namespace :admin do
    resources :comments, only: [:index, :destroy]
  end
  namespace :admin do
    resources :customers, only: [:show, :edit, :update]
  end
  namespace :admin do
    resources :categories, only: [:edit, :create, :update]
  end
  namespace :admin do
    resources :recipes, only: [:show, :edit, :update]
  end
  namespace :admin do
    root to:"homes#top"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
