class AddUserToApplications < ActiveRecord::Migration[7.0]
  def change
    add_reference :applications, :user, null: false, foreign_key: true
  end
end
