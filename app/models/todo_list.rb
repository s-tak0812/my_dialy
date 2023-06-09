class TodoList < ApplicationRecord
  belongs_to :customer
  has_many :todo_contents, dependent: :destroy

  validates :title, presence: true, length:{maximum:30}
end
