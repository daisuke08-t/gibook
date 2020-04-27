class AddThumbnailToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :thumbnail, :string
  end
end
