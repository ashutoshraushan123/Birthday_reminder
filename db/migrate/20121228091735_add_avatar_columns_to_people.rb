class AddAvatarColumnsToPeople < ActiveRecord::Migration
  def change
       add_attachment :people, :avatar
  end
end
