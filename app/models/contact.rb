class Contact < ApplicationRecord
  belongs_to:customer

  validates :title, presence: true
  validates :body, presence: true
end
