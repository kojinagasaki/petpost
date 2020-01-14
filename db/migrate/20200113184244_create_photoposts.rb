class CreatePhotoposts < ActiveRecord::Migration[5.2]
  def change
    create_table :photoposts do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.string :title
      t.string :img
      t.string :category

      t.timestamps
    end
  end
end
