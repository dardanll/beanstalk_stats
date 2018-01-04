class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :name
      t.string :first_name
      t.string :last_name
      t.boolean :owner
      t.boolean :admin
      t.string :timezone

      t.timestamps null: false
    end
  end
end
