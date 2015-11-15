class CreateAnimais < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :nome
      t.float :peso
      t.integer :especie, null: false
      t.string :data_registro, null: false
      t.string :data_saida

      t.timestamps null: false
    end
  end
end
