class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.date :date
      t.string :email

      t.timestamps
    end
  end
end
