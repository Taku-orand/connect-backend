class RemoveLikeFromAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_column :answers, :like, :integer
  end
end
