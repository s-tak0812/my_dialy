class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.text :content, null: false
      t.timestamps
    end
  end
end
