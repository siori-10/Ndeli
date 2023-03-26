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
    resources :recipes do
      resource :favorites, only: [:create, :destroy]
      collection do
        get 'my_recipes'
      end
      resources :comments, only: [:create]

    end
    get "recipes_draft" => "recipes#draft"
    resources :materials, only: [:create, :destroy]
    resources :material_recipes, only: [:create, :destroy]
  end
  scope module: :public do
    get root to:"homes#top"
    get "home/about" => "homes#about",as:"about"
  end

  namespace :admin do
    resources :comments, only: [:index, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :categories, only: [:index, :edit, :create, :update, :destroy]
    resources :recipes, only: [:show, :edit, :update,:destroy]
    root to:"homes#top"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
