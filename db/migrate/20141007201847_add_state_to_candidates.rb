class AddStateToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :state, :string
  end
end
