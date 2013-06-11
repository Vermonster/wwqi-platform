class RemoveContributionRequest < ActiveRecord::Migration
  def up
    drop_table :contribution_requests
  end

  def down
    create_table :contribution_requests do
      t.string :accession_number
      t.string :type
      t.integer :creator_id

      t.timestamps
    end
  end
end
