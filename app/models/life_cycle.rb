class LifeCycle < ApplicationRecord
  belongs_to:customer, dependent: :destroy
end
