class AddTeamToPeople < ActiveRecord::Migration
  def change
    add_column :people, :team_name, :string
  end
end
