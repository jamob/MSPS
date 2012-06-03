class RemoveVisibleFromPost < ActiveRecord::Migration
  def up
    remove_column :posts, :visible
  end

  def down
  end
end
