class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :html
      t.timestamps
    end
  end
end
