class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :feature, null: false, foreign_key: true
    end
  end
end
