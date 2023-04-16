class Schedule < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :start_time
    validates :end_time
  end

  # mypageに今日と明日の予定を表示させる
  scope :today_schedule, -> { where(start_time: Time.zone.now.all_day) }
  scope :tomorrow_schedule, -> { where(start_time: Time.zone.tomorrow.all_day)}



  # validateに設定してエラーを出力させる
  validate :end_time_cannot_be_earlier_than_start_time

  private

  # end_timeがstart_timeよりも早い時間で保存されないようにするメソッド
  def end_time_cannot_be_earlier_than_start_time
    return unless start_time && self.end_time && (self.end_time <= start_time)
    errors.add(:end_time, "開始時刻が終了時刻より遅い、または同じです")
  end

end
