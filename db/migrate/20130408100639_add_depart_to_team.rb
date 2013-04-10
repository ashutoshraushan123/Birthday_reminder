class AddDepartToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :depart, :string
  end
end
