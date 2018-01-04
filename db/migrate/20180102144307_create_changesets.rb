class CreateChangesets < ActiveRecord::Migration
  def change
    create_table :changesets do |t|
      t.references :repository, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :author
      t.datetime :time
      t.boolean :too_large
      t.string :message
      t.string :email

      t.timestamps null: false
    end
  end
end
