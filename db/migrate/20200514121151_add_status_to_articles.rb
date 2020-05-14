class AddStatusToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :status, :boolean, default: false
    add_index :articles, :status
  end
end
