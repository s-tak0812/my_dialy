class HouseholdBudget < ApplicationRecord
  belongs_to:customer, dependent: :destroy
end
