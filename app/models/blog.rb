class Blog < ApplicationRecord
  belongs_to:customer, dependent: :destroy
  belongs_to:effective_date

  with_options presence: true do
    validates :customer_id
    validates :title
    validates :body
  end

  has_one_attached:image

end
