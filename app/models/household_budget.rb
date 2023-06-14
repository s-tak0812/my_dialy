class HouseholdBudget < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :price
    validates :date
  end

  # priceカラムは数字のみ保存させる
  validates :price, numericality: { only_integer: true }

  enum title: { others: 0, income: 1, tax: 2, food_and_drink: 3, entertainment: 4, utility_costs: 5, medicals: 6, clothes: 7,  necessities: 8}

  # 今月の内容を取り出す
  scope :current_month, -> { where(date: Time.current.all_month) }
  # 先月の内容を取り出す
  scope :last_month, -> { where(date: Time.current.last_month.all_month) }

  # 支出のみ取り出す
  scope :spendings, -> { where(is_active: false)}
  # 収入のみ取り出す
  scope :incomes, -> { where(is_active: true)}

  # title別ソート機能
  scope :sort_by_title, ->(title) { order(price: :desc).where(title: title)}

  
  private
  
  # 一定期間から項目別で絞込をした際の項目の日本語表記
  def self.sort_title_ja(title)
    case title
    when "income"
      "収入"
    when "tax"
      "税金"
    when "food_and_drink"
      "飲食"
    when "entertainment"
      "趣味娯楽"
    when "utility_costs"
      "光熱費"
    when "medicals"
      "医療費"
    when "clothes"
      "衣服"
    when "necessities"
      "必需品"
    else
      "その他"
    end
  end

end
