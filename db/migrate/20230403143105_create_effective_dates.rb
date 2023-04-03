class CreateEffectiveDates < ActiveRecord::Migration[6.1]
  def change
    create_table :effective_dates do |t|
      t.integer :customer_id, null: false
      t.integer :blog_id
      t.integer :household_budget_id
      t.integer :life_cycle_id
      t.integer :schedule_id
      t.date :active_date, null: false
      t.timestamps
    end
  end
end
