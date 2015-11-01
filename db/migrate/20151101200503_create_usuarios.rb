class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome, null: false
      t.string :email, null: false, unique: true
      t.string :senha, null: false
      t.date :data_registro, null: false
      t.date :data_desligamento
      t.integer :perfil, null:false

      t.timestamps null: false
    end
  end
end
