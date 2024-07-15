class AddRecruiterIdToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :recruiter_id, :integer
    add_index :jobs, :recruiter_id
  end
end
