class AddImageDataToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :image_data, :text
  end
end
