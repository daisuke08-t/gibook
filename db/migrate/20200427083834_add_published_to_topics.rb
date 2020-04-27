class AddPublishedToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :published, :string
  end
end
