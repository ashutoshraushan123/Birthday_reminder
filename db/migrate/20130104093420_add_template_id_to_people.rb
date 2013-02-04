class AddTemplateIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :template_id, :integer
  end
end
