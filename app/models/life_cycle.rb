class LifeCycle < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :start_time
    validates :end_time
  end

  enum title: { その他: 0, 睡眠: 1, 仕事: 2, 娯楽: 3, 勉強: 4, 食事: 5, 家事: 6 }

  validate :end_time_cannot_be_earlier_than_start_time
  validate :start_and_end_time_on_same_day
  validate :check_overlap


  private

  # 同じ日の既存のレコードと時間がかぶらないようにするためのメソッド
  def check_overlap
    if start_time.present? && end_time.present?
      overlapping_records = LifeCycle.where(start_time: start_time.to_date.all_day)
                                     .where(customer_id: customer_id)
                                     .where.not(id: id)
                                     .where("(start_time <= ? AND end_time >= ?) OR (start_time <= ? AND end_time >= ?) OR (start_time >= ? AND end_time <= ?)", start_time, start_time, end_time, end_time, start_time, end_time)
      if overlapping_records.exists?
        errors.add(:base, "登録済みの項目と時刻が重なっています")
      end
    end
  end

  # end_timeがstart_timeよりも早い時間で保存されないようにするメソッド
  def end_time_cannot_be_earlier_than_start_time
    return unless start_time && self.end_time && (self.end_time <= start_time)
    errors.add(:end_time, "開始時刻が終了時刻より遅いです")
  end

  # start_timeとend_timeの日にちのずれを防止するメソッド
  def start_and_end_time_on_same_day
    if start_time.present? && end_time.present? && start_time.to_date != end_time.to_date
      errors.add(:end_time, "は開始日と同じ日付に設定してください")
    end
  end

end
