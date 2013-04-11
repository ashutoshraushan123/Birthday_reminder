class ChangeDateFormatInTemplate < ActiveRecord::Migration
  def change
    change_column :templates, :html, :text
  end
end
