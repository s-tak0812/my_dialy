class CreateHouseholdBudgets < ActiveRecord::Migration[6.1]
  def change
    create_table :household_budgets do |t|

      t.integer :customer_id, null: false
      t.integer :title, null: false, default: 0
      t.integer :price, null: false
      t.boolean :is_active, default: false, null: false
      t.date :date, null: false
      t.timestamps
    end
  end
end
