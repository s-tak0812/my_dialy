Rails.application.routes.draw do

  namespace :admin do
    get 'contacts/index'
    get 'contacts/edit'

    get 'homes/top'

    get 'customers/index'
    get 'customers/edit'

    get 'searches/search'

  end




  namespace :public do
    get 'contacts/new'

    get 'effective_dates/index'
    get 'effective_dates/show'

    get 'schedules/new'
    get 'schedules/edit'

    get 'life_cycles/new'
    get 'life_cycles/edit'

    get 'household_budgets/new'
    get 'household_budgets/edit'

    get 'blogs/new'
    get 'blogs/edit'
    get 'blogs/show'

    get 'customers/show'
    get 'customers/edit'

    get 'homes/top'
    get 'homes/about'

    get 'searches/search'

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 顧客用
  devise_for :customers

  # 管理者用
  devise_for :admin

end
