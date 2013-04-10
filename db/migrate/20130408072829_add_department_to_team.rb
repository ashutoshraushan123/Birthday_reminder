class AddDepartmentToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :department, :string
  end
end
