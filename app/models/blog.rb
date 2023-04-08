class Blog < ApplicationRecord
  belongs_to:customer, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :body
  end

  has_one_attached:image

end
