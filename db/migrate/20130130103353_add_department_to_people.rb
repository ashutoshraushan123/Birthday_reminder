class AddDepartmentToPeople < ActiveRecord::Migration
  def change
    add_column :people, :dept, :string
  end
end
