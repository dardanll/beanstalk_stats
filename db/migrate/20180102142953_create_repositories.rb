class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :title
      t.string :vcs
      t.datetime :last_commit_at
      t.datetime :created_at
      t.datetime :updated_ad

      t.timestamps null: false
    end
  end
end
