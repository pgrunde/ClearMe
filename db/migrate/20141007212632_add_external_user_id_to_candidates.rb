class AddExternalUserIdToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :external_user_id, :integer
  end
end
