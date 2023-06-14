class News < ApplicationRecord

  with_options presence: true do
    validates :title
    validates :content
  end

end
