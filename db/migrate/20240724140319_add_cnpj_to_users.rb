class AddCnpjToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cnpj, :string
  end
end
