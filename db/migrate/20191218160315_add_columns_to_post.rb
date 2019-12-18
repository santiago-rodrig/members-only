class AddColumnsToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :title, :string, unique: true
    add_reference :posts, :user, foreign_key: true
    add_column :posts, :body, :text
  end
end
