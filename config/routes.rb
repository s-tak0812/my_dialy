Rails.application.routes.draw do

  namespace :admin do
    # contacts
    resources :contacts, only:[:index, :edit]

    # customers
    resources :customers, only:[:index, :edit]

    get 'searches/search'

    # homes
    root to: 'homes#top'

  end


  scope module: :public do
    # contacts
    resources :contacts, only:[:new]

    # effective_dates
    resources :effective_dates, only:[:index, :show]

    # schedules
    resources :schedules, only:[:new, :edit]

    # life_cycles
    resources :life_cycles, only:[:new, :edit]

    # household_budgets
    resources :household_budgets, only:[:new, :edit]

    # blogs
    resources :blogs, only:[:new, :edit, :show]

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
  devise_for :customers

  # 管理者用
  devise_for :admin

end
