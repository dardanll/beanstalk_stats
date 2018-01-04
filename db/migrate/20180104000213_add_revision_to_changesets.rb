class AddRevisionToChangesets < ActiveRecord::Migration
  def change
    add_column :changesets, :revision, :string
  end
end
