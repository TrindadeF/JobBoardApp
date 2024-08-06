class AddNomeEmpresaToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nome_empresa, :string
  end
end
