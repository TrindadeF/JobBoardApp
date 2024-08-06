class RemoveTelefoneFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :telefone, :string
  end
end
