class ChangeDataContentToRequests < ActiveRecord::Migration[6.1]
  def change
    change_column :requests, :content, :text
  end
end
