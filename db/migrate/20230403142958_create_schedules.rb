class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :customer_id, null: false
      t.string :title, null: false
      t.text :content
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.date :date, null: false
      t.timestamps
    end
  end
end
