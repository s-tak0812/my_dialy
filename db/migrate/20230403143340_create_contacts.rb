class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :customer_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.text :reply
      t.timestamps
    end
  end
end
