Rails.application.routes.draw do
  namespace :admin do
    get 'contacts/index'
    get 'contacts/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/edit'
  end
  namespace :public do
    get 'contacts/new'
  end
  namespace :public do
    get 'effective_dates/index'
    get 'effective_dates/show'
  end
  namespace :public do
    get 'schedules/new'
    get 'schedules/edit'
  end
  namespace :public do
    get 'life_cycles/new'
    get 'life_cycles/edit'
  end
  namespace :public do
    get 'household_budgets/new'
    get 'household_budgets/edit'
  end
  namespace :public do
    get 'blogs/new'
    get 'blogs/edit'
    get 'blogs/show'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
# 顧客用
devise_for :customers

# 管理者用
devise_for :admin

end
