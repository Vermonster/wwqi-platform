class CreateContributionRequests < ActiveRecord::Migration
  def change
    create_table :contribution_requests do |t|
      t.string :accession_number
      t.string :type
      t.integer :creator_id

      t.timestamps
    end
  end
end
