Rails.application.routes.draw do

  namespace :admin do
    # contacts
    resources :contacts, only:[:index, :edit, :update]

    # customers
    resources :customers, only:[:index, :edit, :update, :destroy]

    get 'searches/search'

    # homes
    root to: 'homes#top'

  end


  scope module: :public do
    # contacts
    resources :contacts, only:[:new, :create]

    # schedules
    resources :schedules, only:[:index, :create, :edit, :update, :destroy]

    # life_cycles
    get 'life_cycles/date_show/:date' => 'life_cycles#date_show', as: 'life_cycles_date_show'
    resources :life_cycles, only:[:index, :new, :create, :edit, :update, :destroy]

    # household_budgets
    get 'household_budgets/date_show/:date' => 'household_budgets#date_show', as: 'household_budgets_date_show'
    resources :household_budgets, only:[:index, :create, :edit, :update, :destroy]

    # blogs
    get 'blogs/search' => 'blogs#search', as: 'blogs_search'
    resources :blogs

    # customers
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/soft_delete' => 'customers#soft_delete'
    patch 'customers/drop' => 'customers#drop'
    get 'customers/day_link' => 'customers#day_link'
    get 'customers/memory' => 'customers#memory'

    # homes
    root to: 'homes#top'
    get 'about' => 'homes#about'

    get 'searches/search'

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 顧客用
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: "public/passwords"
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

end
