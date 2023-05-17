class CreateTodoContents < ActiveRecord::Migration[6.1]
  def change
    create_table :todo_contents do |t|
      t.integer :customer_id, null: false
      t.integer :todo_list_id, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
