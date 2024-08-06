class AddRazaoSocialToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :razao_social, :string
  end
end
