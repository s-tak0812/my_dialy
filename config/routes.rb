Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
# 顧客用
devise_for :customers

# 管理者用
devise_for :admin

end
