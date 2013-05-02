class ChangeContributionItemId < ActiveRecord::Migration

  def change
    change_column :contributions, :item_id, :string
  end
  
end
