class ChangeItemAccessionNo < ActiveRecord::Migration
  def change
    change_column :items, :accession_no, :string
  end
end
