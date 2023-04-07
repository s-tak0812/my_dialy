class Contact < ApplicationRecord
  belongs_to:customer, dependent: :destroy
end
