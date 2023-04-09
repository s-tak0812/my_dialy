class HouseholdBudget < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :price
    validates :date
  end

  enum title: { others: 0, tax: 1, food_drink: 2, entertainment: 3, utility_costs: 4, income: 5 }

end
