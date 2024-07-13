class AddProfileFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telefone, :string
    add_column :users, :graduacao, :string
    add_column :users, :habilidades_tecnicas, :string
    add_column :users, :numero_matricula, :string
    add_column :users, :periodo_curso, :string
    add_column :users, :curriculo, :string
  end
end
