class EffectiveDate < ApplicationRecord
  belongs_to:customer, dependent: :destroy
  has_many:blogs
  has_many:household_budgets
  has_many:life_cycles
  has_many:schedules
end
