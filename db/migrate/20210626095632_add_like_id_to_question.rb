class AddLikeIdToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :like_id, :integer
  end
end
