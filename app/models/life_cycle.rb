class LifeCycle < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :start_time
    validates :end_time
    validates :date
  end

  enum title: { その他: 0, 睡眠: 1, 仕事: 2, 娯楽: 3, 勉強: 4, 食事: 5, 家事: 6 }

  # validateに設定してエラーを出力させる
  validate :end_time_cannot_be_earlier_than_start_time

  validate :check_overlap


  private

  # 同じ日の既存のレコードと時間がかぶらないようにするためのメソッド
  def check_overlap
    overlapping_records = LifeCycle.where(customer_id: customer_id)
                                   .where(date: date)
                                   .where.not(id: id)
                                   .where("(start_time <= ? AND end_time >= ?) OR (start_time <= ? AND end_time >= ?)", start_time, start_time, end_time, end_time)
    if overlapping_records.exists?
      errors.add(:base, "登録済みの項目と時刻が重なっています")
    end
  end

  # end_timeがstart_timeよりも早い時間で保存されないようにするメソッド
  def end_time_cannot_be_earlier_than_start_time
    return unless start_time && self.end_time && (self.end_time <= start_time)
    errors.add(:end_time, "開始時刻が終了時刻より遅いです")
  end

end
