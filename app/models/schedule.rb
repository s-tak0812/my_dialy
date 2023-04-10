class Schedule < ApplicationRecord
  belongs_to:customer

  with_options presence: true do
    validates :title
    validates :start_time
    validates :end_time
    validates :date
  end

  # validateに設定してエラーを出力させる
  validate :end_time_cannot_be_earlier_than_start_time



  private

  # end_timeがstart_timeよりも早い時間で保存されないようにするメソッド
  def end_time_cannot_be_earlier_than_start_time
    return unless start_time && self.end_time && (self.end_time <= start_time)
    errors.add(:end_time, "can't be earlier than start time")
  end

end
