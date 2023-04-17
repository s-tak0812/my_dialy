class Schedule < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :start_time
    validates :end_time
  end

  # 今日のデータを取得
  scope :today_schedule, -> { where(start_time: Time.zone.now.all_day) }
  # 明日のデータを取得
  scope :tomorrow_schedule, -> { where(start_time: Time.zone.tomorrow.all_day)}

  validate :start_and_end_time_on_same_day
  validate :end_time_cannot_be_earlier_than_start_time

  private

  # end_timeがstart_timeよりも早い時間で保存されないようにするメソッド
  def end_time_cannot_be_earlier_than_start_time
    return unless start_time && self.end_time && (self.end_time <= start_time)
    errors.add(:end_time, "開始時刻が終了時刻より遅い、または同じです")
  end

  # start_timeとend_timeの日にちのずれを防止するメソッド
  def start_and_end_time_on_same_day
    if start_time.present? && end_time.present? && start_time.to_date != end_time.to_date
      errors.add(:end_time, "は開始日と同じ日付に設定してください")
    end
  end
end
