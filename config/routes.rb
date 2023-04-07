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

    # effective_dates
    resources :effective_dates, only:[:index, :show]

    # schedules
    resources :schedules, only:[:new, :create, :edit, :update, :destroy]

    # life_cycles
    resources :life_cycles, only:[:new, :create, :edit, :update, :destroy]

    # household_budgets
    resources :household_budgets, only:[:new, :create, :edit, :update, :destroy]

    # blogs
    resources :blogs, except:[:index]

    # customers
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/soft_delete' => 'customers#soft_delete'
    patch 'customers/drop' => 'customers#drop'

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
