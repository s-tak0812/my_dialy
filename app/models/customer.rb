class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many:blogs, dependent: :destroy
  has_many:household_budgets, dependent: :destroy
  has_many:life_cycles, dependent: :destroy
  has_many:schedules, dependent: :destroy
  has_many:contacts, dependent: :destroy
  has_many:todo_lists, dependent: :destroy
  has_many:todo_contents, dependent: :destroy

  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :email
  end

  has_one_attached :profile_image

  # customerのフルネーム
  def full_name
    self.last_name + " " + self.first_name
  end

  # profile_imageがない場合'no_image'を出力する
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # セキュリティ向上
  # is_deleted: falseのcustomerのみ認証する
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  # 検索機能
  def self.search_for(content)
    Customer.where("first_name LIKE ? OR last_name LIKE ?", '%'+content+'%', '%'+content+'%')
  end

end
