class AddAuthorToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :author, :string
  end
end
