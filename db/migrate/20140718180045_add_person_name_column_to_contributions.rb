class AddPersonNameColumnToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :person_name, :string
  end
end
