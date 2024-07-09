class AddFieldsToJobs < ActiveRecord::Migration[7.0]
  def change
    # add_column :jobs, :title, :string
    add_column :jobs, :requirements, :text
    add_column :jobs, :education, :string
  end
end
