class LifeCycle < ApplicationRecord
  belongs_to:customer, dependent: :destroy
  belongs_to:effective_date
end