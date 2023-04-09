class Schedule < ApplicationRecord
  belongs_to:customer, dependent: :destroy
end
