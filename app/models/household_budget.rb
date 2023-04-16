class HouseholdBudget < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :price
    validates :date
  end

  validates :price, numericality: { only_integer: true }

  enum title: { others: 0, tax: 1, food_and_drink: 2, entertainment: 3, utility_costs: 4, income: 5 }

  # 今月の内容を取り出す
  scope :current_month, -> { where(date: Time.current.all_month) }
  # 今月の内容を取り出す
  scope :last_month, -> { where(date: Time.current.last_month.all_month) }

  # 支出のみ取り出す
  scope :spendings, -> { where(is_active: false)}
  # 収入のみ取り出す
  scope :incomes, -> { where(is_active: true)}


  scope :tax_order, -> { order(price: :desc).where(title: :tax) }
  scope :food_and_drink_order, -> { order(price: :desc).where(title: :food_and_drink) }
  scope :entertainment_order, -> { order(price: :desc).where(title: :entertainment) }
  scope :utility_costs_order, -> { order(price: :desc).where(title: :utility_costs) }
  scope :income_order, -> { order(price: :desc).where(title: :income) }
  scope :others_order, -> { order(price: :desc).where(title: :others) }

end
