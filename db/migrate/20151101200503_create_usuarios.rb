class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome, null: false
      t.date :data_registro, null: false
      t.date :data_desligamento
      t.integer :perfil, null:false

      t.timestamps null: false
    end
  end
end
