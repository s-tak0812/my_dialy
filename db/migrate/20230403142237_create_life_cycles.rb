class CreateLifeCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :life_cycles do |t|
      t.integer :customer_id, null: false
      t.integer :title, null: false, default: 0
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.timestamps
    end
  end
end
