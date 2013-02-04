class CreateBirthdays < ActiveRecord::Migration
  def change
    create_table :birthdays do |t|

      t.timestamps
    end
  end
end
