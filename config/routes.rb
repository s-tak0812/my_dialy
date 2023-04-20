Rails.application.routes.draw do

  namespace :admin do
    # contacts
    resources :contacts, only:[:index, :edit, :update, :destroy]

    # customers
    resources :customers, only:[:index, :edit, :update, :destroy]

    get 'searches/search'

    # homes
    root to: 'contacts#index'

  end


  scope module: :public do
    # contacts
    resources :contacts, only:[:index, :show, :create]

    # schedules
    resources :schedules, only:[:index, :create, :update, :destroy]
    # バリデーションでrenderされた後、リロードした時に
    # ルーティングエラーが出現するため、個別設定する
    get 'schedules/:id' => 'schedules#edit', as: 'edit_schedule'

    # life_cycles
    # 日付の絞り込み検索
    get 'life_cycles/date_show/:date' => 'life_cycles#date_show', as: 'life_cycles_date_show'
    resources :life_cycles, only:[:index, :new, :create, :update, :destroy]
    # render後のエラー回避
    get 'life_cycles/:id' => 'life_cycles#edit', as: 'edit_life_cycle'

    # household_budgets
    # 期間の絞り込み検索
    get 'household_budgets/day_to_day' => 'household_budgets#day_to_day', as: 'household_budgets_day_to_day'
    # 期間の絞り込み検索
    get 'household_budgets/days_sort' => 'household_budgets#days_sort', as: 'household_budgets_days_sort'
    # 日付の絞り込み検索
    get 'household_budgets/date_show/:date' => 'household_budgets#date_show', as: 'household_budgets_date_show'
    resources :household_budgets, only:[:index, :create, :update, :destroy]
    # render後のエラー回避
    get 'household_budgets/:id' => 'household_budgets#edit', as: 'edit_household_budget'

    # blogs
    # Blogのタイトル検索
    get 'blogs/search' => 'blogs#search', as: 'blogs_search'
    resources :blogs

    # customers
    get 'customers/mypage' => 'customers#show'
    get 'customers/information' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    # 退会確認画面
    get 'customers/soft_delete' => 'customers#soft_delete'
    # 退会機能
    patch 'customers/drop' => 'customers#drop'

    # homes
    root to: 'homes#top'
    get 'about' => 'homes#about'

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :customer do
    # 会員登録失敗のリダイレクトのエラーを防ぐ
    get '/customers', to: 'public/registrations#new'
  end

end
