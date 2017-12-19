class CreateQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :quotes do |t|
      t.text :content, null: false
      t.string :attribution, null: false
      t.integer :topic_id

      t.timestamps
    end

    create_table :topics do |t|
      t.string :title, null: false
      t.integer :category_id

      t.timestamps
    end

    create_table :categories do |t|
      t.string :title, null: false
    end

    add_index :quotes, :topic_id
    add_index :topics, :category_id
  end
end
