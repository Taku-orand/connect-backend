class RemoveLikeFromQuestion < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :like, :integer
  end
end
