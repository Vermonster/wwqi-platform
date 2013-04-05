class AddCommentsCountToContributions < ActiveRecord::Migration
  def change
    change_table :contributions do |t|
      t.integer :comments_count, default: 0
    end
  end
end
