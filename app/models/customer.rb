class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many:blogs
  has_many:household_budgets
  has_many:life_cycles
  has_many:schedules
  has_many:effective_dates
  has_many:contacts
end
