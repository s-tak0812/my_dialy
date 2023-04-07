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

  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :email
  end

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # セキュリティ向上
  # is_deletedカラムがfalseのcustomerのみ認証する
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
