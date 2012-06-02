class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :visible
      t.string :date

      t.timestamps
    end
  end
end
