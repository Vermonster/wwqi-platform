class AddContributionFields < ActiveRecord::Migration
  def change
    add_column :contributions, :person_url, :string
  end
end
