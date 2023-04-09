class Blog < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :body
    validates :date
  end

  has_one_attached:image

end
