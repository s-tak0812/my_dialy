class Blog < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :body
    validates :date
  end

  has_one_attached:image

  # 同じ日にすでに投稿されていればエラーを出力する
  validate :check_blogs


  private

  # 同じcustomerが同じ日にちにblogを投稿しているかを確認するメソッド
  def check_blogs
    overlapping_blog = Blog.where(customer_id: customer_id)
                           .where(date: date)
                           .where.not(id: id)

    if overlapping_blog.exists?
      errors.add(:blog, "この日は投稿済みです")
    end
  end

end
