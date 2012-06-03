class AddImportantToPost < ActiveRecord::Migration
  def change
    add_column :posts, :important, :boolean
  end
end
